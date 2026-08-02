import SwiftUI

@main
struct GaestehausWildApp: App {
    @UIApplicationDelegateAdaptor(NotificationDelegate.self) private var notificationDelegate
    @State private var stayStore = StayStore()
    @State private var router = Router.shared

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(stayStore)
                .environment(router)
        }
    }
}
