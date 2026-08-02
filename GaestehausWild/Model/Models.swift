import Foundation

enum Page: String, Hashable, Identifiable, CaseIterable, Sendable {
    case myStay, rooms, breakfast, garden, goodToKnow
    case about, gallery, services, vouchers
    case nearby, arrival, contact
    case impressum, datenschutz, agb

    var id: String { rawValue }

    var title: LocalizedText {
        switch self {
        case .myStay: .init(de: "Mein Aufenthalt", en: "My stay")
        case .rooms: .init(de: "Zimmer", en: "Rooms")
        case .breakfast: .init(de: "Frühstück", en: "Breakfast")
        case .garden: .init(de: "Garten & Terrasse", en: "Garden & Terrace")
        case .goodToKnow: .init(de: "Wissenswertes", en: "Good to know")
        case .about: .init(de: "Über uns", en: "About us")
        case .gallery: .init(de: "Galerie", en: "Gallery")
        case .services: .init(de: "Sonstige Leistungen", en: "Other services")
        case .vouchers: .init(de: "Gutscheine", en: "Gift vouchers")
        case .nearby: .init(de: "In der Nähe", en: "Nearby")
        case .arrival: .init(de: "Anreise", en: "Getting here")
        case .contact: .init(de: "Kontakt", en: "Contact")
        case .impressum: .init(de: "Impressum", en: "Legal notice")
        case .datenschutz: .init(de: "Datenschutz", en: "Privacy")
        case .agb: .init(de: "AGB", en: "Terms & conditions")
        }
    }

    var symbol: String {
        switch self {
        case .myStay: "suitcase"
        case .rooms: "bed.double"
        case .breakfast: "cup.and.saucer"
        case .garden: "leaf"
        case .goodToKnow: "info.circle"
        case .about: "house.lodge"
        case .gallery: "photo.on.rectangle.angled"
        case .services: "person.2"
        case .vouchers: "gift"
        case .nearby: "map"
        case .arrival: "tram"
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

enum PlaceCategory: String, CaseIterable, Identifiable, Hashable, Sendable {
    case food, withKids, fair, rainyDay, shopping, nature

    var id: String { rawValue }

    var title: LocalizedText {
        switch self {
        case .food: .init(de: "Essen & Trinken", en: "Food & drink")
        case .withKids: .init(de: "Mit Kindern", en: "With children")
        case .fair: .init(de: "Messe & Anreise", en: "Fair & transport")
        case .rainyDay: .init(de: "Bei Regen", en: "Rainy days")
        case .shopping: .init(de: "Einkaufen", en: "Shopping")
        case .nature: .init(de: "Natur & Bewegung", en: "Nature & outdoors")
        }
    }

    var symbol: String {
        switch self {
        case .food: "fork.knife"
        case .withKids: "figure.and.child.holdinghands"
        case .fair: "building.2"
        case .rainyDay: "cloud.rain"
        case .shopping: "bag"
        case .nature: "leaf"
        }
    }
}

enum TravelMode: String, Hashable, Sendable {
    case walk, bike, car, transit

    var symbol: String {
        switch self {
        case .walk: "figure.walk"
        case .bike: "bicycle"
        case .car: "car"
        case .transit: "tram"
        }
    }

    var title: LocalizedText {
        switch self {
        case .walk: .init(de: "Zu Fuß", en: "Walking")
        case .bike: .init(de: "Mit dem Rad", en: "By bike")
        case .car: .init(de: "Mit dem Auto", en: "By car")
        case .transit: .init(de: "Mit Bus & Bahn", en: "Public transport")
        }
    }
}

struct TravelEstimate: Hashable, Sendable {
    let minutes: Int
    let mode: TravelMode
    let note: LocalizedText?

    init(minutes: Int, mode: TravelMode, note: LocalizedText? = nil) {
        self.minutes = minutes
        self.mode = mode
        self.note = note
    }
}

struct NearbyPlace: Hashable, Identifiable, Sendable {
    let id: String
    let name: LocalizedText
    let subtitle: LocalizedText
    let description: LocalizedText
    let latitude: Double
    let longitude: Double
    let categories: [PlaceCategory]
    let image: String?
    let travel: [TravelEstimate]
    let openingHours: LocalizedText?
    let priceHint: LocalizedText?
    let familyNote: LocalizedText?
    let website: String?
    let phone: String?

    init(
        id: String,
        name: LocalizedText,
        subtitle: LocalizedText,
        description: LocalizedText,
        latitude: Double,
        longitude: Double,
        categories: [PlaceCategory],
        image: String? = nil,
        travel: [TravelEstimate],
        openingHours: LocalizedText? = nil,
        priceHint: LocalizedText? = nil,
        familyNote: LocalizedText? = nil,
        website: String? = nil,
        phone: String? = nil
    ) {
        self.id = id
        self.name = name
        self.subtitle = subtitle
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
        self.categories = categories
        self.image = image
        self.travel = travel
        self.openingHours = openingHours
        self.priceHint = priceHint
        self.familyNote = familyNote
        self.website = website
        self.phone = phone
    }
}

struct TransitRoute: Hashable, Identifiable, Sendable {
    let id: String
    let destination: LocalizedText
    let symbol: String
    let durationSummary: LocalizedText
    let steps: [LocalizedText]
    let tip: LocalizedText?

    init(
        id: String,
        destination: LocalizedText,
        symbol: String,
        durationSummary: LocalizedText,
        steps: [LocalizedText],
        tip: LocalizedText? = nil
    ) {
        self.id = id
        self.destination = destination
        self.symbol = symbol
        self.durationSummary = durationSummary
        self.steps = steps
        self.tip = tip
    }
}

struct LegalDocument: Hashable, Sendable {
    let title: LocalizedText
    let body: LocalizedText
    let isPlaceholder: Bool
}
