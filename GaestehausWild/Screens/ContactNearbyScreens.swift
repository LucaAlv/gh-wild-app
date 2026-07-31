import SwiftUI

struct ContactScreen: View {
    @Environment(\.appLanguage) private var language

    var body: some View {
        PageScaffold(title: Page.contact.title) {
            MapSnapshotCard()

            VStack(alignment: .leading, spacing: Theme.Spacing.large) {
                InfoRow(symbol: "mappin.and.ellipse", label: .init(de: "Adresse", en: "Address"), value: Content.address)
                Divider().overlay(Theme.ColorToken.brown.opacity(0.2))
                InfoRow(symbol: "phone", label: .init(de: "Telefon", en: "Phone"), value: .init(de: Content.phoneDisplay, en: "+49 911 996910"))
                Divider().overlay(Theme.ColorToken.brown.opacity(0.2))
                InfoRow(symbol: "envelope", label: .init(de: "E-Mail", en: "E-mail"), value: .init(de: Content.email, en: Content.email))
                Divider().overlay(Theme.ColorToken.brown.opacity(0.2))
                InfoRow(symbol: "camera", label: .init(de: "Instagram", en: "Instagram"), value: .init(de: "@gaestehaus.wild", en: "@gaestehaus.wild"))
            }
            .padding(Theme.Spacing.large)
            .background(Theme.ColorToken.paper, in: RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius))

            SectionHeader(title: .init(de: "Öffnungszeiten", en: "Opening hours"))
            VStack(spacing: 0) {
                OpeningHoursRow(day: .init(de: "Montag – Samstag", en: "Monday – Saturday"), hours: "07:00–11:00  ·  15:00–22:00")
                Divider().overlay(Theme.ColorToken.brown.opacity(0.2))
                OpeningHoursRow(day: .init(de: "Sonntag", en: "Sunday"), hours: "08:00–11:00  ·  15:00–22:00")
            }
            .padding(.horizontal, Theme.Spacing.large)
            .background(Theme.ColorToken.paper, in: RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius))

            ActionButtonRow(includeRoute: true, includeInstagram: true)
        }
    }
}

private struct OpeningHoursRow: View {
    @Environment(\.appLanguage) private var language
    let day: LocalizedText
    let hours: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(day[language])
                .font(Theme.Typography.bodyStrong)
            Text(hours)
                .font(Theme.Typography.body)
                .foregroundStyle(Theme.ColorToken.graphite)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, Theme.Spacing.medium)
    }
}

struct NearbyScreen: View {
    @Environment(\.appLanguage) private var language

    var body: some View {
        PageScaffold(title: Page.nearby.title) {
            LeadParagraph(text: .init(
                de: "Ausflugsziele für Familien, Erholung und Kultur liegen direkt vor unserer Haustür.",
                en: "Family attractions, relaxation and culture are all within easy reach."
            ))

            ForEach(Content.nearbyPlaces) { place in
                VStack(alignment: .leading, spacing: 0) {
                    PhotoView(name: place.image, aspectRatio: 16.0 / 10.0)
                    VStack(alignment: .leading, spacing: Theme.Spacing.small) {
                        Text(place.subtitle[language].uppercased())
                            .font(Theme.Typography.caption)
                            .tracking(1.5)
                            .foregroundStyle(Theme.ColorToken.brown)
                        Text(place.name[language])
                            .font(Theme.Typography.title2)
                        Text(place.description[language])
                            .font(Theme.Typography.body)
                            .foregroundStyle(Theme.ColorToken.graphite)
                            .lineSpacing(5)
                        Link(destination: ExternalActions.mapsURL(latitude: place.latitude, longitude: place.longitude, name: place.name[language])) {
                            Label(language == .de ? "In Karten öffnen" : "Open in Maps", systemImage: "map")
                                .font(Theme.Typography.button)
                                .foregroundStyle(Theme.ColorToken.brown)
                                .padding(.top, 6)
                        }
                    }
                    .padding(Theme.Spacing.large)
                }
                .background(Theme.ColorToken.paper)
                .clipShape(RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius))
                .shadow(color: .black.opacity(0.06), radius: 12, y: 5)
            }
        }
    }
}
