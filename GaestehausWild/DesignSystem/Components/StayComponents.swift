import SwiftUI
import UIKit

struct StayInviteCard: View {
    @Environment(\.appLanguage) private var language
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    var body: some View {
        let layout = dynamicTypeSize.isAccessibilitySize
            ? AnyLayout(VStackLayout(alignment: .leading, spacing: Theme.Spacing.large))
            : AnyLayout(HStackLayout(alignment: .center, spacing: Theme.Spacing.large))
        layout {
            Image(systemName: "suitcase")
                .font(.system(size: 24, weight: .medium))
                .foregroundStyle(Theme.ColorToken.brown)
                .frame(width: 48, height: 48)
                .background(Theme.ColorToken.brown.opacity(0.1), in: Circle())
            VStack(alignment: .leading, spacing: Theme.Spacing.xSmall) {
                Text(language == .de ? "Ihre Reise auf einen Blick" : "Your trip at a glance")
                    .font(Theme.Typography.title2)
                    .foregroundStyle(Theme.ColorToken.ink)
                Text(language == .de ? "Reisedaten speichern und WLAN, Frühstück und Abreise passend zum Aufenthalt sehen." : "Save your dates to see Wi-Fi, breakfast and departure details at the right time.")
                    .font(Theme.Typography.body)
                    .foregroundStyle(Theme.ColorToken.graphite)
                Label(language == .de ? "Aufenthalt einrichten" : "Set up your stay", systemImage: "arrow.right")
                    .font(Theme.Typography.button)
                    .foregroundStyle(Theme.ColorToken.brown)
                    .padding(.top, 2)
            }
        }
        .padding(Theme.Spacing.large)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Theme.ColorToken.paper, in: RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius))
        .overlay { RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius).stroke(Theme.ColorToken.brown.opacity(0.18)) }
    }
}

struct StayStatusCard: View {
    @Environment(\.appLanguage) private var language
    @Environment(StayStore.self) private var store
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @State private var refreshID = UUID()

    var body: some View {
        Group {
            switch store.phase() {
            case .notSet:
                StayInviteCard()
            case .upcoming(let days):
                status(
                    eyebrow: language == .de ? "Ihre nächste Reise" : "Your next trip",
                    title: days == 1
                        ? Content.StayCopy.upcomingSingular[language]
                        : Content.StayCopy.upcoming.replacing("{n}", with: "\(days)")[language],
                    symbol: "calendar.badge.clock"
                )
            case .arrivalDay:
                status(
                    eyebrow: language == .de ? "Heute geht es los" : "Your stay starts today",
                    title: language == .de ? "Willkommen – Check-in ab 15:00 Uhr" : "Welcome—check-in from 3:00 pm",
                    symbol: "key"
                )
            case .inHouse(let nights):
                status(
                    eyebrow: language == .de ? "Schön, dass Sie da sind" : "Lovely to have you here",
                    title: nights == 1
                        ? Content.StayCopy.nightRemainingSingular[language]
                        : Content.StayCopy.nightsRemaining.replacing("{n}", with: "\(nights)")[language],
                    symbol: "house.lodge"
                )
            case .departureDay:
                status(
                    eyebrow: language == .de ? "Abreisetag" : "Departure day",
                    title: language == .de ? "Check-out bis 11:00 Uhr" : "Check-out by 11:00 am",
                    symbol: "clock.arrow.circlepath"
                )
            case .past:
                status(
                    eyebrow: language == .de ? "Auf Wiedersehen" : "Until next time",
                    title: language == .de ? "Danke für Ihren Besuch" : "Thank you for staying",
                    symbol: "heart"
                )
            }
        }
        .id(refreshID)
        .onChange(of: scenePhase) { _, phase in
            if phase == .active { refreshID = UUID() }
        }
    }

    private func status(eyebrow: String, title: String, symbol: String) -> some View {
        let layout = dynamicTypeSize.isAccessibilitySize
            ? AnyLayout(VStackLayout(alignment: .leading, spacing: Theme.Spacing.large))
            : AnyLayout(HStackLayout(alignment: .center, spacing: Theme.Spacing.large))
        return layout {
            Image(systemName: symbol)
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(Theme.ColorToken.paper)
                .frame(width: 50, height: 50)
                .background(Theme.ColorToken.brown, in: Circle())
            VStack(alignment: .leading, spacing: Theme.Spacing.xSmall) {
                Text(eyebrow.uppercased())
                    .font(Theme.Typography.caption)
                    .tracking(1.4)
                    .foregroundStyle(Theme.ColorToken.brown)
                Text(title)
                    .font(Theme.Typography.title2)
                    .foregroundStyle(Theme.ColorToken.ink)
                Label(language == .de ? "Aufenthalt öffnen" : "Open your stay", systemImage: "arrow.right")
                    .font(Theme.Typography.button)
                    .foregroundStyle(Theme.ColorToken.brown)
            }
        }
        .padding(Theme.Spacing.large)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Theme.ColorToken.paper, in: RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius))
        .shadow(color: .black.opacity(0.06), radius: 12, y: 5)
    }
}

struct QRCodeView: View {
    let ssid: String
    let password: String

    var body: some View {
        Group {
            if let image = WiFiQR.image(ssid: ssid, password: password) {
                Image(decorative: image, scale: 1)
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
            } else {
                Image(systemName: "qrcode")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.black)
            }
        }
        .padding(12)
        .frame(width: 172, height: 172)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .accessibilityLabel("Wi-Fi QR code")
    }
}

struct WiFiTile: View {
    @Environment(\.appLanguage) private var language
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @State private var didCopy = false

    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.large) {
            SectionHeader(eyebrow: .init(de: "Nur für Hausgäste", en: "For guests only"), title: .init(de: "WLAN", en: "Wi-Fi"))
            let layout = dynamicTypeSize.isAccessibilitySize
                ? AnyLayout(VStackLayout(alignment: .leading, spacing: Theme.Spacing.large))
                : AnyLayout(HStackLayout(alignment: .center, spacing: Theme.Spacing.large))
            layout {
                QRCodeView(ssid: Content.WiFi.ssid, password: Content.WiFi.password)
                VStack(alignment: .leading, spacing: Theme.Spacing.medium) {
                    VStack(alignment: .leading, spacing: 3) {
                        Text(language == .de ? "Netzwerk" : "Network")
                            .font(Theme.Typography.caption)
                            .foregroundStyle(Theme.ColorToken.brown)
                        Text(Content.WiFi.ssid)
                            .font(Theme.Typography.bodyStrong)
                    }
                    VStack(alignment: .leading, spacing: 3) {
                        Text(language == .de ? "Passwort" : "Password")
                            .font(Theme.Typography.caption)
                            .foregroundStyle(Theme.ColorToken.brown)
                        Text(Content.WiFi.password)
                            .font(Theme.Typography.body)
                            .textSelection(.enabled)
                    }
                    Button {
                        UIPasteboard.general.string = Content.WiFi.password
                        didCopy = true
                    } label: {
                        Label(
                            didCopy ? (language == .de ? "Kopiert" : "Copied") : (language == .de ? "Passwort kopieren" : "Copy password"),
                            systemImage: didCopy ? "checkmark" : "doc.on.doc"
                        )
                        .font(Theme.Typography.button)
                    }
                }
            }
        }
        .padding(Theme.Spacing.large)
        .background(Theme.ColorToken.paper, in: RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius))
    }
}

struct BreakfastStatusTile: View {
    @Environment(\.appLanguage) private var language
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.medium) {
            if dynamicTypeSize.isAccessibilitySize {
                VStack(alignment: .leading, spacing: Theme.Spacing.medium) {
                    breakfastTitle
                    priceBadge
                }
            } else {
                HStack {
                    breakfastTitle
                    Spacer()
                    priceBadge
                }
            }
            TimelineView(.periodic(from: .now, by: 60)) { context in
                breakfastStatus(now: context.date)
            }
        }
        .padding(Theme.Spacing.large)
        .background(Theme.ColorToken.paper, in: RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius))
    }

    private var breakfastTitle: some View {
        Label(language == .de ? "Frühstück" : "Breakfast", systemImage: "cup.and.saucer.fill")
            .font(Theme.Typography.title2)
    }

    private var priceBadge: some View {
        Text(language == .de ? "\(Content.Breakfast.price) € p. P." : "€\(Content.Breakfast.price) pp")
            .font(Theme.Typography.button)
            .foregroundStyle(Theme.ColorToken.paper)
            .padding(.horizontal, 12)
            .padding(.vertical, 7)
            .background(Theme.ColorToken.brown, in: Capsule())
    }

    @ViewBuilder
    private func breakfastStatus(now: Date) -> some View {
        switch BreakfastWindow.state(now: now, weekday: Content.Breakfast.weekday, sunday: Content.Breakfast.sunday) {
        case .opensToday(let date):
            Label(
                language == .de ? "Öffnet heute um \(clock(date)) Uhr" : "Opens today at \(clock(date))",
                systemImage: "clock"
            )
        case .openNow(let date):
            Label(
                language == .de ? "Jetzt geöffnet · bis \(clock(date)) Uhr" : "Open now · until \(clock(date))",
                systemImage: "checkmark.circle.fill"
            )
            .foregroundStyle(Theme.ColorToken.brown)
        case .closedUntil(let date):
            Label(
                language == .de ? "Geschlossen · morgen ab \(clock(date)) Uhr" : "Closed · tomorrow from \(clock(date))",
                systemImage: "moon"
            )
        }
    }

    private func clock(_ date: Date) -> String {
        date.formatted(.dateTime.hour().minute().locale(Locale(identifier: language == .de ? "de_DE" : "en_GB")))
    }
}

struct CountdownDisplay: View {
    @Environment(\.appLanguage) private var language
    let target: Date
    let completed: LocalizedText

    var body: some View {
        TimelineView(.periodic(from: .now, by: 60)) { context in
            let remaining = StayClock.calendar.dateComponents([.hour, .minute], from: context.date, to: target)
            let hours = remaining.hour ?? 0
            let minutes = remaining.minute ?? 0
            if target <= context.date {
                Text(completed[language])
                    .font(Theme.Typography.title2)
            } else {
                VStack(alignment: .leading, spacing: 2) {
                    Text(String(format: "%02d:%02d", max(0, hours), max(0, minutes)))
                        .font(.system(size: 44, weight: .semibold, design: .serif))
                        .monospacedDigit()
                        .lineLimit(1)
                        .minimumScaleFactor(0.65)
                    Text(language == .de ? "Stunden · Minuten" : "hours · minutes")
                        .font(Theme.Typography.caption)
                        .foregroundStyle(Theme.ColorToken.graphite)
                }
            }
        }
    }
}
