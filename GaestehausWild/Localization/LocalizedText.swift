import Foundation

struct LocalizedText: Hashable, Sendable {
    let de: String
    let en: String

    init(de: String, en: String) {
        self.de = de
        self.en = en
    }

    subscript(_ language: AppLanguage) -> String {
        language == .en ? en : de
    }

    func replacing(_ token: String, with value: String) -> LocalizedText {
        .init(
            de: de.replacingOccurrences(of: token, with: value),
            en: en.replacingOccurrences(of: token, with: value)
        )
    }
}
