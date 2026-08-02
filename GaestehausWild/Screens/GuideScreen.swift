import SwiftUI

struct GuideScreen: View {
    @Environment(\.appLanguage) private var language
    @State private var query = ""
    @State private var expandedEntryIDs: Set<String> = []

    private var isSearching: Bool {
        !GuideSearch.normalize(query).isEmpty
    }

    private var results: [GuideEntry] {
        GuideSearch.results(for: query, in: Content.guide)
    }

    var body: some View {
        PageScaffold(title: Page.goodToKnow.title) {
            LeadParagraph(text: .init(
                de: "Antworten von A bis Z – offline, zweisprachig und immer griffbereit.",
                en: "Answers from A to Z—offline, bilingual and always close at hand."
            ))

            SearchField(
                text: $query,
                placeholder: .init(de: "Zum Beispiel Handtuch, WLAN, Apotheke …", en: "Try towels, Wi-Fi, pharmacy …")
            )

            if isSearching {
                searchResults
            } else {
                emergencyCard
                categorySections
            }
        }
    }

    @ViewBuilder
    private var searchResults: some View {
        if results.isEmpty {
            VStack(alignment: .leading, spacing: Theme.Spacing.large) {
                Image(systemName: "questionmark.circle")
                    .font(.system(size: 34, weight: .medium))
                    .foregroundStyle(Theme.ColorToken.brown)
                Text(language == .de ? "Dazu haben wir noch keinen Eintrag." : "We do not have an entry for that yet.")
                    .font(Theme.Typography.title2)
                    .foregroundStyle(Theme.ColorToken.ink)
                Text(language == .de ? "Rufen Sie uns gerne an – wir helfen persönlich weiter." : "Please call us—we will be happy to help in person.")
                    .font(Theme.Typography.body)
                    .foregroundStyle(Theme.ColorToken.graphite)
                ActionButton(title: .init(de: "Gästehaus anrufen", en: "Call the guesthouse"), symbol: "phone.fill", url: ExternalActions.phone)
            }
            .padding(Theme.Spacing.large)
            .background(Theme.ColorToken.paper, in: RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius))
        } else {
            Text(language == .de ? "\(results.count) Treffer" : "\(results.count) result\(results.count == 1 ? "" : "s")")
                .font(Theme.Typography.caption)
                .foregroundStyle(Theme.ColorToken.graphite)
            VStack(spacing: Theme.Spacing.medium) {
                ForEach(results) { entry in
                    GuideEntryRow(
                        entry: entry,
                        isExpanded: expandedEntryIDs.contains(entry.id),
                        showCategory: true,
                        toggle: { toggle(entry) }
                    )
                }
            }
        }
    }

    private var emergencyCard: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.medium) {
            SectionHeader(
                eyebrow: .init(de: "Im Notfall", en: "In an emergency"),
                title: .init(de: "Soforthilfe", en: "Immediate help")
            )
            ForEach(entries(in: .emergency)) { entry in
                GuideEntryRow(
                    entry: entry,
                    isExpanded: expandedEntryIDs.contains(entry.id),
                    showCategory: false,
                    toggle: { toggle(entry) }
                )
            }
        }
        .padding(Theme.Spacing.large)
        .background(Theme.ColorToken.brown.opacity(0.08), in: RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius))
        .overlay {
            RoundedRectangle(cornerRadius: Theme.Metric.cornerRadius)
                .stroke(Theme.ColorToken.brown.opacity(0.28))
        }
    }

    private var categorySections: some View {
        ForEach(orderedCategories) { category in
            SectionHeader(title: category.title)
            VStack(spacing: Theme.Spacing.medium) {
                ForEach(entries(in: category)) { entry in
                    GuideEntryRow(
                        entry: entry,
                        isExpanded: expandedEntryIDs.contains(entry.id),
                        showCategory: false,
                        toggle: { toggle(entry) }
                    )
                }
            }
        }
    }

    private var orderedCategories: [GuideCategory] {
        GuideCategory.allCases
            .filter { $0 != .emergency }
            .sorted { $0.title[language].localizedStandardCompare($1.title[language]) == .orderedAscending }
    }

    private func entries(in category: GuideCategory) -> [GuideEntry] {
        Content.guide
            .filter { $0.category == category }
            .sorted { $0.title[language].localizedStandardCompare($1.title[language]) == .orderedAscending }
    }

    private func toggle(_ entry: GuideEntry) {
        withAnimation(.easeInOut(duration: 0.2)) {
            if expandedEntryIDs.contains(entry.id) {
                expandedEntryIDs.remove(entry.id)
            } else {
                expandedEntryIDs.insert(entry.id)
            }
        }
    }
}

private struct GuideEntryRow: View {
    @Environment(\.appLanguage) private var language
    let entry: GuideEntry
    let isExpanded: Bool
    let showCategory: Bool
    let toggle: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: toggle) {
                HStack(alignment: .center, spacing: Theme.Spacing.medium) {
                    Image(systemName: entry.symbol)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(Theme.ColorToken.brown)
                        .frame(width: 34, height: 34)
                        .background(Theme.ColorToken.brown.opacity(0.1), in: Circle())
                    VStack(alignment: .leading, spacing: 3) {
                        Text(entry.title[language])
                            .font(Theme.Typography.bodyStrong)
                            .foregroundStyle(Theme.ColorToken.ink)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        if showCategory {
                            Text(entry.category.title[language])
                                .font(Theme.Typography.caption)
                                .foregroundStyle(Theme.ColorToken.graphite)
                        }
                    }
                    Image(systemName: "chevron.down")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(Theme.ColorToken.ash)
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel(entry.title[language])
            .accessibilityValue(isExpanded ? (language == .de ? "Geöffnet" : "Expanded") : (language == .de ? "Geschlossen" : "Collapsed"))

            if isExpanded {
                Divider()
                    .overlay(Theme.ColorToken.brown.opacity(0.16))
                    .padding(.vertical, Theme.Spacing.medium)
                BodyText(text: entry.answer)
                if !entry.actions.isEmpty {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 140), spacing: Theme.Spacing.small)], spacing: Theme.Spacing.small) {
                        ForEach(Array(entry.actions.enumerated()), id: \.offset) { _, action in
                            GuideActionCapsule(action: action)
                        }
                    }
                    .padding(.top, Theme.Spacing.medium)
                }
            }
        }
        .padding(Theme.Spacing.large)
        .background(Theme.ColorToken.paper, in: RoundedRectangle(cornerRadius: 14))
        .overlay {
            RoundedRectangle(cornerRadius: 14)
                .stroke(Theme.ColorToken.brown.opacity(0.16))
        }
    }
}

private struct GuideActionCapsule: View {
    @Environment(\.appLanguage) private var language
    let action: GuideAction

    @ViewBuilder
    var body: some View {
        switch action {
        case .call(let value):
            if let url = URL(string: value) {
                Link(destination: url) {
                    actionLabel(title: language == .de ? "Anrufen" : "Call", symbol: "phone.fill")
                }
                .buttonStyle(.plain)
            }
        case .map(let query):
            Link(destination: ExternalActions.mapsSearchURL(query: query)) {
                actionLabel(title: language == .de ? "Karte öffnen" : "Open map", symbol: "map.fill")
            }
            .buttonStyle(.plain)
        case .link(let value):
            if let url = URL(string: value) {
                Link(destination: url) {
                    actionLabel(title: language == .de ? "Website" : "Website", symbol: "safari.fill")
                }
                .buttonStyle(.plain)
            }
        case .page(let page):
            NavigationLink(value: page) {
                actionLabel(title: page.title[language], symbol: page.symbol)
            }
            .buttonStyle(.plain)
        }
    }

    private func actionLabel(title: String, symbol: String) -> some View {
        Label(title, systemImage: symbol)
            .font(Theme.Typography.button)
            .lineLimit(1)
            .minimumScaleFactor(0.75)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, Theme.Spacing.medium)
            .padding(.vertical, 11)
            .foregroundStyle(Theme.ColorToken.brown)
            .background(Theme.ColorToken.brown.opacity(0.1), in: Capsule())
    }
}
