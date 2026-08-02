import Foundation
import Testing

@Suite("Bilingual house guide")
struct GuideTests {
    @Test("German and English searches find the same entry")
    func bilingualSearch() {
        let german = GuideSearch.results(for: "Handtuch", in: Content.guide)
        let english = GuideSearch.results(for: "towel", in: Content.guide)
        #expect(german.contains(where: { $0.id == "towels" }))
        #expect(english.contains(where: { $0.id == "towels" }))
    }

    @Test("Search normalizes case, diacritics, punctuation, and sharp S")
    func normalization() {
        #expect(GuideSearch.normalize("  CAFÉ—Straße! ") == "cafe strasse")
    }

    @Test("Title matches rank before answer matches")
    func ranking() {
        let entries = [
            GuideEntry(
                id: "answer",
                symbol: "info.circle",
                title: .init(de: "Internet", en: "Internet"),
                answer: .init(de: "WLAN verfügbar", en: "Wi-Fi available"),
                category: .practical
            ),
            GuideEntry(
                id: "title",
                symbol: "wifi",
                title: .init(de: "WLAN", en: "Wi-Fi"),
                answer: .init(de: "Sofort verbinden", en: "Connect instantly"),
                category: .house
            )
        ]
        #expect(GuideSearch.results(for: "WLAN", in: entries).map(\.id) == ["title", "answer"])
    }

    @Test("Guide content is complete and safe to route")
    func contentSanity() {
        #expect(Content.guide.count >= 30)
        #expect(Set(Content.guide.map(\.id)).count == Content.guide.count)
        #expect(Content.guide.allSatisfy {
            !$0.id.isEmpty && !$0.title.de.isEmpty && !$0.title.en.isEmpty && !$0.answer.de.isEmpty && !$0.answer.en.isEmpty
        })

        let emergencyText = Content.guide
            .filter { $0.category == .emergency }
            .map { "\($0.title.de) \($0.answer.de) \($0.title.en) \($0.answer.en)" }
            .joined(separator: " ")
        #expect(emergencyText.contains("112"))
        #expect(emergencyText.contains("110"))
    }

    @Test("All telephone actions contain dialable numbers")
    func telephoneActions() {
        let telephoneValues = Content.guide.flatMap(\.actions).compactMap { action -> String? in
            guard case .call(let value) = action else { return nil }
            return value
        }
        #expect(!telephoneValues.isEmpty)
        #expect(telephoneValues.allSatisfy(isValidTelephoneURL))
    }

    private func isValidTelephoneURL(_ value: String) -> Bool {
        guard value.hasPrefix("tel:") else { return false }
        var number = String(value.dropFirst(4))
        if number.first == "+" { number.removeFirst() }
        return !number.isEmpty && number.allSatisfy(\.isNumber)
    }
}
