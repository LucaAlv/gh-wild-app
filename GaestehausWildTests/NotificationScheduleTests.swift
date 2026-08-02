import Foundation
import Testing

@Suite("Notification schedule")
struct NotificationScheduleTests {
    @Test("Three nights create welcome, three breakfasts, checkout and thanks")
    func threeNightStay() {
        let stay = Stay(arrival: date(2026, 8, 10), departure: date(2026, 8, 13), roomID: nil)
        let requests = StayNotificationSchedule.requests(for: stay, now: date(2026, 8, 1))
        #expect(requests.map(\.identifier) == [
            "stay.welcome", "stay.breakfast.0", "stay.breakfast.1", "stay.breakfast.2", "stay.checkout", "stay.thanks"
        ])
        #expect(StayClock.calendar.component(.hour, from: requests[1].date) == 7)
        #expect(StayClock.calendar.component(.minute, from: requests[1].date) == 45)
        #expect(StayClock.calendar.component(.day, from: requests[1].date) == 11)
        #expect(StayClock.calendar.component(.hour, from: requests[4].date) == 19)
        #expect(StayClock.calendar.component(.day, from: requests[4].date) == 12)
        #expect(StayClock.calendar.component(.hour, from: requests[5].date) == 11)
        #expect(StayClock.calendar.component(.day, from: requests[5].date) == 14)
    }

    @Test("Past requests are suppressed")
    func suppressPast() {
        let stay = Stay(arrival: date(2026, 8, 1), departure: date(2026, 8, 4), roomID: nil)
        let requests = StayNotificationSchedule.requests(for: stay, now: date(2026, 8, 3, 12))
        #expect(requests.map(\.identifier) == ["stay.breakfast.2", "stay.checkout", "stay.thanks"])
    }

    @Test("Breakfast reminders clamp at fourteen")
    func clampLongStay() {
        let stay = Stay(arrival: date(2026, 8, 10), departure: date(2026, 8, 30), roomID: nil)
        let requests = StayNotificationSchedule.requests(for: stay, now: date(2026, 8, 1))
        #expect(requests.filter { $0.kind == .breakfast }.count == 14)
    }

    private func date(_ year: Int, _ month: Int, _ day: Int, _ hour: Int = 0) -> Date {
        StayClock.calendar.date(from: .init(year: year, month: month, day: day, hour: hour))!
    }
}
