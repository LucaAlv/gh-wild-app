import Foundation
import Observation

@Observable
final class StayStore {
    @ObservationIgnored private let defaults: UserDefaults
    private(set) var stay: Stay?
    private(set) var remindersEnabled: Bool

    init(defaults: UserDefaults = StayDefaults.store) {
        self.defaults = defaults
        if let data = defaults.data(forKey: StayDefaults.Key.stay) {
            stay = try? JSONDecoder().decode(Stay.self, from: data)
        } else {
            stay = nil
        }
        remindersEnabled = defaults.bool(forKey: StayDefaults.Key.reminders)

        if let stay, StayClock.isStale(stay, now: .now) {
            self.stay = nil
            remindersEnabled = false
            defaults.removeObject(forKey: StayDefaults.Key.stay)
            defaults.removeObject(forKey: StayDefaults.Key.reminders)
        }
    }

    func save(arrival: Date, departure: Date, roomID: String?) {
        let arrival = StayClock.startOfDay(arrival)
        var departure = StayClock.startOfDay(departure)
        if departure <= arrival {
            departure = StayClock.calendar.date(byAdding: .day, value: 1, to: arrival)!
        }
        let stay = Stay(arrival: arrival, departure: departure, roomID: roomID)
        self.stay = stay
        if let data = try? JSONEncoder().encode(stay) {
            defaults.set(data, forKey: StayDefaults.Key.stay)
        }
    }

    func setRemindersEnabled(_ enabled: Bool) {
        remindersEnabled = enabled
        defaults.set(enabled, forKey: StayDefaults.Key.reminders)
    }

    func clear() {
        stay = nil
        remindersEnabled = false
        defaults.removeObject(forKey: StayDefaults.Key.stay)
        defaults.removeObject(forKey: StayDefaults.Key.reminders)
    }

    func phase(now: Date = .now) -> StayPhase {
        StayClock.phase(for: stay, now: now)
    }

    var room: Room? {
        Content.rooms.first { $0.id == stay?.roomID }
    }
}
