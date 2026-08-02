import Foundation
import CoreLocation

enum Geo {
    static let guesthouse = CLLocationCoordinate2D(latitude: 49.4224662, longitude: 10.9807374)

    static func distanceInKilometres(latitude: Double, longitude: Double) -> Double {
        let origin = CLLocation(latitude: guesthouse.latitude, longitude: guesthouse.longitude)
        let destination = CLLocation(latitude: latitude, longitude: longitude)
        return origin.distance(from: destination) / 1_000
    }

    static func formattedDistance(latitude: Double, longitude: Double, language: AppLanguage) -> String {
        let value = distanceInKilometres(latitude: latitude, longitude: longitude)
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = value < 10 ? 1 : 0
        formatter.maximumFractionDigits = value < 10 ? 1 : 0
        formatter.locale = Locale(identifier: language == .de ? "de_DE" : "en_GB")
        let number = formatter.string(from: NSNumber(value: value)) ?? String(format: "%.1f", value)
        return language == .de ? "\(number) km Luftlinie" : "\(number) km straight-line"
    }
}
