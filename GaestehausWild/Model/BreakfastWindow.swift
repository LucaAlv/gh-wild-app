import Foundation

struct BreakfastWindow: Hashable, Sendable {
    let startHour: Int
    let startMinute: Int
    let endHour: Int
    let endMinute: Int
}

enum BreakfastState: Hashable, Sendable {
    case opensToday(at: Date)
    case openNow(until: Date)
    case closedUntil(next: Date)
}

extension BreakfastWindow {
    static func state(
        now: Date,
        weekday: BreakfastWindow,
        sunday: BreakfastWindow
    ) -> BreakfastState {
        let calendar = StayClock.calendar
        let today = calendar.startOfDay(for: now)
        let window = calendar.component(.weekday, from: today) == 1 ? sunday : weekday
        let start = calendar.date(
            bySettingHour: window.startHour,
            minute: window.startMinute,
            second: 0,
            of: today
        )!
        let end = calendar.date(
            bySettingHour: window.endHour,
            minute: window.endMinute,
            second: 0,
            of: today
        )!

        if now < start { return .opensToday(at: start) }
        if now < end { return .openNow(until: end) }

        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
        let nextWindow = calendar.component(.weekday, from: tomorrow) == 1 ? sunday : weekday
        let next = calendar.date(
            bySettingHour: nextWindow.startHour,
            minute: nextWindow.startMinute,
            second: 0,
            of: tomorrow
        )!
        return .closedUntil(next: next)
    }
}
