import Foundation

enum Page: String, Hashable, Identifiable, CaseIterable, Sendable {
    case rooms, breakfast, garden, goodToKnow
    case about, gallery, services, vouchers
    case nearby, contact
    case impressum, datenschutz, agb

    var id: String { rawValue }

    var title: LocalizedText {
        switch self {
        case .rooms: .init(de: "Zimmer", en: "Rooms")
        case .breakfast: .init(de: "Frühstück", en: "Breakfast")
        case .garden: .init(de: "Garten & Terrasse", en: "Garden & Terrace")
        case .goodToKnow: .init(de: "Wissenswertes", en: "Good to know")
        case .about: .init(de: "Über uns", en: "About us")
        case .gallery: .init(de: "Galerie", en: "Gallery")
        case .services: .init(de: "Sonstige Leistungen", en: "Other services")
        case .vouchers: .init(de: "Gutscheine", en: "Gift vouchers")
        case .nearby: .init(de: "In der Nähe", en: "Nearby")
        case .contact: .init(de: "Kontakt", en: "Contact")
        case .impressum: .init(de: "Impressum", en: "Legal notice")
        case .datenschutz: .init(de: "Datenschutz", en: "Privacy")
        case .agb: .init(de: "AGB", en: "Terms & conditions")
        }
    }

    var symbol: String {
        switch self {
        case .rooms: "bed.double"
        case .breakfast: "cup.and.saucer"
        case .garden: "leaf"
        case .goodToKnow: "info.circle"
        case .about: "house.lodge"
        case .gallery: "photo.on.rectangle.angled"
        case .services: "person.2"
        case .vouchers: "gift"
        case .nearby: "map"
        case .contact: "phone"
        case .impressum: "building.columns"
        case .datenschutz: "hand.raised"
        case .agb: "doc.text"
        }
    }
}

struct Room: Hashable, Identifiable, Sendable {
    let id: String
    let name: LocalizedText
    let price: Int
    let occupancy: LocalizedText
    let description: LocalizedText
    let images: [String]
}

struct Feature: Hashable, Identifiable, Sendable {
    var id: String { symbol + title.de }
    let symbol: String
    let title: LocalizedText
}

struct NearbyPlace: Hashable, Identifiable, Sendable {
    let id: String
    let name: LocalizedText
    let subtitle: LocalizedText
    let description: LocalizedText
    let image: String
    let latitude: Double
    let longitude: Double
}

struct LegalDocument: Hashable, Sendable {
    let title: LocalizedText
    let body: LocalizedText
    let isPlaceholder: Bool
}
