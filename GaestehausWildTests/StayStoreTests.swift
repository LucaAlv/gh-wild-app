import Foundation
import Testing

@Suite("Stay storage")
struct StayStoreTests {
    @Test("Injected defaults persist clamped dates and reminder preference")
    func injectedDefaults() throws {
        let suiteName = "StayStoreTests.\(UUID().uuidString)"
        let defaults = try #require(UserDefaults(suiteName: suiteName))
        defer { defaults.removePersistentDomain(forName: suiteName) }

        let arrival = date(2026, 8, 10)
        let store = StayStore(defaults: defaults)
        store.save(arrival: arrival, departure: arrival, roomID: "room-1")
        store.setRemindersEnabled(true)

        let restored = StayStore(defaults: defaults)
        #expect(restored.stay?.arrival == arrival)
        #expect(restored.stay?.departure == date(2026, 8, 11))
        #expect(restored.stay?.roomID == "room-1")
        #expect(restored.remindersEnabled)

        restored.clear()
        #expect(defaults.data(forKey: StayDefaults.Key.stay) == nil)
        #expect(!defaults.bool(forKey: StayDefaults.Key.reminders))
    }

    private func date(_ year: Int, _ month: Int, _ day: Int) -> Date {
        StayClock.calendar.date(from: .init(year: year, month: month, day: day))!
    }
}
