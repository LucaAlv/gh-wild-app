import Foundation
import Testing

@Suite("Stay calendar")
struct StayClockTests {
    @Test("Phases switch at Berlin calendar-day boundaries")
    func phases() {
        let stay = Stay(arrival: date(2026, 8, 10), departure: date(2026, 8, 13), roomID: nil)
        #expect(StayClock.phase(for: stay, now: date(2026, 8, 9, 23, 59)) == .upcoming(daysUntilArrival: 1))
        #expect(StayClock.phase(for: stay, now: date(2026, 8, 10, 0, 1)) == .arrivalDay)
        #expect(StayClock.phase(for: stay, now: date(2026, 8, 11, 12)) == .inHouse(nightsRemaining: 2))
        #expect(StayClock.phase(for: stay, now: date(2026, 8, 13, 0, 1)) == .departureDay)
        #expect(StayClock.phase(for: stay, now: date(2026, 8, 14)) == .past(daysSinceDeparture: 1))
    }

    @Test("Night count survives both German DST changes")
    func daylightSavingTime() {
        #expect(StayClock.nights(from: date(2026, 3, 28), to: date(2026, 3, 30)) == 2)
        #expect(StayClock.nights(from: date(2026, 10, 24), to: date(2026, 10, 26)) == 2)
    }

    @Test("A one-night stay has the expected boundary phases")
    func singleNightStay() {
        let stay = Stay(arrival: date(2026, 8, 10), departure: date(2026, 8, 11), roomID: nil)
        #expect(StayClock.phase(for: stay, now: date(2026, 8, 10, 23, 59)) == .arrivalDay)
        #expect(StayClock.phase(for: stay, now: date(2026, 8, 11, 0, 1)) == .departureDay)
    }

    @Test("Only stays more than fourteen days past departure are stale")
    func staleStay() {
        let stay = Stay(arrival: date(2026, 7, 1), departure: date(2026, 7, 3), roomID: nil)
        #expect(!StayClock.isStale(stay, now: date(2026, 7, 17)))
        #expect(StayClock.isStale(stay, now: date(2026, 7, 18)))
    }

    private func date(_ year: Int, _ month: Int, _ day: Int, _ hour: Int = 12, _ minute: Int = 0) -> Date {
        StayClock.calendar.date(from: .init(year: year, month: month, day: day, hour: hour, minute: minute))!
    }
}
