import Foundation

enum DeepLink: Hashable, Sendable {
    case page(Page)
    case nearby(placeID: String)

    static func parse(_ url: URL) -> DeepLink? {
        guard url.scheme?.lowercased() == "gaestehauswild",
              url.user == nil,
              url.password == nil,
              url.port == nil,
              url.query == nil,
              url.fragment == nil else {
            return nil
        }

        let host = url.host?.lowercased()
        let components = url.pathComponents.filter { $0 != "/" }

        switch host {
        case "gast" where components.isEmpty:
            return .page(.guestNow)
        case "page" where components.count == 1:
            guard let rawValue = components.first,
                  let page = Page(rawValue: rawValue) else { return nil }
            return .page(page)
        case "nearby" where components.count == 1:
            guard let placeID = components.first, !placeID.isEmpty else { return nil }
            return .nearby(placeID: placeID)
        default:
            return nil
        }
    }

    var url: URL? {
        switch self {
        case .page(.guestNow):
            return URL(string: "gaestehauswild://gast")
        case .page(let page):
            return URL(string: "gaestehauswild://page/\(page.rawValue)")
        case .nearby(let placeID):
            var components = URLComponents()
            components.scheme = "gaestehauswild"
            components.host = "nearby"
            components.path = "/\(placeID)"
            return components.url
        }
    }
}
