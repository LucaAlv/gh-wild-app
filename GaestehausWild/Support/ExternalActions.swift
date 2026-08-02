import Foundation
import MapKit

enum ExternalActions {
    static let phone = URL(string: Content.phoneURL)!
    static let email = URL(string: "mailto:\(Content.email)")!
    static let instagram = URL(string: "https://www.instagram.com/gaestehaus.wild/")!

    static func mapsURL(
        latitude: Double = Geo.guesthouse.latitude,
        longitude: Double = Geo.guesthouse.longitude,
        name: String = "Gästehaus Wild"
    ) -> URL {
        var components = URLComponents(string: "https://maps.apple.com/")!
        components.queryItems = [
            URLQueryItem(name: "ll", value: "\(latitude),\(longitude)"),
            URLQueryItem(name: "q", value: name)
        ]
        return components.url!
    }

    static func mapsSearchURL(query: String) -> URL {
        var components = URLComponents(string: "https://maps.apple.com/")!
        components.queryItems = [URLQueryItem(name: "q", value: query)]
        return components.url!
    }
}
