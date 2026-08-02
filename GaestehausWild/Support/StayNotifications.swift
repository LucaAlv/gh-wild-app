import Foundation
import UserNotifications

enum StayNotifications {
    static func authorizationStatus() async -> UNAuthorizationStatus {
        await UNUserNotificationCenter.current().notificationSettings().authorizationStatus
    }

    static func requestAuthorization() async -> Bool {
        (try? await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound])) ?? false
    }

    static func reschedule(
        for stay: Stay?,
        language: AppLanguage,
        enabled: Bool,
        now: Date = .now
    ) async {
        await cancelAll()
        guard enabled, let stay else { return }
        guard await authorizationStatus() == .authorized else { return }

        let center = UNUserNotificationCenter.current()
        for item in StayNotificationSchedule.requests(for: stay, now: now) {
            let copy = copy(for: item.kind, language: language, date: item.date)
            let content = UNMutableNotificationContent()
            content.title = copy.title
            content.body = copy.body
            content.sound = .default
            content.userInfo = ["page": Page.myStay.rawValue]

            let components = StayClock.calendar.dateComponents(
                [.calendar, .timeZone, .year, .month, .day, .hour, .minute],
                from: item.date
            )
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            try? await center.add(.init(identifier: item.identifier, content: content, trigger: trigger))
        }
    }

    static func cancelAll() async {
        let center = UNUserNotificationCenter.current()
        let requests = await center.pendingNotificationRequests()
        let delivered = await center.deliveredNotifications()
        let identifiers = Set(
            (requests.map(\.identifier) + delivered.map { $0.request.identifier })
                .filter { $0.hasPrefix("stay.") }
        )
        center.removePendingNotificationRequests(withIdentifiers: Array(identifiers))
        center.removeDeliveredNotifications(withIdentifiers: Array(identifiers))
    }

    #if DEBUG
    static func debugCompressSchedule(language: AppLanguage) async {
        await cancelAll()
        guard await requestAuthorization() else { return }
        let center = UNUserNotificationCenter.current()
        let kinds: [StayNotificationKind] = [.welcome, .breakfast, .checkout, .thanks]
        for (index, kind) in kinds.enumerated() {
            let content = UNMutableNotificationContent()
            let text = copy(for: kind, language: language, date: .now)
            content.title = text.title
            content.body = text.body
            content.sound = .default
            content.userInfo = ["page": Page.myStay.rawValue]
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double((index + 1) * 10), repeats: false)
            try? await center.add(.init(identifier: "stay.debug.\(index)", content: content, trigger: trigger))
        }
    }
    #endif

    private static func copy(for kind: StayNotificationKind, language: AppLanguage, date: Date) -> (title: String, body: String) {
        switch kind {
        case .welcome:
            return (Content.Notifications.welcomeTitle[language], Content.Notifications.welcomeBody[language])
        case .breakfast:
            let sunday = StayClock.calendar.component(.weekday, from: date) == 1
            let window = sunday ? Content.Breakfast.sunday : Content.Breakfast.weekday
            let time = String(format: "%d:%02d", window.startHour, window.startMinute)
            return (Content.Notifications.breakfastTitle[language], Content.Notifications.breakfastBody.replacing("{time}", with: time)[language])
        case .checkout:
            return (Content.Notifications.checkoutTitle[language], Content.Notifications.checkoutBody[language])
        case .thanks:
            return (Content.Notifications.thanksTitle[language], Content.Notifications.thanksBody[language])
        }
    }
}
