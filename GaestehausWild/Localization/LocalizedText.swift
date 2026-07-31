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
}
