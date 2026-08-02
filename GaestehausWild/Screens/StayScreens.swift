import SwiftUI

struct BreakfastScreen: View {
    @Environment(\.appLanguage) private var language

    var body: some View {
        PageScaffold(title: Page.breakfast.title) {
            PhotoView(name: "breakfast", aspectRatio: 16.0 / 10.0)
                .clipShape(RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius))

            HStack(spacing: Theme.Spacing.medium) {
                Label(
                    breakfastHours,
                    systemImage: "clock"
                )
                    .font(Theme.Typography.bodyStrong)
                    .minimumScaleFactor(0.75)
                Spacer()
                Text(language == .de ? "\(Content.Breakfast.price) € pro Person" : "€\(Content.Breakfast.price) per person")
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

    private var breakfastHours: String {
        let weekday = Content.Breakfast.weekday
        let sunday = Content.Breakfast.sunday
        if language == .de {
            return "Mo–Sa \(time(weekday.startHour, weekday.startMinute))–\(time(weekday.endHour, weekday.endMinute)) · So \(time(sunday.startHour, sunday.startMinute))–\(time(sunday.endHour, sunday.endMinute))"
        }
        return "Mon–Sat \(time(weekday.startHour, weekday.startMinute))–\(time(weekday.endHour, weekday.endMinute)) · Sun \(time(sunday.startHour, sunday.startMinute))–\(time(sunday.endHour, sunday.endMinute))"
    }

    private func time(_ hour: Int, _ minute: Int) -> String {
        String(format: "%d:%02d", hour, minute)
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
