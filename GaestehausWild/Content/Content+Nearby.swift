import Foundation

extension Content {
    static let nearbyIntro = LocalizedText(
        de: "Lieblingsorte der Familie Wild – mit ehrlichen Wegzeiten und allem, was Sie unterwegs auch ohne Internet wissen möchten.",
        en: "The Wild family’s favourite places—with honest travel times and the essentials you may need without internet access."
    )

    static let nearbyPlaces: [NearbyPlace] = [
        .init(
            id: "hainberg",
            name: .init(de: "Naturschutzgebiet Hainberg", en: "Hainberg nature reserve"),
            subtitle: .init(de: "Direkt vor der Haustür", en: "Right on the doorstep"),
            description: .init(de: "Offene Sandflächen, lichte Kiefern und ruhige Wege machen den Hainberg ideal für einen Spaziergang oder eine Laufrunde.", en: "Open sandy areas, pine trees and quiet paths make the Hainberg ideal for a walk or a run."),
            latitude: 49.4198, longitude: 10.9885,
            categories: [.nature, .withKids],
            travel: [.init(minutes: 2, mode: .walk)],
            familyNote: .init(de: "Unser schnellster Tapetenwechsel: Hinter dem Haus beginnt schon die Natur. Nach Regen sind feste Schuhe hilfreich.", en: "Our quickest change of scenery: nature starts just behind the house. Sturdy shoes help after rain."),
            website: "https://www.oberasbach.de/leben-erleben/freizeit-sport-naherholung"
        ),
        .init(
            id: "gasthof-kettler",
            name: .init(de: "Gasthof Kettler", en: "Gasthof Kettler"),
            subtitle: .init(de: "Fränkische Küche mit Biergarten", en: "Franconian food and beer garden"),
            description: .init(de: "Ein klassischer Oberasbacher Gasthof für regionale Küche und einen unkomplizierten Abend in der Nähe.", en: "A classic Oberasbach inn for regional food and an easy evening close by."),
            latitude: 49.4318, longitude: 10.9710,
            categories: [.food],
            travel: [.init(minutes: 6, mode: .car), .init(minutes: 24, mode: .walk)],
            openingHours: .init(de: "Öffnungstage bitte vorab prüfen", en: "Please check opening days before visiting"),
            familyNote: .init(de: "Gerade am Wochenende empfehlen wir, kurz anzurufen und einen Tisch zu reservieren.", en: "At weekends in particular, we recommend calling ahead to reserve a table."),
            website: "https://www.gasthof-kettler.de/",
            phone: "+49911692210"
        ),
        .init(
            id: "frische-quelle",
            name: .init(de: "Landgasthof Zur frischen Quelle", en: "Zur frischen Quelle country inn"),
            subtitle: .init(de: "Landgasthof in Rehdorf", en: "Country inn in Rehdorf"),
            description: .init(de: "Ein bodenständiger Landgasthof westlich von Oberasbach – gut mit einem Ausflug Richtung Cadolzburg zu verbinden.", en: "A down-to-earth country inn west of Oberasbach, easy to combine with a trip towards Cadolzburg."),
            latitude: 49.4147, longitude: 10.9186,
            categories: [.food],
            travel: [.init(minutes: 12, mode: .car), .init(minutes: 28, mode: .bike)],
            openingHours: .init(de: "Öffnungszeiten bitte vorab prüfen", en: "Please check opening hours before visiting"),
            familyNote: .init(de: "Ideal, wenn Sie ohnehin mit dem Auto westwärts unterwegs sind; ohne Auto ist der Weg weniger praktisch.", en: "Ideal if you are already heading west by car; without a car the route is less convenient."),
            website: "http://landgasthof-frische-quelle.de/pension/",
            phone: "+4991198062068"
        ),
        .init(
            id: "palm-beach",
            name: .init(de: "Kristall Palm Beach", en: "Kristall Palm Beach"),
            subtitle: .init(de: "Therme, Rutschen & Sauna", en: "Thermal baths, slides & sauna"),
            description: .init(de: "Freizeitbad und Therme in Stein mit Rutschenwelt, Innen- und Außenbecken sowie großem Saunabereich.", en: "Leisure and thermal baths in Stein with waterslides, indoor and outdoor pools and a large sauna area."),
            latitude: 49.4078, longitude: 11.0068,
            categories: [.withKids, .rainyDay], image: "nearby-01",
            travel: [.init(minutes: 8, mode: .car), .init(minutes: 20, mode: .bike)],
            openingHours: .init(de: "Täglich; aktuelle Zeiten online prüfen", en: "Daily; check current hours online"),
            priceHint: .init(de: "Verschiedene Zeit- und Saunatarife", en: "Various timed and sauna rates"),
            familyNote: .init(de: "Für Regentage sehr beliebt. In Ferienzeiten lohnt es sich, früh zu starten und die Auslastung online zu prüfen.", en: "Very popular on rainy days. During school holidays, go early and check capacity online."),
            website: "https://palm-beach.de/"
        ),
        .init(
            id: "playmobil",
            name: .init(de: "PLAYMOBIL-FunPark", en: "PLAYMOBIL FunPark"),
            subtitle: .init(de: "Spielen, klettern und entdecken", en: "Play, climb and explore"),
            description: .init(de: "Großzügiger Aktivpark in Zirndorf mit PLAYMOBIL-Welten, Wasserspielplatz und überdachtem Bereich.", en: "A large activity park in Zirndorf with PLAYMOBIL worlds, a water playground and an indoor area."),
            latitude: 49.4307, longitude: 10.9410,
            categories: [.withKids], image: "nearby-03",
            travel: [.init(minutes: 10, mode: .car), .init(minutes: 22, mode: .bike)],
            openingHours: .init(de: "Saisonal; Kalendertag vorab online prüfen", en: "Seasonal; check your date online in advance"),
            priceHint: .init(de: "Online-Tickets sind oft günstiger", en: "Online tickets are often cheaper"),
            familyNote: .init(de: "Badesachen und Wechselkleidung einpacken – der Wasserspielplatz gewinnt fast immer.", en: "Pack swimwear and spare clothes—the water playground almost always wins."),
            website: "https://www.playmobil-funpark.de/"
        ),
        .init(
            id: "zirndorf-museum",
            name: .init(de: "Städtisches Museum Zirndorf", en: "Zirndorf Municipal Museum"),
            subtitle: .init(de: "Blechspielzeug & Stadtgeschichte", en: "Tin toys & local history"),
            description: .init(de: "Ein kleines Museum in der Zirndorfer Altstadt über die örtliche Spielzeugindustrie und die Geschichte der Stadt.", en: "A small old-town museum about Zirndorf’s toy industry and local history."),
            latitude: 49.4425, longitude: 10.9542,
            categories: [.rainyDay, .withKids],
            travel: [.init(minutes: 10, mode: .car), .init(minutes: 28, mode: .bike)],
            openingHours: .init(de: "Begrenzte Öffnungstage – unbedingt vorab prüfen", en: "Limited opening days—please check ahead"),
            familyNote: .init(de: "Überschaubar und deshalb gut für ein kurzes Regenfenster; danach passt ein Altstadtbummel.", en: "Compact and ideal for a short spell of rain; pair it with a stroll through the old town."),
            website: "https://www.zirndorf.de/museum"
        ),
        .init(
            id: "alte-veste",
            name: .init(de: "Alte Veste", en: "Alte Veste"),
            subtitle: .init(de: "Waldspaziergang mit Aussichtsturm", en: "Woodland walk and lookout tower"),
            description: .init(de: "Bewaldeter Höhenzug zwischen Zirndorf und Fürth mit Wegen, Aussichtsturm und Spuren aus dem Dreißigjährigen Krieg.", en: "A wooded ridge between Zirndorf and Fürth with walking trails, a lookout tower and Thirty Years’ War history."),
            latitude: 49.4510, longitude: 10.9663,
            categories: [.nature, .withKids],
            travel: [.init(minutes: 10, mode: .car), .init(minutes: 27, mode: .bike)],
            familyNote: .init(de: "Der Turm ist ein schönes Ziel, aber nicht immer geöffnet. Der Waldspaziergang lohnt sich trotzdem.", en: "The tower is a lovely goal but is not always open. The woodland walk is still worthwhile."),
            website: "https://www.zirndorf-tourismus.de/"
        ),
        .init(
            id: "faber-castell",
            name: .init(de: "Faber-Castell Schloss & Museum", en: "Faber-Castell Castle & Museum"),
            subtitle: .init(de: "Industriekultur in Stein", en: "Industrial heritage in Stein"),
            description: .init(de: "Schloss, historische Fertigung und Museum erzählen die Geschichte der bekannten Stifte aus Stein.", en: "The castle, historic production rooms and museum tell the story of Stein’s famous pencils."),
            latitude: 49.4062, longitude: 11.0137,
            categories: [.rainyDay, .shopping],
            travel: [.init(minutes: 10, mode: .car), .init(minutes: 24, mode: .bike)],
            openingHours: .init(de: "Besichtigung meist nur mit gebuchter Führung", en: "Visits generally require a pre-booked tour"),
            familyNote: .init(de: "Nicht spontan losfahren: Führungen und Museumstage unbedingt vorher prüfen und buchen.", en: "Do not set off spontaneously: check and book tours and museum days in advance."),
            website: "https://www.faber-castell.de/corporate/faber-castell-erleben"
        ),
        .init(
            id: "rednitzgrund",
            name: .init(de: "Rednitzgrund", en: "Rednitz valley"),
            subtitle: .init(de: "Ruhige Wege am Fluss", en: "Quiet riverside paths"),
            description: .init(de: "Flache Wege entlang der Rednitz eignen sich für Spaziergänge und Radtouren zwischen Stein, Oberasbach und Fürth.", en: "Flat paths along the Rednitz are ideal for walks and bike rides between Stein, Oberasbach and Fürth."),
            latitude: 49.4278, longitude: 11.0010,
            categories: [.nature, .withKids],
            travel: [.init(minutes: 12, mode: .bike), .init(minutes: 28, mode: .walk)],
            familyNote: .init(de: "Für eine entspannte Radrunde bestens geeignet. Nach längeren Regenfällen können einzelne Wege matschig sein.", en: "Excellent for an easy bike loop. Some paths can be muddy after prolonged rain."),
            website: "https://www.oberasbach.de/leben-erleben/freizeit-sport-naherholung"
        ),
        .init(
            id: "cadolzburg",
            name: .init(de: "Burg Cadolzburg", en: "Cadolzburg Castle"),
            subtitle: .init(de: "Mitmachmuseum in einer Hohenzollernburg", en: "Hands-on museum in a Hohenzollern castle"),
            description: .init(de: "Die Ausstellung »HerrschaftsZeiten!« macht das Mittelalter in einer eindrucksvollen Burganlage interaktiv erlebbar.", en: "The ‘A Time of Rulers’ exhibition brings the Middle Ages to life inside an impressive castle complex."),
            latitude: 49.4587, longitude: 10.8528,
            categories: [.withKids, .rainyDay],
            travel: [.init(minutes: 20, mode: .car)],
            openingHours: .init(de: "Montags meist geschlossen; aktuelle Zeiten prüfen", en: "Usually closed Mondays; check current hours"),
            familyNote: .init(de: "Mehr Zeit einplanen als für ein klassisches Burgmuseum – viele Stationen wollen ausprobiert werden.", en: "Allow more time than for a traditional castle museum—there are many hands-on stations."),
            website: "https://www.burg-cadolzburg.de/"
        ),
        .init(
            id: "nuernberg-altstadt",
            name: .init(de: "Nürnberger Altstadt", en: "Nuremberg Old Town"),
            subtitle: .init(de: "Kaiserburg, Hauptmarkt & Fachwerk", en: "Imperial Castle, Hauptmarkt & half-timbering"),
            description: .init(de: "Vom Hauptmarkt führen kurze Wege zur Kaiserburg, an die Pegnitz und durch die historischen Gassen.", en: "From the Hauptmarkt, short walks lead to the Imperial Castle, the Pegnitz and historic lanes."),
            latitude: 49.4542, longitude: 11.0771,
            categories: [.shopping, .food], image: "nearby-02",
            travel: [.init(minutes: 25, mode: .car), .init(minutes: 35, mode: .transit, note: .init(de: "Bus nach Stein, dann U2/U3 bis Opernhaus oder Hauptbahnhof", en: "Bus to Stein, then U2/U3 to Opernhaus or Hauptbahnhof"))],
            familyNote: .init(de: "Für einen ersten Besuch am Opernhaus aussteigen und durch die Altstadt bis zur Burg laufen – so geht es stetig bergauf statt bergab.", en: "For a first visit, get off at Opernhaus and walk through the old town to the castle—this keeps the route steadily uphill."),
            website: "https://tourismus.nuernberg.de/"
        ),
        .init(
            id: "kaiserburg",
            name: .init(de: "Kaiserburg Nürnberg", en: "Nuremberg Imperial Castle"),
            subtitle: .init(de: "Burganlage über der Altstadt", en: "Castle complex above the old town"),
            description: .init(de: "Wahrzeichen der Stadt mit Palas, Museum, Tiefem Brunnen und weitem Blick über Nürnbergs Dächer.", en: "The city landmark offers a palace, museum, deep well and wide views across Nuremberg’s rooftops."),
            latitude: 49.4579, longitude: 11.0750,
            categories: [.rainyDay, .withKids],
            travel: [.init(minutes: 28, mode: .car), .init(minutes: 42, mode: .transit)],
            openingHours: .init(de: "Saisonal unterschiedliche Zeiten", en: "Hours vary by season"),
            familyNote: .init(de: "Der Anstieg ist mit Kinderwagen machbar, aber steil. Der Burggarten ist eine schöne ruhige Pause.", en: "The climb is manageable with a pushchair but steep. The castle garden is a lovely quiet break."),
            website: "https://www.kaiserburg-nuernberg.de/"
        ),
        .init(
            id: "db-museum",
            name: .init(de: "DB Museum", en: "DB Museum"),
            subtitle: .init(de: "Eisenbahngeschichte & KinderBahnLand", en: "Railway history & children’s railway world"),
            description: .init(de: "Historische Lokomotiven und Wagen, Modelle und ein eigener Erlebnisbereich für Kinder direkt am Opernhaus.", en: "Historic locomotives and coaches, models and a dedicated children’s activity area by Opernhaus."),
            latitude: 49.4468, longitude: 11.0734,
            categories: [.rainyDay, .withKids],
            travel: [.init(minutes: 24, mode: .car), .init(minutes: 34, mode: .transit, note: .init(de: "Bus nach Stein, U2 bis Opernhaus", en: "Bus to Stein, U2 to Opernhaus"))],
            openingHours: .init(de: "Montags geschlossen", en: "Closed Mondays"),
            familyNote: .init(de: "Mit Kindern zuerst ins KinderBahnLand – später am Tag wird es dort oft voller.", en: "With children, visit the children’s railway area first—it often gets busier later."),
            website: "https://dbmuseum.de/nuernberg"
        ),
        .init(
            id: "germanisches-nationalmuseum",
            name: .init(de: "Germanisches Nationalmuseum", en: "Germanisches Nationalmuseum"),
            subtitle: .init(de: "Kunst und Kulturgeschichte", en: "Art and cultural history"),
            description: .init(de: "Das große kulturgeschichtliche Museum zeigt Kunst und Alltagskultur von der Frühzeit bis in die Gegenwart.", en: "This major cultural-history museum covers art and everyday culture from early history to the present."),
            latitude: 49.4482, longitude: 11.0755,
            categories: [.rainyDay],
            travel: [.init(minutes: 24, mode: .car), .init(minutes: 35, mode: .transit)],
            openingHours: .init(de: "Montags geschlossen", en: "Closed Mondays"),
            familyNote: .init(de: "Das Haus ist riesig: lieber zwei Themen auswählen als alles schaffen wollen. Familienangebote vorher prüfen.", en: "The museum is vast: choose two themes instead of trying to see everything. Check family activities ahead."),
            website: "https://www.gnm.de/"
        ),
        .init(
            id: "zukunftsmuseum",
            name: .init(de: "Deutsches Museum Nürnberg", en: "Deutsches Museum Nürnberg"),
            subtitle: .init(de: "Das Zukunftsmuseum", en: "The Museum of the Future"),
            description: .init(de: "Interaktive Ausstellungen zu Arbeit, Mobilität, Gesundheit und Technik der Zukunft im Augustinerhof.", en: "Interactive exhibitions on the future of work, mobility, health and technology in Augustinerhof."),
            latitude: 49.4548, longitude: 11.0741,
            categories: [.rainyDay, .withKids],
            travel: [.init(minutes: 27, mode: .car), .init(minutes: 40, mode: .transit)],
            openingHours: .init(de: "Montags geschlossen", en: "Closed Mondays"),
            familyNote: .init(de: "Für ältere Kinder und Jugendliche besonders stark. Für alle interaktiven Stationen mindestens zwei Stunden einplanen.", en: "Especially good for older children and teenagers. Allow at least two hours for the interactive stations."),
            website: "https://www.deutsches-museum.de/nuernberg"
        ),
        .init(
            id: "spielzeugmuseum",
            name: .init(de: "Spielzeugmuseum Nürnberg", en: "Nuremberg Toy Museum"),
            subtitle: .init(de: "Spielzeug aus mehreren Jahrhunderten", en: "Toys across the centuries"),
            description: .init(de: "Puppen, Blechspielzeug, Eisenbahnen und moderne Spielwelten in einem historischen Altstadthaus.", en: "Dolls, tin toys, model railways and modern play worlds in a historic old-town building."),
            latitude: 49.4557, longitude: 11.0739,
            categories: [.rainyDay, .withKids],
            travel: [.init(minutes: 27, mode: .car), .init(minutes: 41, mode: .transit)],
            openingHours: .init(de: "Montags geschlossen", en: "Closed Mondays"),
            familyNote: .init(de: "Im Sommer gehört der Außenspielbereich dazu. Das Museum lässt sich gut mit Hauptmarkt und Burg verbinden.", en: "In summer, include the outdoor play area. The museum combines well with Hauptmarkt and the castle."),
            website: "https://museen.nuernberg.de/spielzeugmuseum/"
        ),
        .init(
            id: "tiergarten",
            name: .init(de: "Tiergarten Nürnberg", en: "Nuremberg Zoo"),
            subtitle: .init(de: "Landschaftszoo mit Delphinlagune", en: "Landscape zoo with dolphin lagoon"),
            description: .init(de: "Weitläufiger Tiergarten im Reichswald mit Felsenlandschaft, Aquapark, Manatihaus und Bionicum.", en: "A spacious zoo in the Reichswald with rocky landscapes, Aquapark, manatee house and Bionicum."),
            latitude: 49.4498, longitude: 11.1465,
            categories: [.withKids, .nature],
            travel: [.init(minutes: 35, mode: .car), .init(minutes: 55, mode: .transit)],
            openingHours: .init(de: "Täglich; Schließzeit saisonabhängig", en: "Daily; closing time varies by season"),
            familyNote: .init(de: "Der Tiergarten ist sehr hügelig und groß – bequeme Schuhe, Wasser und einen halben bis ganzen Tag einplanen.", en: "The zoo is large and very hilly—wear comfortable shoes, bring water and allow half to a full day."),
            website: "https://tiergarten.nuernberg.de/"
        ),
        .init(
            id: "messe-nuernberg",
            name: .init(de: "Messe Nürnberg", en: "Nuremberg Exhibition Centre"),
            subtitle: .init(de: "Messegelände Langwasser", en: "Langwasser exhibition grounds"),
            description: .init(de: "Das Messezentrum mit den Eingängen Mitte, Ost und NCC liegt im Südosten Nürnbergs.", en: "The exhibition centre, with Mitte and Ost entrances and the NCC, is in south-east Nuremberg."),
            latitude: 49.4166, longitude: 11.1123,
            categories: [.fair],
            travel: [.init(minutes: 25, mode: .car, note: .init(de: "über Frankenschnellweg und Südwesttangente", en: "via Frankenschnellweg and Südwesttangente")), .init(minutes: 45, mode: .transit, note: .init(de: "Bus nach Stein, dann U2 und U1 bis Messe", en: "Bus to Stein, then U2 and U1 to Messe"))],
            openingHours: .init(de: "Je nach Veranstaltung", en: "Depends on the event"),
            familyNote: .init(de: "An Messetagen am besten vor 7:40 Uhr losfahren. Danach werden Frankenschnellweg und Parkzufahrten schnell voll.", en: "On fair days, leave before 7:40 am. The Frankenschnellweg and car-park approaches fill quickly afterwards."),
            website: "https://www.nuernbergmesse.de/"
        ),
        .init(
            id: "franken-center",
            name: .init(de: "Franken-Center", en: "Franken-Center"),
            subtitle: .init(de: "Einkaufszentrum in Langwasser", en: "Shopping centre in Langwasser"),
            description: .init(de: "Großes überdachtes Einkaufszentrum mit vielen Geschäften, Gastronomie und direktem U-Bahn-Anschluss.", en: "A large covered shopping centre with many shops, food options and a direct underground connection."),
            latitude: 49.4033, longitude: 11.1344,
            categories: [.shopping, .rainyDay],
            travel: [.init(minutes: 25, mode: .car), .init(minutes: 48, mode: .transit)],
            openingHours: .init(de: "Geschäfte meist Montag bis Samstag", en: "Shops generally Monday to Saturday"),
            familyNote: .init(de: "Praktisch mit einem Messetag zu verbinden. Sonntags bleiben die Geschäfte in der Regel geschlossen.", en: "Easy to combine with an exhibition day. Shops are generally closed on Sundays."),
            website: "https://www.franken-center-nuernberg.de/"
        ),
        .init(
            id: "fuerth-neue-mitte",
            name: .init(de: "Fürther Freiheit & Neue Mitte", en: "Fürther Freiheit & Neue Mitte"),
            subtitle: .init(de: "Einkaufen in Fürths Innenstadt", en: "Shopping in central Fürth"),
            description: .init(de: "Fußgängerzone, Wochenmarkt und Einkaufszentrum liegen rund um die Fürther Freiheit nah beieinander.", en: "The pedestrian zone, weekly market and shopping centre cluster around Fürther Freiheit."),
            latitude: 49.4750, longitude: 10.9891,
            categories: [.shopping, .food],
            travel: [.init(minutes: 18, mode: .car), .init(minutes: 38, mode: .transit)],
            openingHours: .init(de: "Geschäfte meist Montag bis Samstag", en: "Shops generally Monday to Saturday"),
            familyNote: .init(de: "Fürth ist kompakter als Nürnberg und für einen entspannten Einkaufsbummel oft angenehmer.", en: "Fürth is more compact than Nuremberg and often more relaxed for a shopping stroll."),
            website: "https://www.fuerth.de/"
        ),
        .init(
            id: "erfahrungsfeld",
            name: .init(de: "Erfahrungsfeld der Sinne", en: "Field of Experiences for the Senses"),
            subtitle: .init(de: "Mitmachen auf der Wöhrder Wiese", en: "Hands-on discovery at Wöhrder Wiese"),
            description: .init(de: "Saisonales Freigelände mit Stationen zum Experimentieren, Wahrnehmen und gemeinsamen Ausprobieren.", en: "A seasonal outdoor site with stations for experiments, sensory discovery and shared play."),
            latitude: 49.4546, longitude: 11.0962,
            categories: [.withKids, .nature],
            travel: [.init(minutes: 30, mode: .car), .init(minutes: 48, mode: .transit)],
            openingHours: .init(de: "Saisonal, gewöhnlich Frühling bis Herbst", en: "Seasonal, generally spring to autumn"),
            familyNote: .init(de: "Viele Stationen brauchen Zeit und Neugier. Bei gutem Wetter lieber einen längeren Block als einen kurzen Abstecher planen.", en: "Many stations reward time and curiosity. In good weather, plan a longer visit rather than a quick stop."),
            website: "https://www.nuernberg.de/internet/kuf_kultur/erfahrungsfeld.html"
        )
    ]
}
