import SwiftUI

struct BreakfastScreen: View {
    @Environment(\.appLanguage) private var language

    var body: some View {
        PageScaffold(title: Page.breakfast.title) {
            PhotoView(name: "breakfast", aspectRatio: 16.0 / 10.0)
                .clipShape(RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius))

            HStack(spacing: Theme.Spacing.medium) {
                Label("7:00 – 10:00", systemImage: "clock")
                    .font(Theme.Typography.bodyStrong)
                Spacer()
                Text(language == .de ? "14 € pro Person" : "€14 per person")
                    .font(Theme.Typography.button)
                    .foregroundStyle(Theme.ColorToken.paper)
                    .padding(.horizontal, 13)
                    .padding(.vertical, 9)
                    .background(Theme.ColorToken.brown, in: Capsule())
            }

            LeadParagraph(text: Content.Breakfast.intro)

            HStack(alignment: .top, spacing: Theme.Spacing.medium) {
                Image(systemName: "allergens")
                    .font(.title2)
                    .foregroundStyle(Theme.ColorToken.brown)
                BodyText(text: Content.Breakfast.allergy)
            }
            .padding(Theme.Spacing.large)
            .background(Theme.ColorToken.paper, in: RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius))

            ActionButtonRow()
        }
    }
}

struct GardenScreen: View {
    var body: some View {
        PageScaffold(title: Page.garden.title) {
            ImageCarousel(images: ["garden", "galerie-25"])
                .clipShape(RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius))
            LeadParagraph(text: Content.Garden.body)
            FeatureList(features: [
                .init(symbol: "sun.max", title: .init(de: "Terrasse in den Sommermonaten", en: "Terrace during the summer months")),
                .init(symbol: "wineglass", title: .init(de: "Kühle Getränke nach Verfügbarkeit", en: "Cold drinks subject to availability")),
                .init(symbol: "takeoutbag.and.cup.and.straw", title: .init(de: "Eigene Speisen & Getränke erlaubt", en: "Your own food & drinks are welcome")),
                .init(symbol: "bicycle", title: .init(de: "Sichere Fahrradablage", en: "Secure bicycle storage"))
            ])
        }
    }
}

struct GoodToKnowScreen: View {
    var body: some View {
        PageScaffold(title: Page.goodToKnow.title) {
            LeadParagraph(text: Content.GoodToKnow.intro)
            ForEach(Array(Content.GoodToKnow.groups.enumerated()), id: \.offset) { _, group in
                SectionHeader(title: group.0)
                FeatureList(features: group.1)
            }
        }
    }
}
