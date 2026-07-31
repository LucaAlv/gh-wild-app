import SwiftUI

struct AboutScreen: View {
    var body: some View {
        PageScaffold(title: Page.about.title) {
            PhotoView(name: "galerie-16", aspectRatio: 4.0 / 3.0)
                .clipShape(RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius))
            LeadParagraph(text: Content.About.body)
            ActionButtonRow()
        }
    }
}

struct ServicesScreen: View {
    @Environment(\.appLanguage) private var language

    var body: some View {
        PageScaffold(title: Page.services.title) {
            PhotoView(name: "galerie-08", aspectRatio: 16.0 / 10.0)
                .clipShape(RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius))

            SectionHeader(
                eyebrow: .init(de: "Beerdigungen", en: "Funeral receptions"),
                title: .init(de: "Leichenschmaus", en: "A quiet gathering")
            )
            LeadParagraph(text: Content.Services.body)

            VStack(alignment: .leading, spacing: 14) {
                Text(language == .de ? "Bewirtung nach Wunsch" : "Catering options")
                    .font(Theme.Typography.title2)
                ForEach(Content.Services.options, id: \.self) { option in
                    Label(option[language], systemImage: "checkmark")
                        .font(Theme.Typography.body)
                        .foregroundStyle(Theme.ColorToken.graphite)
                }
            }
            .padding(Theme.Spacing.large)
            .background(Theme.ColorToken.paper, in: RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius))

            BodyText(text: Content.Services.details)
            ActionButtonRow()
        }
    }
}

struct VouchersScreen: View {
    var body: some View {
        PageScaffold(title: Page.vouchers.title) {
            ZStack {
                RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius)
                    .fill(Theme.ColorToken.brown)
                Image(systemName: "gift.fill")
                    .font(.system(size: 70, weight: .light))
                    .foregroundStyle(Theme.ColorToken.paper)
            }
            .frame(height: 220)
            .accessibilityHidden(true)

            LeadParagraph(text: Content.Vouchers.body)
            ActionButtonRow()
        }
    }
}
