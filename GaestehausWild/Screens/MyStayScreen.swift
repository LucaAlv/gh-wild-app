import SwiftUI
import UserNotifications

struct MyStayScreen: View {
    @Environment(\.appLanguage) private var language
    @Environment(StayStore.self) private var store
    @Environment(\.scenePhase) private var scenePhase
    @State private var isEditing = false
    @State private var arrival = StayClock.startOfDay(.now)
    @State private var departure = StayClock.calendar.date(byAdding: .day, value: 1, to: StayClock.startOfDay(.now))!
    @State private var roomID: String?
    @State private var authorizationStatus: UNAuthorizationStatus = .notDetermined
    @State private var showDeleteConfirmation = false
    @State private var refreshID = UUID()

    var body: some View {
        PageScaffold(title: Page.myStay.title) {
            Group {
                if store.stay == nil || isEditing {
                    stayForm
                } else {
                    phaseContent
                    reminderCard
                    managementButtons
                }
            }
            .id(refreshID)
        }
        .task { authorizationStatus = await StayNotifications.authorizationStatus() }
        .onAppear(perform: loadForm)
        .onChange(of: scenePhase) { _, phase in
            guard phase == .active else { return }
            refreshID = UUID()
            Task { authorizationStatus = await StayNotifications.authorizationStatus() }
        }
        .confirmationDialog(
            language == .de ? "Aufenthalt wirklich löschen?" : "Delete this stay?",
            isPresented: $showDeleteConfirmation,
            titleVisibility: .visible
        ) {
            Button(language == .de ? "Aufenthalt löschen" : "Delete stay", role: .destructive) {
                store.clear()
                Task { await StayNotifications.cancelAll() }
                loadForm()
            }
            Button(language == .de ? "Abbrechen" : "Cancel", role: .cancel) {}
        }
    }

    @ViewBuilder
    private var phaseContent: some View {
        switch store.phase() {
        case .notSet:
            EmptyView()
        case .upcoming(let days):
            StayPhaseHeader(
                eyebrow: .init(de: "Vorfreude", en: "Something to look forward to"),
                title: days == 1 ? Content.StayCopy.upcomingSingular : Content.StayCopy.upcoming.replacing("{n}", with: "\(days)"),
                symbol: "calendar.badge.clock"
            )
            stayDates
            if let room = store.room { roomSummary(room) }
            InfoCard(rows: [
                ("clock", .init(de: "Check-in", en: "Check-in"), .init(de: "Ab 15:00 Uhr", en: "From 3:00 pm")),
                ("parkingsign", .init(de: "Parken", en: "Parking"), Content.StayCopy.parking),
                ("key", .init(de: "Späte Anreise", en: "Late arrival"), Content.StayCopy.lateArrival)
            ])
            ActionButtonRow(includeRoute: true)

        case .arrivalDay:
            StayPhaseHeader(
                eyebrow: .init(de: "Heute geht es los", en: "Your stay starts today"),
                title: .init(de: "Herzlich willkommen", en: "A warm welcome"),
                symbol: "key"
            )
            if let stay = store.stay {
                CountdownDisplay(
                    target: StayClock.checkIn(on: stay.arrival),
                    completed: .init(de: "Check-in ist jetzt möglich", en: "Check-in is now available")
                )
                .padding(Theme.Spacing.large)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Theme.ColorToken.paper, in: RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius))
            }
            InfoCard(rows: [
                ("key", .init(de: "Schlüssel", en: "Keys"), Content.StayCopy.keyHandover),
                ("parkingsign", .init(de: "Parken", en: "Parking"), Content.StayCopy.parking)
            ])
            WiFiTile()
            ActionButtonRow(includeRoute: true)

        case .inHouse(let nights):
            StayPhaseHeader(
                eyebrow: .init(de: "Schön, dass Sie da sind", en: "Lovely to have you here"),
                title: nights == 1 ? Content.StayCopy.nightRemainingSingular : Content.StayCopy.nightsRemaining.replacing("{n}", with: "\(nights)"),
                symbol: "house.lodge"
            )
            BreakfastStatusTile()
            WiFiTile()
            InfoCard(rows: [
                ("clock.arrow.circlepath", .init(de: "Check-out", en: "Check-out"), .init(de: "Am Abreisetag bis 11:00 Uhr", en: "By 11:00 am on departure day"))
            ])

        case .departureDay:
            StayPhaseHeader(
                eyebrow: .init(de: "Abreisetag", en: "Departure day"),
                title: .init(de: "Danke, dass Sie bei uns waren", en: "Thank you for staying with us"),
                symbol: "clock.arrow.circlepath"
            )
            if let stay = store.stay {
                CountdownDisplay(
                    target: StayClock.checkOut(on: stay.departure),
                    completed: .init(de: "Check-out-Zeit erreicht", en: "Check-out time reached")
                )
                .padding(Theme.Spacing.large)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Theme.ColorToken.paper, in: RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius))
            }
            BodyText(text: Content.StayCopy.departure)
            WiFiTile()
            ActionButtonRow()

        case .past:
            StayPhaseHeader(
                eyebrow: .init(de: "Auf Wiedersehen", en: "Until next time"),
                title: .init(de: "Danke für Ihren Besuch", en: "Thank you for staying"),
                symbol: "heart"
            )
            LeadParagraph(text: .init(
                de: "Wir hoffen, Sie haben sich wohlgefühlt. Vielleicht sehen wir uns bald wieder.",
                en: "We hope you felt at home. Perhaps we will see you again soon."
            ))
            NavigationLink(value: Page.vouchers) {
                Label(language == .de ? "Gutscheine entdecken" : "Discover gift vouchers", systemImage: "gift")
                    .font(Theme.Typography.button)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .foregroundStyle(Theme.ColorToken.paper)
                    .background(Theme.ColorToken.brown, in: RoundedRectangle(cornerRadius: 14))
            }
            ShareLink(item: URL(string: "https://www.gaestehaus-wild.com/")!) {
                Label(language == .de ? "Gästehaus Wild teilen" : "Share Gästehaus Wild", systemImage: "square.and.arrow.up")
                    .font(Theme.Typography.button)
            }
        }
    }

    private var stayForm: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.large) {
            NavigationLink(value: Page.guestNow) {
                GuestQuickAccessCard()
            }
            .buttonStyle(.plain)

            LeadParagraph(text: .init(
                de: "Speichern Sie Ihre Reisedaten nur auf diesem Gerät. Die Startseite zeigt dann genau das, was gerade wichtig ist.",
                en: "Save your travel dates on this device only. The home screen will then show what matters right now."
            ))
            VStack(spacing: 0) {
                DatePicker(
                    language == .de ? "Anreise" : "Arrival",
                    selection: $arrival,
                    displayedComponents: .date
                )
                .padding(.vertical, Theme.Spacing.medium)
                Divider().overlay(Theme.ColorToken.brown.opacity(0.16))
                DatePicker(
                    language == .de ? "Abreise" : "Departure",
                    selection: $departure,
                    in: minimumDeparture...,
                    displayedComponents: .date
                )
                .padding(.vertical, Theme.Spacing.medium)
                Divider().overlay(Theme.ColorToken.brown.opacity(0.16))
                ViewThatFits(in: .horizontal) {
                    HStack {
                        roomPickerLabel
                        Spacer()
                        roomPicker
                    }
                    VStack(alignment: .leading, spacing: Theme.Spacing.small) {
                        roomPickerLabel
                        roomPicker
                    }
                }
                .padding(.vertical, Theme.Spacing.medium)
            }
            .padding(.horizontal, Theme.Spacing.large)
            .background(Theme.ColorToken.paper, in: RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius))
            .onChange(of: arrival) { _, _ in
                if departure <= arrival { departure = minimumDeparture }
            }

            Button {
                store.save(arrival: arrival, departure: departure, roomID: roomID)
                isEditing = false
            } label: {
                Label(language == .de ? "Aufenthalt speichern" : "Save stay", systemImage: "checkmark")
                    .font(Theme.Typography.button)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .foregroundStyle(Theme.ColorToken.paper)
                    .background(Theme.ColorToken.brown, in: RoundedRectangle(cornerRadius: 14))
            }
            .buttonStyle(.plain)

            if store.stay != nil {
                Button(language == .de ? "Abbrechen" : "Cancel") { isEditing = false; loadForm() }
                    .font(Theme.Typography.button)
                    .frame(maxWidth: .infinity)
            }
        }
    }

    @ViewBuilder
    private var reminderCard: some View {
        if authorizationStatus == .denied {
            HStack(alignment: .top, spacing: Theme.Spacing.medium) {
                Image(systemName: "bell.slash")
                    .foregroundStyle(Theme.ColorToken.brown)
                VStack(alignment: .leading, spacing: Theme.Spacing.small) {
                    Text(language == .de ? "Erinnerungen sind deaktiviert" : "Reminders are disabled")
                        .font(Theme.Typography.bodyStrong)
                    Link(
                        language == .de ? "In Einstellungen öffnen" : "Open Settings",
                        destination: URL(string: UIApplication.openSettingsURLString)!
                    )
                    .font(Theme.Typography.button)
                }
            }
            .padding(Theme.Spacing.large)
            .background(Theme.ColorToken.paper, in: RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius))
        } else {
            Toggle(isOn: Binding(
                get: { store.remindersEnabled },
                set: { setReminders($0) }
            )) {
                VStack(alignment: .leading, spacing: 3) {
                    Text(language == .de ? "Erinnerungen" : "Reminders")
                        .font(Theme.Typography.bodyStrong)
                    Text(language == .de ? "Wir erinnern Sie an Frühstück und Check-out. Nur auf diesem Gerät." : "We’ll remind you about breakfast and check-out. On this device only.")
                        .font(Theme.Typography.body)
                        .foregroundStyle(Theme.ColorToken.graphite)
                }
            }
            .tint(Theme.ColorToken.brown)
            .padding(Theme.Spacing.large)
            .background(Theme.ColorToken.paper, in: RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius))
        }
    }

    private var managementButtons: some View {
        VStack(spacing: Theme.Spacing.medium) {
            Button {
                loadForm()
                isEditing = true
            } label: {
                Label(language == .de ? "Aufenthalt bearbeiten" : "Edit stay", systemImage: "pencil")
                    .frame(maxWidth: .infinity)
            }
            Button(role: .destructive) { showDeleteConfirmation = true } label: {
                Label(language == .de ? "Aufenthalt löschen" : "Delete stay", systemImage: "trash")
                    .frame(maxWidth: .infinity)
            }
        }
        .font(Theme.Typography.button)
    }

    private var stayDates: some View {
        Group {
            if let stay = store.stay {
                InfoCard(rows: [
                    ("calendar", .init(de: "Anreise", en: "Arrival"), .init(de: date(stay.arrival), en: date(stay.arrival))),
                    ("calendar.badge.checkmark", .init(de: "Abreise", en: "Departure"), .init(de: date(stay.departure), en: date(stay.departure)))
                ])
            }
        }
    }

    private func roomSummary(_ room: Room) -> some View {
        InfoRow(symbol: "bed.double", label: .init(de: "Ihr Zimmer", en: "Your room"), value: room.name)
            .padding(Theme.Spacing.large)
            .background(Theme.ColorToken.paper, in: RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius))
    }

    private var minimumDeparture: Date {
        StayClock.calendar.date(byAdding: .day, value: 1, to: StayClock.startOfDay(arrival))!
    }

    private var roomPickerLabel: some View {
        Text(language == .de ? "Zimmer (optional)" : "Room (optional)")
    }

    private var roomPicker: some View {
        Picker(language == .de ? "Zimmer (optional)" : "Room (optional)", selection: $roomID) {
            Text(language == .de ? "Nicht auswählen" : "No selection").tag(String?.none)
            ForEach(Content.rooms) { room in
                Text(room.name[language]).tag(Optional(room.id))
            }
        }
        .labelsHidden()
    }

    private func loadForm() {
        guard let stay = store.stay else {
            arrival = StayClock.startOfDay(.now)
            departure = minimumDeparture
            roomID = nil
            return
        }
        arrival = stay.arrival
        departure = stay.departure
        roomID = stay.roomID
    }

    private func setReminders(_ enabled: Bool) {
        if !enabled {
            store.setRemindersEnabled(false)
            Task { await StayNotifications.cancelAll() }
            return
        }
        Task {
            let granted: Bool
            if authorizationStatus == .authorized {
                granted = true
            } else {
                granted = await StayNotifications.requestAuthorization()
            }
            authorizationStatus = await StayNotifications.authorizationStatus()
            store.setRemindersEnabled(granted)
            await StayNotifications.reschedule(for: store.stay, language: language, enabled: granted)
        }
    }

    private func date(_ value: Date) -> String {
        value.formatted(.dateTime.weekday(.wide).day().month(.wide).year().locale(Locale(identifier: language == .de ? "de_DE" : "en_GB")))
    }
}

private struct StayPhaseHeader: View {
    @Environment(\.appLanguage) private var language
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    let eyebrow: LocalizedText
    let title: LocalizedText
    let symbol: String

    var body: some View {
        let layout = dynamicTypeSize.isAccessibilitySize
            ? AnyLayout(VStackLayout(alignment: .leading, spacing: Theme.Spacing.large))
            : AnyLayout(HStackLayout(alignment: .top, spacing: Theme.Spacing.large))
        layout {
            Image(systemName: symbol)
                .font(.system(size: 24, weight: .medium))
                .foregroundStyle(Theme.ColorToken.paper)
                .frame(width: 56, height: 56)
                .background(Theme.ColorToken.brown, in: Circle())
            VStack(alignment: .leading, spacing: Theme.Spacing.xSmall) {
                Text(eyebrow[language].uppercased())
                    .font(Theme.Typography.caption)
                    .tracking(1.5)
                    .foregroundStyle(Theme.ColorToken.brown)
                Text(title[language])
                    .font(Theme.Typography.title)
                    .foregroundStyle(Theme.ColorToken.ink)
            }
        }
    }
}
