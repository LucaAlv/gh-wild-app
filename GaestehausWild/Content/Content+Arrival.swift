import Foundation

extension Content.Arrival {
    static let routes: [TransitRoute] = [
        .init(
            id: "messe",
            destination: .init(de: "Messe Nürnberg", en: "Nuremberg Exhibition Centre"),
            symbol: "building.2",
            durationSummary: .init(de: "ca. 45 Min.", en: "about 45 min"),
            steps: [
                .init(de: "Etwa 12 Minuten zum Bahnhof Unterasbach laufen.", en: "Walk about 12 minutes to Unterasbach station."),
                .init(de: "Mit der S4 Richtung Nürnberg Hauptbahnhof fahren.", en: "Take the S4 towards Nürnberg Hauptbahnhof."),
                .init(de: "Am Hauptbahnhof in die U1 Richtung Langwasser Süd umsteigen.", en: "At Hauptbahnhof, change to U1 towards Langwasser Süd."),
                .init(de: "An der Haltestelle Messe aussteigen; den passenden Eingang auf dem Messeticket prüfen.", en: "Get off at Messe; check the entrance printed on your exhibition ticket.")
            ],
            tip: .init(de: "An Messetagen etwas Puffer für volle Züge und den Weg vom Bahnsteig zum Eingang einplanen.", en: "On exhibition days, allow extra time for busy trains and the walk from the platform to your entrance.")
        ),
        .init(
            id: "hauptbahnhof",
            destination: .init(de: "Nürnberg Hauptbahnhof", en: "Nuremberg Central Station"),
            symbol: "train.side.front.car",
            durationSummary: .init(de: "ca. 25 Min.", en: "about 25 min"),
            steps: [
                .init(de: "Etwa 12 Minuten zum Bahnhof Unterasbach laufen.", en: "Walk about 12 minutes to Unterasbach station."),
                .init(de: "Mit der S4 Richtung Nürnberg Hauptbahnhof fahren.", en: "Take the S4 towards Nürnberg Hauptbahnhof."),
                .init(de: "Der Hauptbahnhof ist die Endstation; der Altstadtausgang führt Richtung Königstor.", en: "Hauptbahnhof is the final stop; use the old-town exit towards Königstor.")
            ],
            tip: .init(de: "Vor dem Losgehen die nächste Verbindung in der VGN-App prüfen – abends und am Wochenende ändern sich die Takte.", en: "Before leaving, check the next service in the VGN app—frequencies change in the evenings and at weekends.")
        ),
        .init(
            id: "airport",
            destination: .init(de: "Flughafen Nürnberg", en: "Nuremberg Airport"),
            symbol: "airplane",
            durationSummary: .init(de: "ca. 45–55 Min.", en: "about 45–55 min"),
            steps: [
                .init(de: "Zum Bahnhof Unterasbach laufen und die S4 Richtung Nürnberg Hauptbahnhof nehmen.", en: "Walk to Unterasbach station and take the S4 towards Nürnberg Hauptbahnhof."),
                .init(de: "Am Hauptbahnhof in die U2 Richtung Flughafen umsteigen.", en: "At Hauptbahnhof, change to U2 towards Flughafen."),
                .init(de: "Die U2 endet direkt am Flughafenterminal.", en: "The U2 terminates directly at the airport terminal.")
            ],
            tip: .init(de: "Mit großem Gepäck ist ein Taxi direkt ab dem Gästehaus deutlich bequemer; wir helfen gerne bei der Bestellung.", en: "With large luggage, a taxi from the guesthouse is much easier; we are happy to help arrange one.")
        )
    ]
}
