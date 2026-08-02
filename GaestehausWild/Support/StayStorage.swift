import Foundation

enum StayDefaults {
    static var store: UserDefaults { .standard }

    enum Key {
        static let stay = "stay.v1"
        static let reminders = "stay.remindersEnabled"
    }
}
