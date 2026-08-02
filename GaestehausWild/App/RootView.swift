import SwiftUI

struct RootView: View {
    @Environment(StayStore.self) private var stayStore
    @Environment(Router.self) private var router
    @Environment(\.scenePhase) private var scenePhase
    @AppStorage("languagePreference") private var languagePreference = "system"
    @State private var path = NavigationPath()
    @State private var isMenuPresented = false
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
                .navigationDestination(for: NearbyPlace.self) { place in
                    NearbyDetailScreen(place: place)
                }
        }
        .tint(Theme.ColorToken.brown)
        .environment(\.appLanguage, language)
        .fullScreenCover(isPresented: $isMenuPresented, onDismiss: navigateToPendingPage) {
            @Bindable var router = router
            MenuSheet(selectedPage: $router.pendingPage, languagePreference: $languagePreference)
                .environment(\.appLanguage, language)
        }
        .onAppear {
            applyDebugRouteIfNeeded()
            if router.pendingPage != nil { navigateToPendingPage() }
        }
        .onChange(of: router.pendingPage) { _, page in
            guard page != nil else { return }
            if isMenuPresented {
                isMenuPresented = false
            } else {
                navigateToPendingPage()
            }
        }
        .onChange(of: language) { _, newLanguage in
            Task {
                await StayNotifications.reschedule(
                    for: stayStore.stay,
                    language: newLanguage,
                    enabled: stayStore.remindersEnabled
                )
            }
        }
        .onChange(of: stayStore.stay) { _, stay in
            Task {
                await StayNotifications.reschedule(
                    for: stay,
                    language: language,
                    enabled: stayStore.remindersEnabled
                )
            }
        }
        .onChange(of: stayStore.remindersEnabled) { _, enabled in
            Task {
                await StayNotifications.reschedule(
                    for: stayStore.stay,
                    language: language,
                    enabled: enabled
                )
            }
        }
        .onChange(of: scenePhase) { _, phase in
            guard phase == .active else { return }
            Task {
                await StayNotifications.reschedule(
                    for: stayStore.stay,
                    language: language,
                    enabled: stayStore.remindersEnabled
                )
            }
        }
    }

    private func navigateToPendingPage() {
        guard let pendingPage = router.pendingPage else { return }
        path.append(pendingPage)
        router.pendingPage = nil
    }

    private func applyDebugRouteIfNeeded() {
        guard !didApplyDebugRoute else { return }
        didApplyDebugRoute = true
        #if DEBUG
        if let arrivalOffset = debugInteger(for: "debugStayArrivalOffset"),
           let departureOffset = debugInteger(for: "debugStayDepartureOffset") {
            let today = StayClock.startOfDay(.now)
            let arrival = StayClock.calendar.date(byAdding: .day, value: arrivalOffset, to: today)!
            let departure = StayClock.calendar.date(byAdding: .day, value: departureOffset, to: today)!
            stayStore.save(arrival: arrival, departure: departure, roomID: nil)
        }
        if debugBoolean(for: "debugCompressNotifications") {
            Task { await StayNotifications.debugCompressSchedule(language: language) }
        }
        if let raw = UserDefaults.standard.string(forKey: "startPage"),
           let page = Page(rawValue: raw) {
            path.append(page)
        }
        #endif
    }

    #if DEBUG
    private func debugInteger(for key: String) -> Int? {
        if let value = UserDefaults.standard.object(forKey: key) as? NSNumber {
            return value.intValue
        }
        let arguments = ProcessInfo.processInfo.arguments
        guard let index = arguments.firstIndex(of: "-\(key)"), arguments.indices.contains(index + 1) else {
            return nil
        }
        return Int(arguments[index + 1])
    }

    private func debugBoolean(for key: String) -> Bool {
        if UserDefaults.standard.bool(forKey: key) { return true }
        let arguments = ProcessInfo.processInfo.arguments
        guard let index = arguments.firstIndex(of: "-\(key)"), arguments.indices.contains(index + 1) else {
            return false
        }
        return ["1", "true", "yes"].contains(arguments[index + 1].lowercased())
    }
    #endif
}

private struct ScreenRouter: View {
    let page: Page

    @ViewBuilder
    var body: some View {
        switch page {
        case .myStay: MyStayScreen()
        case .rooms: RoomsScreen()
        case .breakfast: BreakfastScreen()
        case .garden: GardenScreen()
        case .goodToKnow: GoodToKnowScreen()
        case .about: AboutScreen()
        case .gallery: GalleryScreen()
        case .services: ServicesScreen()
        case .vouchers: VouchersScreen()
        case .nearby: NearbyScreen()
        case .arrival: ArrivalScreen()
        case .contact: ContactScreen()
        case .impressum: LegalScreen(document: Content.impressum)
        case .datenschutz: LegalScreen(document: Content.privacy)
        case .agb: LegalScreen(document: Content.terms)
        }
    }
}
