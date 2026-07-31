import SwiftUI

struct LegalScreen: View {
    @Environment(\.appLanguage) private var language
    let document: LegalDocument

    var body: some View {
        PageScaffold(title: document.title) {
            if document.isPlaceholder {
                HStack(alignment: .top, spacing: Theme.Spacing.medium) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundStyle(Theme.ColorToken.brown)
                    Text(language == .de
                         ? "Platzhalter für v1: Dieser von der Website kopierte Text beschreibt Wix und ist für die App vor Veröffentlichung zu überarbeiten."
                         : "v1 placeholder: this text was copied from the website, describes Wix, and must be revised for the app before release.")
                        .font(Theme.Typography.bodyStrong)
                        .foregroundStyle(Theme.ColorToken.ink)
                }
                .padding(Theme.Spacing.large)
                .background(Theme.ColorToken.paper, in: RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius))
                .accessibilityElement(children: .combine)
            }

            Text(document.body[language])
                .font(Theme.Typography.body)
                .foregroundStyle(Theme.ColorToken.graphite)
                .lineSpacing(6)
                .textSelection(.enabled)
        }
    }
}
