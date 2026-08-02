import Observation

@Observable
final class Router {
    static let shared = Router()
    var pendingPage: Page?

    private init() {}
}
