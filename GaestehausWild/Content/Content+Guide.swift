import Foundation

extension Content {
    static let guide: [GuideEntry] = [
        .init(
            id: "emergency-112",
            symbol: "cross.case.fill",
            title: .init(de: "Notruf 112", en: "Emergency number 112"),
            answer: .init(de: "Bei medizinischen Notfällen oder Feuer rufen Sie sofort die 112 an. Die Nummer funktioniert europaweit.", en: "For a medical emergency or fire, call 112 immediately. The number works throughout Europe."),
            keywords: ["Rettungsdienst Feuerwehr Unfall Arzt ambulance fire medical doctor"],
            category: .emergency,
            actions: [.call("tel:112")]
        ),
        .init(
            id: "emergency-110",
            symbol: "shield.fill",
            title: .init(de: "Polizei 110", en: "Police 110"),
            answer: .init(de: "In einer akuten Gefahrensituation erreichen Sie die Polizei unter 110.", en: "If you are in immediate danger, call the police on 110."),
            keywords: ["Gefahr Diebstahl Einbruch theft danger"],
            category: .emergency,
            actions: [.call("tel:110")]
        ),
        .init(
            id: "adjustable-headboards",
            symbol: "bed.double",
            title: .init(de: "Höhenverstellbare Kopfteile", en: "Adjustable headboards"),
            answer: .init(de: "Die Kopfteile der Betten lassen sich für eine bequemere Sitz- oder Schlafposition verstellen.", en: "The bed headboards can be adjusted for a more comfortable sitting or sleeping position."),
            keywords: ["Bett Kopfteil schlafen bed sleep"],
            category: .room
        ),
        .init(
            id: "fan",
            symbol: "fan",
            title: .init(de: "Ventilator", en: "Fan"),
            answer: .init(de: "Im Sommer steht in Ihrem Zimmer ein Ventilator bereit.", en: "A fan is provided in your room during the summer."),
            keywords: ["heiss warm Sommer cooling hot"],
            category: .room
        ),
        .init(
            id: "extra-bedding",
            symbol: "snowflake",
            title: .init(de: "Zusätzliche Kissen & Decken", en: "Extra pillows & blankets"),
            answer: .init(de: "Zusätzliche Kissen und Wolldecken erhalten Sie gerne auf Nachfrage.", en: "Extra pillows and wool blankets are available on request."),
            keywords: ["Kopfkissen Bettdecke kalt pillow duvet bedding cold"],
            category: .room,
            actions: [.call(Content.phoneURL)]
        ),
        .init(
            id: "minibar-fridge",
            symbol: "cabinet",
            title: .init(de: "Minibar & Kühlschrank", en: "Minibar & fridge"),
            answer: .init(de: "Die leere Minibar in Ihrem Zimmer können Sie als Kühlschrank für eigene Lebensmittel und Getränke nutzen.", en: "The empty minibar in your room can be used as a fridge for your own food and drinks."),
            keywords: ["kühlen Getränke Lebensmittel refrigerator cool drinks food"],
            category: .room
        ),
        .init(
            id: "safe-smoke-detector",
            symbol: "lock.shield",
            title: .init(de: "Safe & Rauchmelder", en: "Safe & smoke detector"),
            answer: .init(de: "Ihr Zimmer ist mit einem Safe und einem Rauchmelder ausgestattet.", en: "Your room is equipped with a safe and smoke detector."),
            keywords: ["Wertsachen Sicherheit Feuer valuables security fire alarm"],
            category: .room
        ),
        .init(
            id: "towels",
            symbol: "square.stack",
            title: .init(de: "Handtücher", en: "Towels"),
            answer: .init(de: "Ausreichend Handtücher liegen im Zimmer bereit. Wenn Sie weitere benötigen, sprechen Sie uns gerne an.", en: "Plenty of towels are provided in your room. Please ask us if you need more."),
            keywords: ["Badetuch Dusche towel bathroom shower linen"],
            category: .room,
            actions: [.call(Content.phoneURL)]
        ),
        .init(
            id: "hairdryer",
            symbol: "wind",
            title: .init(de: "Föhn", en: "Hair dryer"),
            answer: .init(de: "Ein Föhn gehört zur Ausstattung Ihres Zimmers.", en: "A hair dryer is provided in your room."),
            keywords: ["Haare trocknen hairdryer blow dryer dry hair"],
            category: .room
        ),
        // FAMILIE BESTÄTIGEN: Bedienung und Verfügbarkeit der Heizung prüfen.
        .init(
            id: "heating",
            symbol: "thermometer.medium",
            title: .init(de: "Heizung", en: "Heating"),
            answer: .init(de: "BITTE VON DER FAMILIE BESTÄTIGEN: So regeln Gäste die Heizung und erhalten bei Problemen Hilfe.", en: "PLEASE CONFIRM WITH THE FAMILY: How guests adjust the heating and get help with problems."),
            keywords: ["Heizkörper kalt warm Temperatur radiator cold temperature"],
            category: .room,
            actions: [.call(Content.phoneURL)]
        ),
        // FAMILIE BESTÄTIGEN: Gibt es Bügeleisen/Bügelbrett und wo wird es ausgegeben?
        .init(
            id: "iron",
            symbol: "washer",
            title: .init(de: "Bügeleisen", en: "Iron"),
            answer: .init(de: "BITTE VON DER FAMILIE BESTÄTIGEN: Verfügbarkeit und Ausgabe von Bügeleisen und Bügelbrett.", en: "PLEASE CONFIRM WITH THE FAMILY: Availability and collection of an iron and ironing board."),
            keywords: ["bügeln Kleidung Hemd ironing board clothes shirt"],
            category: .room,
            actions: [.call(Content.phoneURL)]
        ),
        .init(
            id: "wifi",
            symbol: "wifi",
            title: .init(de: "WLAN", en: "Wi-Fi"),
            answer: .init(de: "Das Gast-WLAN ist kostenlos. Den QR-Code und das Passwort finden Sie im Sofort-Zugriff.", en: "Guest Wi-Fi is free. Find the QR code and password in Instant Access."),
            keywords: ["Internet Netzwerk Passwort password network wireless"],
            category: .house,
            actions: [.page(.guestNow)]
        ),
        .init(
            id: "coffee-station",
            symbol: "cup.and.saucer",
            title: .init(de: "Kaffee & Wasserkocher", en: "Coffee & kettle"),
            answer: .init(de: "In der Lobby stehen ein Wasserkocher und eine Kaffeemaschine bereit.", en: "A kettle and coffee machine are available in the lobby."),
            keywords: ["Tee Heisswasser tea hot water machine"],
            category: .house
        ),
        .init(
            id: "accessible-rooms",
            symbol: "figure.roll",
            title: .init(de: "Barrierefreie Zimmer", en: "Accessible rooms"),
            answer: .init(de: "Barrierefreie Zimmer sind nach vorheriger Absprache verfügbar. Bitte sprechen Sie uns an.", en: "Accessible rooms are available by prior arrangement. Please contact us."),
            keywords: ["Rollstuhl Aufzug wheelchair mobility lift accessibility"],
            category: .house,
            actions: [.call(Content.phoneURL)]
        ),
        .init(
            id: "pets",
            symbol: "pawprint",
            title: .init(de: "Haustiere", en: "Pets"),
            answer: .init(de: "Zwei- und Vierbeiner sind bei uns willkommen. Bitte stimmen Sie Ihren Aufenthalt mit Haustier vorab mit uns ab.", en: "Two- and four-legged guests are welcome. Please arrange stays with pets with us in advance."),
            keywords: ["Hund Katze Tiere dog cat animal"],
            category: .house,
            actions: [.call(Content.phoneURL)]
        ),
        .init(
            id: "non-smoking",
            symbol: "nosign",
            title: .init(de: "Rauchen", en: "Smoking"),
            answer: .init(de: "Alle Zimmer sind Nichtraucherzimmer. Bitte rauchen Sie nicht im Haus.", en: "All rooms are non-smoking. Please do not smoke inside the guesthouse."),
            keywords: ["Zigarette Nichtraucher cigarette vape non-smoking"],
            category: .house
        ),
        .init(
            id: "bike-storage",
            symbol: "bicycle",
            title: .init(de: "Fahrrad abstellen", en: "Bicycle storage"),
            answer: .init(de: "Hinter dem Haus können Sie Ihr Fahrrad sicher und unzugänglich abstellen.", en: "You can store your bicycle securely behind the guesthouse, out of public reach."),
            keywords: ["Rad E-Bike Lagerung cycle bike storage"],
            category: .house
        ),
        .init(
            id: "ev-charging",
            symbol: "bolt.car",
            title: .init(de: "Elektroauto laden", en: "EV charging"),
            answer: .init(de: "Eine öffentliche Ladestation für Elektroautos befindet sich in der Nähe.", en: "A public electric-vehicle charging point is available nearby."),
            keywords: ["E-Auto Ladesäule Strom electric car charger charging"],
            category: .practical,
            actions: [.map(query: "E-Auto Ladestation in der Nähe von Gästehaus Wild Oberasbach")]
        ),
        // FAMILIE BESTÄTIGEN: Genaue Ruhezeiten und Verhalten bei später Rückkehr eintragen.
        .init(
            id: "quiet-hours",
            symbol: "moon.zzz",
            title: .init(de: "Nachtruhe", en: "Quiet hours"),
            answer: .init(de: "BITTE VON DER FAMILIE BESTÄTIGEN: Genaue Ruhezeiten und Hinweise für eine späte Rückkehr.", en: "PLEASE CONFIRM WITH THE FAMILY: Exact quiet hours and guidance for returning late."),
            keywords: ["leise Lärm schlafen night noise sleep silence"],
            category: .house
        ),
        // FAMILIE BESTÄTIGEN: Mülltrennung, Behälter und Standort beschreiben.
        .init(
            id: "waste-recycling",
            symbol: "arrow.3.trianglepath",
            title: .init(de: "Müll & Recycling", en: "Waste & recycling"),
            answer: .init(de: "BITTE VON DER FAMILIE BESTÄTIGEN: Mülltrennung und Standort der Behälter für Gäste.", en: "PLEASE CONFIRM WITH THE FAMILY: Recycling rules and the location of guest waste bins."),
            keywords: ["Abfall Glas Papier Plastik bins rubbish trash garbage"],
            category: .house
        ),
        .init(
            id: "parking",
            symbol: "parkingsign",
            title: .init(de: "Parken", en: "Parking"),
            answer: Content.StayCopy.parking,
            keywords: ["Auto Stellplatz kostenlos car space free"],
            category: .practical,
            actions: [.map(query: "Gästehaus Wild Jahnstraße 77 Oberasbach")]
        ),
        .init(
            id: "hainberg",
            symbol: "leaf",
            title: .init(de: "Naturschutzgebiet Hainberg", en: "Hainberg nature reserve"),
            answer: .init(de: "Das Naturschutzgebiet Hainberg erreichen Sie in etwa zwei Minuten zu Fuß.", en: "The Hainberg nature reserve is about a two-minute walk away."),
            keywords: ["Spaziergang Natur laufen walk outdoors nature reserve"],
            category: .practical,
            actions: [.map(query: "Naturschutzgebiet Hainberg Oberasbach")]
        ),
        // FAMILIE BESTÄTIGEN: Akzeptierte Zahlungsarten und Zahlungszeitpunkt eintragen.
        .init(
            id: "payment",
            symbol: "creditcard",
            title: .init(de: "Bezahlung", en: "Payment"),
            answer: .init(de: "BITTE VON DER FAMILIE BESTÄTIGEN: Akzeptierte Zahlungsarten und Zeitpunkt der Bezahlung.", en: "PLEASE CONFIRM WITH THE FAMILY: Accepted payment methods and when payment is due."),
            keywords: ["Karte bar Rechnung Kreditkarte cash card invoice bill"],
            category: .practical,
            actions: [.call(Content.phoneURL)]
        ),
        .init(
            id: "breakfast",
            symbol: "cup.and.saucer.fill",
            title: .init(de: "Frühstück", en: "Breakfast"),
            answer: .init(de: "Montag bis Samstag von 7:00 bis 10:00 Uhr, sonntags von 8:00 bis 10:00 Uhr. Bitte teilen Sie uns Allergien mit.", en: "Monday to Saturday from 7:00 to 10:00 am, Sundays from 8:00 to 10:00 am. Please tell us about any allergies."),
            keywords: ["Frühstückszeit Allergie Gluten Laktose morning food allergy"],
            category: .food,
            actions: [.page(.breakfast)]
        ),
        // FAMILIE BESTÄTIGEN: Empfohlene Bäckerei auswählen.
        .init(
            id: "bakery",
            symbol: "birthday.cake",
            title: .init(de: "Bäckerei", en: "Bakery"),
            answer: .init(de: "BITTE VON DER FAMILIE BESTÄTIGEN: Empfohlene Bäckerei und aktuelle Öffnungszeiten.", en: "PLEASE CONFIRM WITH THE FAMILY: Recommended bakery and current opening hours."),
            keywords: ["Brötchen Brot Kuchen bread rolls cake breakfast"],
            category: .food,
            actions: [.map(query: "Bäckerei in der Nähe von Gästehaus Wild Oberasbach")]
        ),
        // FAMILIE BESTÄTIGEN: Empfohlene Apotheke und Notdienst-Hinweis auswählen.
        .init(
            id: "pharmacy",
            symbol: "cross.case",
            title: .init(de: "Apotheke", en: "Pharmacy"),
            answer: .init(de: "BITTE VON DER FAMILIE BESTÄTIGEN: Nächste empfohlene Apotheke und Hinweis zum Apotheken-Notdienst.", en: "PLEASE CONFIRM WITH THE FAMILY: Nearest recommended pharmacy and out-of-hours pharmacy guidance."),
            keywords: ["Medikamente Medizin Notdienst medicine chemist prescription"],
            category: .practical,
            actions: [.map(query: "Apotheke in der Nähe von Gästehaus Wild Oberasbach")]
        ),
        // FAMILIE BESTÄTIGEN: Hausarzt/ärztlichen Bereitschaftsdienst prüfen.
        .init(
            id: "doctor",
            symbol: "stethoscope",
            title: .init(de: "Arzt", en: "Doctor"),
            answer: .init(de: "BITTE VON DER FAMILIE BESTÄTIGEN: Empfohlene Praxis und Vorgehen außerhalb der Sprechzeiten. Bei einem Notfall immer 112 wählen.", en: "PLEASE CONFIRM WITH THE FAMILY: Recommended practice and what to do outside surgery hours. Always call 112 in an emergency."),
            keywords: ["Hausarzt krank Praxis medical GP ill clinic"],
            category: .practical,
            actions: [.map(query: "Arzt in der Nähe von Gästehaus Wild Oberasbach")]
        ),
        // FAMILIE BESTÄTIGEN: Bevorzugtes Taxiunternehmen und Rufnummer eintragen.
        .init(
            id: "taxi",
            symbol: "car.side.fill",
            title: .init(de: "Taxi", en: "Taxi"),
            answer: .init(de: "BITTE VON DER FAMILIE BESTÄTIGEN: Bevorzugtes Taxiunternehmen. Bis dahin helfen wir Ihnen gerne bei der Bestellung.", en: "PLEASE CONFIRM WITH THE FAMILY: Preferred taxi company. Until then, we are happy to help arrange one."),
            keywords: ["Fahrt Bahnhof Flughafen cab ride station airport"],
            category: .practical,
            actions: [.call(Content.phoneURL), .map(query: "Taxi in Oberasbach")]
        ),
        .init(
            id: "check-in",
            symbol: "clock",
            title: .init(de: "Check-in", en: "Check-in"),
            answer: .init(de: "Ihr Zimmer steht am Anreisetag ab 15:00 Uhr für Sie bereit.", en: "Your room is ready from 3:00 pm on your arrival day."),
            keywords: ["Ankunft Einchecken Zimmer beziehen arrival time room"],
            category: .departure
        ),
        .init(
            id: "check-out",
            symbol: "clock.arrow.circlepath",
            title: .init(de: "Check-out", en: "Check-out"),
            answer: .init(de: "Bitte geben Sie Ihr Zimmer am Abreisetag bis 11:00 Uhr frei.", en: "Please vacate your room by 11:00 am on departure day."),
            keywords: ["Abreise Auschecken Schlüssel departure leave time"],
            category: .departure
        ),
        .init(
            id: "key-handover",
            symbol: "key",
            title: .init(de: "Schlüsselübergabe", en: "Key handover"),
            answer: Content.StayCopy.keyHandover,
            keywords: ["Zimmerschlüssel Ankunft key room arrival"],
            category: .departure,
            actions: [.call(Content.phoneURL)]
        ),
        .init(
            id: "late-arrival",
            symbol: "moon.stars",
            title: .init(de: "Späte Anreise", en: "Late arrival"),
            answer: Content.StayCopy.lateArrival,
            keywords: ["verspätet nachts später Schlüssel late night delayed"],
            category: .departure,
            actions: [.call(Content.phoneURL)]
        ),
        // FAMILIE BESTÄTIGEN: Möglichkeiten zur Gepäckaufbewahrung vor/nach dem Aufenthalt prüfen.
        .init(
            id: "luggage",
            symbol: "suitcase.rolling",
            title: .init(de: "Gepäck aufbewahren", en: "Luggage storage"),
            answer: .init(de: "BITTE VON DER FAMILIE BESTÄTIGEN: Aufbewahrung von Gepäck vor dem Check-in oder nach dem Check-out. Bitte fragen Sie uns vorab.", en: "PLEASE CONFIRM WITH THE FAMILY: Luggage storage before check-in or after check-out. Please ask us in advance."),
            keywords: ["Koffer Tasche früher später baggage bags suitcase storage"],
            category: .departure,
            actions: [.call(Content.phoneURL)]
        )
    ]
}
