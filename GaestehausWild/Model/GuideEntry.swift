import Foundation

enum GuideCategory: String, CaseIterable, Identifiable, Hashable, Sendable {
    case emergency, room, house, food, practical, departure

    var id: String { rawValue }

    var title: LocalizedText {
        switch self {
        case .emergency: .init(de: "Notfall", en: "Emergency")
        case .room: .init(de: "Im Zimmer", en: "In your room")
        case .house: .init(de: "Im Haus", en: "Around the house")
        case .food: .init(de: "Essen & Trinken", en: "Food & drink")
        case .practical: .init(de: "Praktisches", en: "Practical information")
        case .departure: .init(de: "An- & Abreise", en: "Arrival & departure")
        }
    }

    var symbol: String {
        switch self {
        case .emergency: "cross.case.fill"
        case .room: "bed.double.fill"
        case .house: "house.fill"
        case .food: "fork.knife"
        case .practical: "info.circle.fill"
        case .departure: "suitcase.fill"
        }
    }
}

enum GuideAction: Hashable, Sendable {
    case call(String)
    case map(query: String)
    case link(String)
    case page(Page)
}

struct GuideEntry: Hashable, Identifiable, Sendable {
    let id: String
    let symbol: String
    let title: LocalizedText
    let answer: LocalizedText
    let keywords: [String]
    let category: GuideCategory
    let actions: [GuideAction]

    init(
        id: String,
        symbol: String,
        title: LocalizedText,
        answer: LocalizedText,
        keywords: [String] = [],
        category: GuideCategory,
        actions: [GuideAction] = []
    ) {
        self.id = id
        self.symbol = symbol
        self.title = title
        self.answer = answer
        self.keywords = keywords
        self.category = category
        self.actions = actions
    }
}
