import Foundation

extension Content {
    enum Notifications {
        static let welcomeTitle = LocalizedText(de: "Willkommen im Gästehaus Wild", en: "Welcome to Gästehaus Wild")
        static let welcomeBody = LocalizedText(de: "Check-in ist ab 15:00 Uhr. Parkplätze finden Sie vor dem Haus; Ihren WLAN-Zugang zeigt die App.", en: "Check-in starts at 3:00 pm. Parking is outside and your Wi-Fi details are in the app.")
        static let breakfastTitle = LocalizedText(de: "Guten Morgen", en: "Good morning")
        static let breakfastBody = LocalizedText(de: "Frühstück ist heute ab {time} Uhr für Sie bereit.", en: "Breakfast is ready for you from {time} today.")
        static let checkoutTitle = LocalizedText(de: "Morgen ist Abreise", en: "Check-out is tomorrow")
        static let checkoutBody = LocalizedText(de: "Check-out ist morgen bis 11:00 Uhr. Sprechen Sie uns bei Fragen gerne an.", en: "Check-out is by 11:00 am tomorrow. Please ask if you need anything.")
        static let thanksTitle = LocalizedText(de: "Danke für Ihren Besuch", en: "Thank you for staying")
        static let thanksBody = LocalizedText(de: "Wir hoffen, Sie hatten eine gute Zeit. Verschenken Sie Vorfreude mit einem Gutschein vom Gästehaus Wild.", en: "We hope you enjoyed your stay. Share something to look forward to with a Gästehaus Wild gift voucher.")
    }
}
