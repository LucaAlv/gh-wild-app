import Foundation

extension Content {
    enum About {
        static let body = LocalizedText(
            de: """
            Seit 1990 begrüßen wir, drei Generationen der Familie Wild, Gäste in unserem über 300 Jahre alten Fachwerkhaus. Was einst ein traditionsreicher Bauernhof war, haben unsere Seniorchefs Sonja und Lothar Wild mit viel Hingabe zum Gästehaus umgebaut – und diese Tradition der Gastfreundschaft führen wir bis heute fort.

            Jedes unserer Zimmer wurde mit Liebe zum Detail eingerichtet und fügt sich harmonisch in die Geschichte des Hauses ein. Trotz ähnlicher Gestaltung ist jedes Zimmer einzigartig – angepasst an die Gegebenheiten der alten Grundmauern und mit viel persönlichem Charme.

            Am Empfang und beim Frühstücksservice heißen Sie Virginia und Lee Ann Wild herzlich willkommen und stehen Ihnen jederzeit bei Fragen oder Anliegen zur Verfügung.

            Unsere kleine Sydney, die uns oft mit einem fröhlichen „Wuff“ begrüßt, sorgt zusätzlich dafür, dass Sie sich bei uns rundum wohlfühlen. Und auch wenn sie sich gerne versteckt, funktioniert sie als unermüdliche „Klingel“ effektiver als jedes elektronische Gerät!

            Wir freuen uns darauf, Sie in unserem Gästehaus begrüßen zu dürfen.

            Ihre Familie Wild
            """,
            en: """
            Since 1990, three generations of the Wild family have welcomed guests to our half-timbered house, which is more than 300 years old. Once a traditional farmhouse, it was lovingly converted into a guesthouse by our senior hosts Sonja and Lothar Wild. We proudly continue that tradition of hospitality today.

            Every room has been furnished with attention to detail and fits naturally into the story of the house. Although they share a style, each room is unique, shaped by the historic foundations and filled with personal charm.

            Virginia and Lee Ann Wild welcome you at reception and during breakfast and are always happy to help with any questions or requests.

            Our little Sydney often greets us with a cheerful bark and helps everyone feel at home. Even when she prefers to hide, she is a more tireless doorbell than any electronic device!

            We look forward to welcoming you to our guesthouse.

            The Wild family
            """
        )
    }

    enum Services {
        static let body = LocalizedText(
            de: "Wir bieten Ihnen die Möglichkeit, den Leichenschmaus in einem würdevollen und ruhigen Rahmen bei uns auszurichten. Die Mindestanzahl beträgt 15 Personen; unser Gastraum bietet Platz für bis zu 35 Personen und eignet sich ideal für kleine Trauergesellschaften.",
            en: "We offer a dignified and peaceful setting for a funeral reception. The minimum group size is 15; our dining room seats up to 35 people and is particularly suited to smaller gatherings."
        )
        static let options = [
            LocalizedText(de: "Belegte Brote", en: "Open sandwiches"),
            LocalizedText(de: "Kaffee und Kuchen", en: "Coffee and cake"),
            LocalizedText(de: "Ein einheitliches Essen nach Wunsch", en: "A set meal of your choice")
        ]
        static let details = LocalizedText(
            de: "Unsere Räume liegen fußläufig zum Friedhof Unterasbach. Kostenfreie Parkplätze stehen direkt vor der Tür zur Verfügung; die Räume sind barrierefrei zugänglich. Eigene Dekoration ist möglich – auf Wunsch übernehmen wir das auch für Sie.",
            en: "Our rooms are within walking distance of Unterasbach cemetery. Free parking is available outside and the rooms are accessible. You may bring your own decorations, or we can arrange them for you."
        )
    }

    enum Vouchers {
        static let body = LocalizedText(
            de: "Möchten Sie Ihren Liebsten einen Gutschein für eine Übernachtung in unserem Haus schenken? Fragen Sie uns gerne per E-Mail, telefonisch oder bei einem persönlichen Besuch.",
            en: "Would you like to give someone special a voucher for an overnight stay with us? Simply contact us by e-mail, phone or during a visit."
        )
    }
}
