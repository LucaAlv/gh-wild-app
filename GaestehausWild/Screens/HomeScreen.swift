import SwiftUI

struct HomeScreen: View {
    @Environment(\.appLanguage) private var language

    private let teasers: [(Page, String, LocalizedText)] = [
        (.rooms, "galerie-03", .init(de: "Sieben Zimmerkategorien, jedes Zimmer mit seinem eigenen Charakter.", en: "Seven room categories, each with a character of its own.")),
        (.about, "galerie-16", .init(de: "Ein über 300 Jahre altes Fachwerkhaus und drei Generationen Gastgebertradition.", en: "A 300-year-old half-timbered house and three generations of hospitality.")),
        (.gallery, "galerie-04", .init(de: "Entdecken Sie unser Haus, die Zimmer und die kleinen Details.", en: "Discover our house, its rooms and all the thoughtful details.")),
        (.services, "galerie-08", .init(de: "Ein würdevoller, ruhiger Rahmen für kleine Trauergesellschaften.", en: "A dignified, peaceful setting for smaller funeral receptions."))
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                HeroHeader(
                    image: "galerie-16",
                    eyebrow: .init(de: "Gästehaus Wild · Oberasbach", en: "Gästehaus Wild · Oberasbach"),
                    title: .init(de: "Herzlich willkommen", en: "A warm welcome")
                )

                VStack(alignment: .leading, spacing: Theme.Spacing.section) {
                    VStack(alignment: .leading, spacing: Theme.Spacing.large) {
                        Text(Content.homeWelcome[language])
                            .font(Theme.Typography.title)
                            .foregroundStyle(Theme.ColorToken.ink)
                        LeadParagraph(text: Content.homeLead)
                    }

                    NavigationLink(value: Page.myStay) {
                        StayStatusCard()
                    }
                    .buttonStyle(.plain)

                    VStack(spacing: Theme.Spacing.large) {
                        ForEach(teasers, id: \.0) { page, image, text in
                            NavigationLink(value: page) {
                                TeaserCard(page: page, image: image, text: text)
                            }
                            .buttonStyle(.plain)
                        }
                    }

                    contactFooter
                }
                .padding(.horizontal, Theme.Metric.gutter)
                .padding(.vertical, Theme.Spacing.section)
                .frame(maxWidth: 720)
            }
            .frame(maxWidth: .infinity)
        }
        .pageBackground()
        .toolbarBackground(Theme.ColorToken.cream.opacity(0.94), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }

    private var contactFooter: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.large) {
            SectionHeader(
                eyebrow: .init(de: "Wir sind für Sie da", en: "Here for you"),
                title: .init(de: "Kontakt", en: "Contact")
            )
            Text(Content.address[language])
                .font(Theme.Typography.bodyStrong)
                .lineSpacing(5)
            ActionButtonRow(includeRoute: true)
        }
    }
}
