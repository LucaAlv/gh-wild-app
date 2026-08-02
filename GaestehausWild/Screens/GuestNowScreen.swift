import SwiftUI

struct GuestNowScreen: View {
    @Environment(\.appLanguage) private var language

    var body: some View {
        PageScaffold(title: Page.guestNow.title) {
            LeadParagraph(text: .init(
                de: "Alles, was Sie direkt nach der Ankunft brauchen – ohne Anmeldung und ohne Reisedaten.",
                en: "Everything you need just after arriving—without an account or travel dates."
            ))

            WiFiTile()
            BreakfastStatusTile()

            InfoCard(rows: [
                ("clock.arrow.circlepath", .init(de: "Check-out", en: "Check-out"), .init(de: "Am Abreisetag bis 11:00 Uhr", en: "By 11:00 am on departure day")),
                ("key", .init(de: "Schlüssel", en: "Keys"), Content.StayCopy.keyHandover),
                ("parkingsign", .init(de: "Parken", en: "Parking"), Content.StayCopy.parking)
            ])

            ActionButtonRow(includeRoute: true)

            NavigationLink(value: Page.myStay) {
                VStack(alignment: .leading, spacing: Theme.Spacing.small) {
                    Label(language == .de ? "Reisedaten ergänzen" : "Add travel dates", systemImage: "calendar.badge.plus")
                        .font(Theme.Typography.title2)
                    Text(language == .de ? "Für Countdown, passende Aufenthaltsinfos und Erinnerungen an Frühstück und Check-out." : "Get a countdown, timely stay information, and breakfast and check-out reminders.")
                        .font(Theme.Typography.body)
                        .foregroundStyle(Theme.ColorToken.graphite)
                    Label(language == .de ? "Aufenthalt einrichten" : "Set up your stay", systemImage: "arrow.right")
                        .font(Theme.Typography.button)
                        .foregroundStyle(Theme.ColorToken.brown)
                }
                .padding(Theme.Spacing.large)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Theme.ColorToken.ink)
                .background(Theme.ColorToken.paper, in: RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius))
                .overlay { RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius).stroke(Theme.ColorToken.brown.opacity(0.2)) }
            }
            .buttonStyle(.plain)
        }
    }
}
