import Foundation

extension Content {
    enum Breakfast {
        static let weekday = BreakfastWindow(startHour: 7, startMinute: 0, endHour: 10, endMinute: 0)
        static let sunday = BreakfastWindow(startHour: 8, startMinute: 0, endHour: 10, endMinute: 0)
        static let price = 14

        static let intro = LocalizedText(
            de: "Beginnen Sie den Tag ganz entspannt: Montag bis Samstag von 7:00 bis 10:00 Uhr, sonntags von 8:00 bis 10:00 Uhr. Freuen Sie sich auf frische Brötchen, warme und kalte Getränke und kleine Leckereien.",
            en: "Start your day at ease: Monday to Saturday from 7:00 to 10:00 am, Sundays from 8:00 to 10:00 am. Fresh rolls, hot and cold drinks and little treats await you."
        )
        static let allergy = LocalizedText(
            de: "Bitte informieren Sie uns über Unverträglichkeiten wie Laktose, Gluten oder andere Allergien – wir kümmern uns gerne darum.",
            en: "Please tell us about lactose or gluten intolerance and any other allergies – we will be happy to accommodate you."
        )
    }

    enum WiFi {
        static let ssid = "Gaestehaus-Wild-Gast"
        // Release blocker: replace only after the family confirms the guest-network password.
        static let password = "BITTE-GAST-WLAN-PASSWORT-EINTRAGEN"
    }

    enum StayCopy {
        static let upcoming = LocalizedText(
            de: "Noch {n} Tage bis zu Ihrem Aufenthalt",
            en: "{n} days until your stay"
        )
        static let upcomingSingular = LocalizedText(
            de: "Noch ein Tag bis zu Ihrem Aufenthalt",
            en: "One day until your stay"
        )
        static let nightsRemaining = LocalizedText(
            de: "Noch {n} Nächte bei uns",
            en: "{n} nights remaining"
        )
        static let nightRemainingSingular = LocalizedText(
            de: "Noch eine Nacht bei uns",
            en: "One night remaining"
        )
        static let parking = LocalizedText(
            de: "Kostenfreie Parkplätze finden Sie direkt vor dem Haus.",
            en: "Free parking is available directly outside the guesthouse."
        )
        static let lateArrival = LocalizedText(
            de: "Sie kommen später? Rufen Sie uns kurz an – wir vereinbaren eine flexible Schlüsselübergabe.",
            en: "Arriving later? Give us a quick call and we will arrange a flexible key handover."
        )
        static let keyHandover = LocalizedText(
            de: "Ihre Schlüsselübergabe stimmen wir persönlich mit Ihnen ab.",
            en: "We arrange your key handover with you personally."
        )
        static let departure = LocalizedText(
            de: "Bitte geben Sie Ihr Zimmer bis 11:00 Uhr frei. Gepäck oder eine spätere Abreise? Sprechen Sie uns gerne an.",
            en: "Please vacate your room by 11:00 am. Ask us if you need help with luggage or a later departure."
        )
    }

    enum Arrival {
        static let intro = LocalizedText(
            de: "Die wichtigsten Wege ab dem Gästehaus – kurz, offline verfügbar und ohne Suche unterwegs.",
            en: "The most useful routes from the guesthouse—concise, available offline and ready without searching."
        )
    }

    enum Garden {
        static let body = LocalizedText(
            de: "In den Sommermonaten steht Ihnen unsere Terrasse hinter dem Haus zur Verfügung. Gerne servieren wir Ihnen je nach Verfügbarkeit ein kühles Getränk. Mitgebrachte Speisen und Getränke dürfen verzehrt werden. Wenn Sie mit dem Fahrrad anreisen, können Sie Ihr Rad hier sicher und unzugänglich abstellen.",
            en: "During the summer months, our terrace behind the house is open to you. Subject to availability, we will be happy to serve you a cool drink, and you may enjoy food and drinks you have brought along. Guests arriving by bicycle can store their bikes securely here."
        )
    }

}
