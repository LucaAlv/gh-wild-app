import Foundation

struct Stay: Codable, Hashable, Sendable {
    var arrival: Date
    var departure: Date
    var roomID: String?
}

enum StayPhase: Hashable, Sendable {
    case notSet
    case upcoming(daysUntilArrival: Int)
    case arrivalDay
    case inHouse(nightsRemaining: Int)
    case departureDay
    case past(daysSinceDeparture: Int)
}

enum StayClock {
    static let calendar: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "de_DE")
        calendar.timeZone = TimeZone(identifier: "Europe/Berlin")!
        return calendar
    }()

    static func startOfDay(_ date: Date) -> Date {
        calendar.startOfDay(for: date)
    }

    static func nights(from start: Date, to end: Date) -> Int {
        calendar.dateComponents(
            [.day],
            from: startOfDay(start),
            to: startOfDay(end)
        ).day ?? 0
    }

    static func phase(for stay: Stay?, now: Date) -> StayPhase {
        guard let stay else { return .notSet }
        let today = startOfDay(now)
        let arrival = startOfDay(stay.arrival)
        let departure = startOfDay(stay.departure)

        if today < arrival {
            return .upcoming(daysUntilArrival: max(0, nights(from: today, to: arrival)))
        }
        if today == arrival { return .arrivalDay }
        if today < departure {
            return .inHouse(nightsRemaining: max(1, nights(from: today, to: departure)))
        }
        if today == departure { return .departureDay }
        return .past(daysSinceDeparture: max(0, nights(from: departure, to: today)))
    }

    static func isStale(_ stay: Stay, now: Date) -> Bool {
        guard startOfDay(now) > startOfDay(stay.departure) else { return false }
        return nights(from: stay.departure, to: now) > 14
    }

    static func checkIn(on day: Date) -> Date {
        calendar.date(bySettingHour: 15, minute: 0, second: 0, of: day)!
    }

    static func checkOut(on day: Date) -> Date {
        calendar.date(bySettingHour: 11, minute: 0, second: 0, of: day)!
    }
}
