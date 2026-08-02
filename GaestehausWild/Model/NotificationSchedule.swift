import Foundation

struct StayNotificationRequest: Hashable, Sendable {
    let identifier: String
    let date: Date
    let kind: StayNotificationKind
}

enum StayNotificationKind: Hashable, Sendable {
    case welcome, breakfast, checkout, thanks
}

enum StayNotificationSchedule {
    static func requests(for stay: Stay, now: Date) -> [StayNotificationRequest] {
        let calendar = StayClock.calendar
        var requests: [StayNotificationRequest] = []

        append(
            id: "stay.welcome",
            date: time(hour: 13, on: stay.arrival),
            kind: .welcome,
            now: now,
            to: &requests
        )

        let nights = max(0, StayClock.nights(from: stay.arrival, to: stay.departure))
        for offset in 0..<min(nights, 14) {
            // The first breakfast reminder is after the first night, never before check-in.
            guard let morning = calendar.date(byAdding: .day, value: offset + 1, to: stay.arrival) else { continue }
            append(
                id: "stay.breakfast.\(offset)",
                date: time(hour: 7, minute: 45, on: morning),
                kind: .breakfast,
                now: now,
                to: &requests
            )
        }

        if let eveningBefore = calendar.date(byAdding: .day, value: -1, to: stay.departure) {
            append(
                id: "stay.checkout",
                date: time(hour: 19, on: eveningBefore),
                kind: .checkout,
                now: now,
                to: &requests
            )
        }
        if let dayAfter = calendar.date(byAdding: .day, value: 1, to: stay.departure) {
            append(
                id: "stay.thanks",
                date: time(hour: 11, on: dayAfter),
                kind: .thanks,
                now: now,
                to: &requests
            )
        }
        return requests
    }

    private static func time(hour: Int, minute: Int = 0, on day: Date) -> Date {
        StayClock.calendar.date(bySettingHour: hour, minute: minute, second: 0, of: day)!
    }

    private static func append(
        id: String,
        date: Date,
        kind: StayNotificationKind,
        now: Date,
        to requests: inout [StayNotificationRequest]
    ) {
        guard date > now else { return }
        requests.append(.init(identifier: id, date: date, kind: kind))
    }
}
