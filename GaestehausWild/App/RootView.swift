import SwiftUI

struct RootView: View {
    @AppStorage("languagePreference") private var languagePreference = "system"
    @State private var path = NavigationPath()
    @State private var isMenuPresented = false
    @State private var pendingPage: Page?
    @State private var didApplyDebugRoute = false

    private var language: AppLanguage {
        AppLanguage.resolved(preference: languagePreference == "system" ? nil : languagePreference)
    }

    var body: some View {
        NavigationStack(path: $path) {
            HomeScreen()
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isMenuPresented = true
                        } label: {
                            Image(systemName: "line.3.horizontal")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(Theme.ColorToken.ink)
                                .frame(width: 44, height: 44)
                        }
                        .accessibilityLabel(language == .de ? "Menü öffnen" : "Open menu")
                    }
                }
                .navigationDestination(for: Page.self) { page in
                    ScreenRouter(page: page)
                }
                .navigationDestination(for: Room.self) { room in
                    RoomDetailScreen(room: room)
                }
        }
        .tint(Theme.ColorToken.brown)
        .environment(\.appLanguage, language)
        .fullScreenCover(isPresented: $isMenuPresented, onDismiss: navigateToPendingPage) {
            MenuSheet(selectedPage: $pendingPage, languagePreference: $languagePreference)
                .environment(\.appLanguage, language)
        }
        .onAppear(perform: applyDebugRouteIfNeeded)
    }

    private func navigateToPendingPage() {
        guard let pendingPage else { return }
        path.append(pendingPage)
        self.pendingPage = nil
    }

    private func applyDebugRouteIfNeeded() {
        guard !didApplyDebugRoute else { return }
        didApplyDebugRoute = true
        #if DEBUG
        if let raw = UserDefaults.standard.string(forKey: "startPage"),
           let page = Page(rawValue: raw) {
            path.append(page)
        }
        #endif
    }
}

private struct ScreenRouter: View {
    let page: Page

    @ViewBuilder
    var body: some View {
        switch page {
        case .rooms: RoomsScreen()
        case .breakfast: BreakfastScreen()
        case .garden: GardenScreen()
        case .goodToKnow: GoodToKnowScreen()
        case .about: AboutScreen()
        case .gallery: GalleryScreen()
        case .services: ServicesScreen()
        case .vouchers: VouchersScreen()
        case .nearby: NearbyScreen()
        case .contact: ContactScreen()
        case .impressum: LegalScreen(document: Content.impressum)
        case .datenschutz: LegalScreen(document: Content.privacy)
        case .agb: LegalScreen(document: Content.terms)
        }
    }
}
