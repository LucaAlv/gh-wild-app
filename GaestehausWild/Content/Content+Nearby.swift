import Foundation

extension Content {
    static let nearbyPlaces: [NearbyPlace] = [
        .init(
            id: "palm-beach",
            name: .init(de: "Kristall Palm Beach", en: "Kristall Palm Beach"),
            subtitle: .init(de: "Ca. 8 Minuten mit dem Auto", en: "About 8 minutes by car"),
            description: .init(de: "Das beliebte Freizeit- und Thermalbad in Stein bietet Bade-, Wellness- und Entspannungsmöglichkeiten für die ganze Familie.", en: "This popular leisure and thermal spa in Stein offers swimming, wellness and relaxation for the whole family."),
            image: "nearby-01", latitude: 49.4078, longitude: 11.0068
        ),
        .init(
            id: "playmobil",
            name: .init(de: "PLAYMOBIL-FunPark", en: "PLAYMOBIL FunPark"),
            subtitle: .init(de: "Familienausflug in der Umgebung", en: "A family day out nearby"),
            description: .init(de: "Nur eine kurze Autofahrt entfernt liegt der PLAYMOBIL-FunPark in Zirndorf. Hier können Kinder spielen, entdecken und aktiv werden.", en: "A short drive away in Zirndorf, the PLAYMOBIL FunPark gives children plenty of space to play, explore and get active."),
            image: "nearby-03", latitude: 49.4307, longitude: 10.9410
        ),
        .init(
            id: "nuremberg",
            name: .init(de: "Nürnberger Altstadt", en: "Nuremberg Old Town"),
            subtitle: .init(de: "Ca. 10 Minuten mit der Bahn", en: "About 10 minutes by train"),
            description: .init(de: "Die historische Altstadt mit Sehenswürdigkeiten, Museen und Einkaufsmöglichkeiten ist mit der Bahn schnell erreichbar.", en: "The historic old town, with its sights, museums and shops, is easy to reach by train."),
            image: "nearby-02", latitude: 49.4539, longitude: 11.0775
        )
    ]
}
