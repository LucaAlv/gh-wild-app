import SwiftUI

struct MenuSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.appLanguage) private var language
    @Binding var selectedPage: Page?
    @Binding var languagePreference: String

    private let groups: [(LocalizedText, [Page])] = [
        (.init(de: "Aufenthalt", en: "Your stay"), [.myStay, .rooms, .breakfast, .garden, .goodToKnow]),
        (.init(de: "Haus & Familie", en: "House & family"), [.about, .gallery, .services, .vouchers]),
        (.init(de: "Umgebung", en: "Explore"), [.nearby, .arrival, .contact]),
        (.init(de: "Rechtliches", en: "Legal"), [.impressum, .datenschutz, .agb])
    ]

    var body: some View {
        NavigationStack {
            List {
                ForEach(Array(groups.enumerated()), id: \.offset) { _, group in
                    Section(group.0[language]) {
                        ForEach(group.1) { page in
                            Button {
                                selectedPage = page
                                dismiss()
                            } label: {
                                HStack(spacing: 14) {
                                    Image(systemName: page.symbol)
                                        .foregroundStyle(Theme.ColorToken.brown)
                                        .frame(width: 26)
                                    Text(page.title[language])
                                        .font(Theme.Typography.bodyStrong)
                                        .foregroundStyle(Theme.ColorToken.ink)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.caption.weight(.bold))
                                        .foregroundStyle(Theme.ColorToken.ash)
                                }
                                .contentShape(Rectangle())
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }

                Section(language == .de ? "Sprache" : "Language") {
                    Picker(language == .de ? "Sprache" : "Language", selection: $languagePreference) {
                        Text(language == .de ? "System" : "System").tag("system")
                        Text("Deutsch").tag("de")
                        Text("English").tag("en")
                    }
                    .pickerStyle(.segmented)
                }
            }
            .scrollContentBackground(.hidden)
            .background(Theme.ColorToken.cream)
            .navigationTitle("Gästehaus Wild")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(language == .de ? "Schließen" : "Close") { dismiss() }
                        .font(Theme.Typography.button)
                }
            }
        }
        .tint(Theme.ColorToken.brown)
    }
}
