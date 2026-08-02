import Foundation

enum GuideSearch {
    static func normalize(_ value: String) -> String {
        let folded = value
            .folding(options: [.caseInsensitive, .diacriticInsensitive, .widthInsensitive], locale: Locale(identifier: "de_DE"))
            .replacingOccurrences(of: "ß", with: "ss")
        return folded
            .components(separatedBy: CharacterSet.alphanumerics.inverted)
            .filter { !$0.isEmpty }
            .joined(separator: " ")
    }

    static func results(for query: String, in entries: [GuideEntry]) -> [GuideEntry] {
        let normalizedQuery = normalize(query)
        guard !normalizedQuery.isEmpty else {
            return entries.sorted(by: alphabetical)
        }

        let tokens = normalizedQuery.split(separator: " ").map(String.init)
        return entries.compactMap { entry -> (GuideEntry, Int)? in
            let titles = [normalize(entry.title.de), normalize(entry.title.en)]
            let answers = [normalize(entry.answer.de), normalize(entry.answer.en)]
            let keywords = entry.keywords.map(normalize)
            let searchable = titles + keywords + answers

            guard tokens.allSatisfy({ token in searchable.contains(where: { $0.contains(token) }) }) else {
                return nil
            }

            let rank: Int
            if titles.contains(normalizedQuery) {
                rank = 0
            } else if titles.contains(where: { $0.hasPrefix(normalizedQuery) }) {
                rank = 1
            } else if titles.contains(where: { $0.contains(normalizedQuery) }) {
                rank = 2
            } else if keywords.contains(where: { $0.contains(normalizedQuery) }) {
                rank = 3
            } else {
                rank = 4
            }
            return (entry, rank)
        }
        .sorted { lhs, rhs in
            lhs.1 == rhs.1 ? alphabetical(lhs.0, rhs.0) : lhs.1 < rhs.1
        }
        .map(\.0)
    }

    private static func alphabetical(_ lhs: GuideEntry, _ rhs: GuideEntry) -> Bool {
        let left = normalize(lhs.title.de)
        let right = normalize(rhs.title.de)
        return left == right ? lhs.id < rhs.id : left < right
    }
}
