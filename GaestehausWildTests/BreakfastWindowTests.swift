import Foundation
import Testing

@Suite("Breakfast window")
struct BreakfastWindowTests {
    let weekday = BreakfastWindow(startHour: 7, startMinute: 0, endHour: 10, endMinute: 0)
    let sunday = BreakfastWindow(startHour: 8, startMinute: 0, endHour: 10, endMinute: 0)

    @Test("Before, during and after breakfast")
    func dailyStates() {
        let before = date(2026, 8, 3, 6, 30)
        let during = date(2026, 8, 3, 8, 15)
        let after = date(2026, 8, 3, 10, 30)
        #expect(BreakfastWindow.state(now: before, weekday: weekday, sunday: sunday) == .opensToday(at: date(2026, 8, 3, 7)))
        #expect(BreakfastWindow.state(now: during, weekday: weekday, sunday: sunday) == .openNow(until: date(2026, 8, 3, 10)))
        #expect(BreakfastWindow.state(now: after, weekday: weekday, sunday: sunday) == .closedUntil(next: date(2026, 8, 4, 7)))
    }

    @Test("Sunday uses its later opening time")
    func sundayWindow() {
        let now = date(2026, 8, 2, 7, 30)
        #expect(BreakfastWindow.state(now: now, weekday: weekday, sunday: sunday) == .opensToday(at: date(2026, 8, 2, 8)))
    }

    @Test("Saturday after closing rolls over to Sunday's window")
    func sundayRollover() {
        let now = date(2026, 8, 1, 10, 30)
        #expect(BreakfastWindow.state(now: now, weekday: weekday, sunday: sunday) == .closedUntil(next: date(2026, 8, 2, 8)))
    }

    private func date(_ year: Int, _ month: Int, _ day: Int, _ hour: Int, _ minute: Int = 0) -> Date {
        StayClock.calendar.date(from: .init(year: year, month: month, day: day, hour: hour, minute: minute))!
    }
}
