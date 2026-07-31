import Foundation

enum Content {
    static let phoneDisplay = "0911 996910"
    static let phoneURL = "tel:+49911996910"
    static let email = "info@gaestehaus-wild.com"
    static let address = LocalizedText(
        de: "Jahnstraße 77\n90522 Oberasbach",
        en: "Jahnstraße 77\n90522 Oberasbach, Germany"
    )

    static let homeLead = LocalizedText(
        de: "Seit 1990 begrüßen wir, drei Generationen der Familie Wild, Gäste in unserem über 300 Jahre alten Fachwerkhaus. Jedes Zimmer ist mit Liebe zum Detail eingerichtet und so einzigartig wie die alten Grundmauern unseres Hauses.",
        en: "Since 1990, three generations of the Wild family have welcomed guests to our 300-year-old half-timbered house. Every room is furnished with care and is as individual as the historic walls around it."
    )

    static let homeWelcome = LocalizedText(
        de: "Ankommen. Durchatmen. Zuhause fühlen.",
        en: "Arrive. Unwind. Feel at home."
    )

    static let roomAmenities: [Feature] = [
        .init(symbol: "toilet", title: .init(de: "WC", en: "Toilet")),
        .init(symbol: "shower", title: .init(de: "Dusche oder Badewanne", en: "Shower or bath")),
        .init(symbol: "wind", title: .init(de: "Föhn", en: "Hair dryer")),
        .init(symbol: "takeoutbag.and.cup.and.straw", title: .init(de: "Duschgel, Shampoo & Seife", en: "Shower gel, shampoo & soap")),
        .init(symbol: "square.stack", title: .init(de: "Ausreichend Handtücher", en: "Plenty of towels")),
        .init(symbol: "wifi", title: .init(de: "Kostenloses WLAN", en: "Free Wi-Fi"))
    ]

    static let rooms: [Room] = [
        .init(id: "single", name: .init(de: "Einzelzimmer", en: "Single room"), price: 70,
              occupancy: .init(de: "Für 1 Person", en: "For 1 guest"),
              description: .init(de: "Ein gemütlicher Rückzugsort für Alleinreisende – individuell eingerichtet und mit allem ausgestattet, was Sie für einen angenehmen Aufenthalt benötigen.", en: "A cosy retreat for solo travellers, individually furnished with everything needed for a comfortable stay."), images: ["galerie-01", "galerie-02"]),
        .init(id: "double", name: .init(de: "Doppelzimmer", en: "Double room"), price: 90,
              occupancy: .init(de: "Für 2 Personen", en: "For 2 guests"),
              description: .init(de: "Unsere Doppelzimmer verbinden den Charakter des historischen Hauses mit zeitgemäßem Komfort.", en: "Our double rooms combine the character of the historic house with modern comfort."), images: ["galerie-03", "galerie-04", "galerie-05"]),
        .init(id: "triple", name: .init(de: "Dreibettzimmer", en: "Triple room"), price: 115,
              occupancy: .init(de: "Für 3 Personen", en: "For 3 guests"),
              description: .init(de: "Viel Platz für Familie, Freunde oder Kolleginnen und Kollegen – behaglich und praktisch zugleich.", en: "Plenty of room for family, friends or colleagues – welcoming and practical."), images: ["galerie-06", "galerie-07"]),
        .init(id: "family", name: .init(de: "Familienzimmer", en: "Family room"), price: 110,
              occupancy: .init(de: "2 Erwachsene & 1 Kind bis 6 Jahre", en: "2 adults & 1 child up to age 6"),
              description: .init(de: "Ein liebevoll eingerichtetes Zimmer für kleine Familien mit Kinderbett.", en: "A lovingly furnished room for a small family, with a child’s bed."), images: ["galerie-08", "galerie-09"]),
        .init(id: "family2", name: .init(de: "Familienzimmer 2", en: "Large family room"), price: 120,
              occupancy: .init(de: "Bis zu 3 Erwachsene & 1 Kind", en: "Up to 3 adults & 1 child"),
              description: .init(de: "Unsere größere Familienvariante bietet flexible Schlafmöglichkeiten für Ihren gemeinsamen Aufenthalt.", en: "Our larger family option offers flexible sleeping arrangements for your stay together."), images: ["galerie-10", "galerie-11"]),
        .init(id: "quad", name: .init(de: "Vierbettzimmer", en: "Quadruple room"), price: 130,
              occupancy: .init(de: "Für 4 Personen", en: "For 4 guests"),
              description: .init(de: "Gemeinsam reisen und dennoch komfortabel wohnen – mit ausreichend Platz für vier Personen.", en: "Travel together without giving up comfort, with ample room for four guests."), images: ["galerie-12", "galerie-13"]),
        .init(id: "basement", name: .init(de: "Souterrain Zimmer", en: "Lower-ground-floor room"), price: 65,
              occupancy: .init(de: "Für 1–2 Personen", en: "For 1–2 guests"),
              description: .init(de: "Ein ruhiges, angenehm kühles Zimmer im Souterrain – ideal für einen unkomplizierten Aufenthalt.", en: "A quiet, pleasantly cool lower-ground-floor room, ideal for an easy stay."), images: ["galerie-14", "galerie-15"])
    ]

    static let galleryImages = (1...25).map { String(format: "galerie-%02d", $0) }
}
