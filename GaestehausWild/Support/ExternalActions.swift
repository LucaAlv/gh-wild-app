import Foundation
import MapKit

enum ExternalActions {
    static let phone = URL(string: Content.phoneURL)!
    static let email = URL(string: "mailto:\(Content.email)")!
    static let instagram = URL(string: "https://www.instagram.com/gaestehaus.wild/")!

    static func mapsURL(latitude: Double = 49.4224662, longitude: Double = 10.9807374, name: String = "Gästehaus Wild") -> URL {
        var components = URLComponents(string: "https://maps.apple.com/")!
        components.queryItems = [
            URLQueryItem(name: "ll", value: "\(latitude),\(longitude)"),
            URLQueryItem(name: "q", value: name)
        ]
        return components.url!
    }
}
