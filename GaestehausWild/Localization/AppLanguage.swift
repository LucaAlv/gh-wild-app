import Foundation

enum AppLanguage: String, CaseIterable, Identifiable, Sendable {
    case de
    case en

    var id: String { rawValue }

    static func resolved(preference: String?) -> AppLanguage {
        if let preference, let language = AppLanguage(rawValue: preference) {
            return language
        }
        let languageCode = Locale.preferredLanguages.first?.prefix(2).lowercased()
        return languageCode == "en" ? .en : .de
    }
}
