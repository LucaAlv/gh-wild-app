import Observation

@Observable
final class Router {
    static let shared = Router()
    var pendingPage: Page?
    var pendingPlaceID: String?

    private init() {}

    func open(_ deepLink: DeepLink) {
        switch deepLink {
        case .page(let page):
            pendingPlaceID = nil
            pendingPage = page
        case .nearby(let placeID):
            pendingPage = nil
            pendingPlaceID = placeID
        }
    }
}
