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
