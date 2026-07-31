import Foundation

extension Content {
    static let impressum = LegalDocument(
        title: .init(de: "Impressum", en: "Legal notice"),
        body: .init(
            de: """
            Anschrift & Kontakt

            Gästehaus Wild
            Jahnstraße 77
            90522 Oberasbach
            Deutschland

            Tel.: 0911/996910
            E-Mail: info@gaestehaus-wild.com

            Vertreten durch:
            Lee Ann Wild

            Umsatzsteuer-Identifikationsnummer:
            46 137 918 528

            Verantwortlich für Inhalt:
            Lee Ann Wild
            """,
            en: """
            Address & contact

            Gästehaus Wild
            Jahnstraße 77
            90522 Oberasbach
            Germany

            Phone: +49 911 996910
            E-mail: info@gaestehaus-wild.com

            Represented by:
            Lee Ann Wild

            VAT identification number:
            46 137 918 528

            Responsible for content:
            Lee Ann Wild
            """
        ),
        isPlaceholder: false
    )

    static let privacy = LegalDocument(
        title: .init(de: "Datenschutz", en: "Privacy policy"),
        body: .init(de: privacyGerman, en: "English translation pending family review. The current German website policy follows below.\n\n" + privacyGerman),
        isPlaceholder: true
    )

    static let terms = LegalDocument(
        title: .init(de: "Allgemeine Geschäftsbedingungen", en: "Terms & conditions"),
        body: .init(de: termsGerman, en: "English translation pending family review. The current German terms follow below.\n\n" + termsGerman),
        isPlaceholder: false
    )

    private static let privacyGerman = """
    Datenschutzerklärung
    Stand: Januar 2026

    1. Verantwortlicher
    Gästehaus Wild
    Jahnstraße 77, 90522 Oberasbach
    Telefon: 0911 996910
    E-Mail: info@gaestehaus-wild.com

    2. Zwecke und Rechtsgrundlagen (Art. 6 DSGVO)
    Wir verarbeiten personenbezogene Daten nur, soweit dies erforderlich ist. Rechtsgrundlagen:

    • Art. 6 Abs. 1 lit. b DSGVO (Vertrag/Anfrage): Buchungsbearbeitung, Abschluss und Durchführung des Beherbergungsvertrags, Kommunikation, Zahlungsabwicklung.
    • Art. 6 Abs. 1 lit. c DSGVO (Rechtspflichten): insb. steuer- und handelsrechtliche Pflichten, Meldepflichten für Beherbergungsstätten (vgl. §§ 29, 30 BMG; seit 1.1.2025 entfällt der besondere Meldeschein für deutsche Staatsangehörige, für ausländische Gäste bleibt die Meldepflicht bestehen).
    • Art. 6 Abs. 1 lit. f DSGVO (berechtigtes Interesse): z. B. Geltendmachung/Abwehr von Ansprüchen, IT‑Sicherheit, Hausrecht.
    • Art. 6 Abs. 1 lit. a DSGVO (Einwilligung): nur, wenn wir ausnahmsweise freiwillige Angaben verarbeiten (z. B. besondere Frühstückswünsche).

    3. Kategorien von Daten
    Stammdaten (Name, Anschrift), Kontakt‑ und Kommunikationsdaten (Telefon, E‑Mail), Buchungs‑/Aufenthaltsdaten, Zahlungsdaten, Firmenangaben bei Firmenbuchungen, besondere Wünsche, technisch notwendige Verbindungsdaten bei WLAN‑Nutzung (z. B. IP‑Adresse, Zeitstempel).

    4. Quellen
    Daten erhalten wir in der Regel von Ihnen selbst (Anfrage, Buchung, Check‑in), ggf. von Buchungsportalen (Booking, HRS) und Firmen im Rahmen von Kostenübernahmen.

    5. Empfänger / Auftragsverarbeiter
    • Buchungsportale: Booking.com, HRS (jeweils eigene Verantwortliche; deren Datenschutzhinweise gelten zusätzlich).
    • Website & Hosting (Wix): Wix.com Ltd., 40 Namal Tel Aviv St., Tel Aviv 6350671, Israel – Website-Baukasten, Hosting und ggf. Formulare/Widgets (Auftragsverarbeitung, Art. 28 DSGVO). Wix kann notwendige Cookies setzen und – je nach aktivierten Funktionen/Apps – weitere Dienste laden (z. B. Statistik/Marketing, CDN, Schriftarten).
    • Hotelsoftware: Abacus (Auftragsverarbeitung).
    • E-Mail: Outlook/Microsoft als Mailserveranbieter (Auftragsverarbeitung).
    • Zahlungsdienstleister/Banken, Steuerberatung, Behörden im Rahmen gesetzlicher Pflichten.
    Mit Auftragsverarbeitern bestehen Verträge nach Art. 28 DSGVO (inkl. technischer und organisatorischer Maßnahmen; ggf. Unterauftragsverarbeiter). Bei Wix sind je nach eingesetzten Funktionen Unterauftragsverarbeiter (z. B. CDN/Cloud) möglich.

    6. Drittlandübermittlungen
    Bei Einsatz von Wix und Microsoft (Outlook) kann eine Verarbeitung außerhalb der EU/EWR erfolgen oder ein Zugriff von dort möglich sein. Solche Übermittlungen erfolgen nur unter Beachtung der Art. 44 ff. DSGVO (insb. Standardvertragsklauseln nach Art. 46 DSGVO; ggf. ergänzende Maßnahmen). Sofern der Anbieter über eine Zertifizierung nach dem EU‑US Data Privacy Framework (DPF) verfügt, wird diese ergänzend herangezogen. Details stellen wir auf Anfrage bereit.

    7. Speicherdauer / Löschung
    • Vertrags‑/Abrechnungsunterlagen nach § 257 HGB und § 147 AO bis zu 10 Jahre.
    • Meldescheine nach BMG nach den dortigen Vorgaben.
    • Übrige Daten löschen wir nach Zweckerreichung bzw. gemäß Löschkonzept.

    8. Direktwerbung per Post (postalische Werbung)
    Wir verarbeiten Ihre Postanschrift, um Ihnen bis zu einmal jährlich Informationen zu Angeboten des Gästehaus Wild per Brief zuzusenden. Rechtsgrundlage ist unser berechtigtes Interesse an Direktwerbung (Art. 6 Abs. 1 lit. f DSGVO; Erwägungsgrund 47 DSGVO).
    Widerspruch: Sie können jederzeit ohne Angabe von Gründen der Verarbeitung Ihrer Daten zu Zwecken der Direktwerbung widersprechen; wir verarbeiten Ihre Daten dann nicht mehr zu diesem Zweck (Art. 21 Abs. 2 DSGVO). Senden Sie Ihren Widerspruch z. B. per E-Mail an info@gaestehaus-wild.com oder postalisch an Gästehaus Wild, Jahnstraße 77, 90522 Oberasbach. Wir führen eine Sperrliste (Werbewidersprüche), damit Ihr Widerspruch dauerhaft beachtet wird.
    Dienstleister / Versand: Für Druck, Kuvertierung und Posteinlieferung können wir Auftragsverarbeiter einsetzen. Diese handeln auf vertraglicher Grundlage nach Art. 28 DSGVO und verarbeiten die Daten ausschließlich nach unseren Weisungen.

    9. Buchungen über Portale
    Bei Buchungen über Booking/HRS übermitteln uns die Portale die zur Vertragsdurchführung erforderlichen Daten. Für die eigene Verarbeitung der Portale gelten deren Datenschutzinformationen.

    10. Anfrageformular / E‑Mail
    Daten aus Formularen/E‑Mails nutzen wir ausschließlich zur Bearbeitung Ihrer Anfrage; eine Weitergabe ohne Rechtsgrundlage erfolgt nicht. Bei Formularen über Wix werden die eingegebenen Daten auf den Servern von Wix verarbeitet (siehe Empfänger/Hosting).

    11. WLAN‑Nutzung
    Wir stellen ein passwortgeschütztes Gäste‑WLAN bereit. Für den sicheren Betrieb werden technisch erforderliche Verbindungsdaten (z. B. IP‑Adresse, Zeitpunkte) verarbeitet. Keine Inhaltsprotokollierung.

    12. Website‑Cookies / Endgeräte‑Zugriffe
    Unsere Website wird über Wix betrieben. Wix setzt technisch notwendige Cookies (z. B. zur sicheren Bereitstellung/Lastverteilung). Je nach aktivierten Funktionen/Apps (z. B. Statistik, Marketing, Social‑Media‑Plugins, eingebettete Inhalte) können weitere, einwilligungspflichtige Cookies/Techniken eingesetzt werden.
    Einwilligung: Soweit solche optionalen Tools eingesetzt werden, holen wir vorab Ihre Einwilligung nach § 25 Abs. 1 TDDDG und Art. 6 Abs. 1 lit. a DSGVO über einen Consent‑Banner ein; die Einwilligung ist jederzeit widerrufbar.
    Hinweis: Verwenden wir ausschließlich notwendige Funktionen, ist keine Einwilligung erforderlich.

    13. Social Media (Instagram)
    Unser offizielles Profil lautet @gaestehaus.wild. Beim Aufruf unseres Instagram-Profils gelten die Datenschutzbestimmungen des Anbieters (Meta/Instagram). Wir verarbeiten Profil-/Kommunikationsdaten, wenn Sie mit uns interagieren (Art. 6 Abs. 1 lit. b/f DSGVO).

    14. Rechte der betroffenen Personen
    Sie haben Rechte auf Auskunft, Berichtigung, Löschung, Einschränkung, Datenübertragbarkeit sowie Widerspruch gegen Verarbeitungen nach Art. 6 Abs. 1 lit. e/f DSGVO. Zudem haben Sie ein Beschwerderecht bei der zuständigen Aufsichtsbehörde.
    Zuständige Aufsichtsbehörde (Bayern, nicht‑öffentliche Stellen):
    Bayerisches Landesamt für Datenschutzaufsicht (BayLDA)
    Promenade 18, 91522 Ansbach, Deutschland
    Online‑Beschwerde: siehe Website des BayLDA.

    15. Datensicherheit
    Wir treffen technische und organisatorische Maßnahmen zur Sicherheit Ihrer Daten (z. B. Zugriffsbeschränkungen, Verschlüsselung, Backups) und entwickeln diese fortlaufend weiter. Bei E-Mail-Diensten (Outlook/Microsoft) werden Transportverschlüsselung und rollenbasierte Zugriffe eingesetzt; administrativer Zugriff erfolgt nur durch befugte Personen.

    15a. Auftragsverarbeitungsverträge (Transparenzhinweis)
    Wir halten mit unseren Auftragsverarbeitern (u. a. Wix – Website/Hosting; Abacus – Hotelsoftware; Outlook/Microsoft– E‑Mail) Verträge nach Art. 28 DSGVO vor. Diese regeln u. a. Zweck, Dauer, Art der Daten, TOMs, Unterauftragsverhältnisse, Unterstützung bei Betroffenenrechten, Meldepflichten und Löschung/Rückgabe der Daten nach Vertragsende.

    16. Pflicht zur Bereitstellung / Folgen der Nichtbereitstellung
    Für Buchung/Beherbergung sind bestimmte Angaben obligatorisch (z. B. Kontaktdaten, An‑/Abreisedaten; ggf. Meldedaten nach BMG). Ohne diese Angaben ist eine Beherbergung ggf. nicht möglich.

    17. Automatisierte Entscheidungen / Profiling
    Finden nicht statt.

    18. Aktualität dieser Erklärung
    Wir passen die Datenschutzerklärung bei Bedarf an (z. B. bei Gesetzes‑/Dienstleister‑Änderungen). Die jeweils aktuelle Fassung ist vor Ort und online verfügbar.
    """

    private static let termsGerman = """
    Gästehaus Wild
    Jahnstraße 77, 90522 Oberasbach
    Einzelunternehmen; nachfolgend: Gästehaus

    1. Geltungsbereich
    Diese AGBs gelten für alle Verträge zwischen dem Gästehaus Wild, Jahnstraße 77, 90522 Oberasbach und Gästen bzw. Bestellern über Unterkunft, Buchung und Aufenthalt sowie hiermit zusammenhängende Leistungen (z. B. Frühstück, WLAN, Parkplatz). Abweichende Bedingungen des Gastes gelten nur, wenn das Gästehaus ihnen ausdrücklich zugestimmt hat.

    2. Vertragsschluss
    1. Ein Beherbergungsvertrag kommt zustande, sobald das Gästehaus eine Buchung annimmt. Die Annahme erfolgt durch (i) Bestätigung per E‑Mail, (ii) Bestätigung über ein Buchungsportal (z. B. Booking, HRS), (iii) schriftliche Bestätigung oder (iv) mündliche Bestätigung im Rahmen einer telefonischen Buchung.
    2. Telefonische Buchungen sind verbindlich. Auf Wunsch erhält der Gast eine schriftliche Buchungsbestätigung.
    3. Buchungen können durch Verbraucher und Unternehmer erfolgen. Firmenbuchungen gelten als verbindlich, wenn das Unternehmen im eigenen Namen bucht oder eine ausdrückliche Kostenübernahme Erklärung abgibt.
    4. Nimmt ein Dritter die Buchung für den Gast vor, haftet er dem Gästehaus gegenüber als Besteller zusammen mit dem Gast als Gesamtschuldner für die vertraglichen Entgeltansprüche, sofern eine entsprechende Erklärung des Bestellers vorliegt.
    5. Kostenübernahmen durch Firmen oder andere Dritte müssen dem Gästehaus vor Anreise schriftlich (E‑Mail ausreichend) vorliegen. Liegt beim Check‑in keine wirksame Kostenübernahme vor, haftet der anreisende Gast für sämtliche Kosten.
    6. Bei Buchungen über Portale (z. B. Booking, HRS) gelten ergänzend die dort vor Vertragsschluss einsehbaren Buchungs‑ und Zahlungsbedingungen.
    7. Ein Anspruch auf die Bereitstellung bestimmter Zimmer besteht nicht, soweit dies nicht ausdrücklich vereinbart wurde.

    3. Preise, Abgaben und Zahlung
    1. Alle Preise verstehen sich einschließlich der gesetzlichen Umsatzsteuer und etwaiger gesetzlicher Abgaben (soweit anwendbar). Kurtaxen/kommunale Abgaben sind – falls einschlägig – gesondert zu entrichten.
    2. Die Zahlung erfolgt wie vereinbart: bei Anreise, bei Abreise, per Vorkasse /Überweisung oder auf Grundlage einer anerkannten Kostenübernahme.
    3. Gerät der Rechnungsempfänger in Zahlungsverzug, ist das Gästehaus berechtigt, gesetzliche Verzugszinsen sowie einen pauschalierten Verzugsschaden (Mahnpauschale) je weiterer Mahnung bis zu 5,00 € zu verlangen; dem Kunden bleibt der Nachweis eines geringeren oder fehlenden Schadens vorbehalten.
    4. Bei ausstehender Zahlung kann das Gästehaus weitere Leistungen zurückhalten oder künftige Leistungen einstellen.

    4. Stornierung, Umbuchung und Nichtanreise (No‑Show)
    Grundsatz: Der Gast kann jederzeit vor Anreise vom Vertrag zurücktreten. In diesem Fall kann das Gästehaus eine angemessene Entschädigung verlangen. Diese wird nachfolgend pauschaliert festgelegt. Dem Gast bleibt stets der Nachweis eines geringeren Schadens vorbehalten. Eine Weitervermietung wird vom Gästehaus – zumutbare Bemühungen vorausgesetzt – angestrebt; eine erzielte Weitervermietung reduziert die Entschädigung anteilig.

    4.1 Einzel‑ und Kleinbuchungen (bis einschließlich 7 Zimmer)
    • Stornierung bis 30 Tage vor Anreise: kostenfrei.
    • Stornierung 30 bis 1 Tag vor Anreise: 80 % des vereinbarten Gesamtpreises (Logis inkl. gebuchter Zusatzleistungen, abzüglich ersparter Aufwendungen).
    • Spätere Stornierung/No‑Show: 100 % des vereinbarten Gesamtpreises (Logis inkl. gebuchter Zusatzleistungen, abzüglich ersparter Aufwendungen).

    4.2 Gruppenbuchungen (mehr als 7 Zimmer)
    • Stornierung bis 8 Wochen (56 Tage) vor Anreise: kostenfrei.
    • danach: 80 % des vereinbarten Gesamtpreises (abzüglich ersparter Aufwendungen); eine teilweise Weitervermietung reduziert die Pauschale entsprechend.
    • No‑Show: 100 % des vereinbarten Gesamtpreises (Logis inkl. gebuchter Zusatzleistungen, abzüglich ersparter Aufwendungen).

    4.3 Messe‑ und Sonderzeiträume (Standort Nürnberg Messe)
    • Innerhalb von Messe‑/Sonderzeiträumen (gemäß jeweils veröffentlichter Terminübersicht der NürnbergMesse) ist eine Stornierung jederzeit mit 80 % des vereinbarten Gesamtpreises kostenpflichtig (abzüglich ersparter Aufwendungen).
    • Abweichende, portal- oder angebotsbezogene Bedingungen bleiben unberührt, wenn sie vor Vertragsschluss bekanntgegeben sind.
    Hinweis: Die Pauschalen berücksichtigen regelmäßig ersparte Aufwendungen. Das Gästehaus bleibt berechtigt, eine höhere, konkret berechnete Entschädigung zu verlangen, wenn ihm ein höherer Schaden entstanden ist; in diesem Fall ist der Schaden konkret zu beziffern und nachzuweisen.

    5. An‑ und Abreise
    • Check‑in: ab 15:00 Uhr (frühere Anreise grundsätzlich nicht möglich; Gepäckablage oder früher Check‑in nach Absprache).
    • Check‑out: bis 11:00 Uhr (spätere Abreise nur nach vorheriger Absprache; ggf. Aufpreis).

    6. Frühstück
    1. Das Gästehaus bietet auf Wunsch Frühstück aus eigener Küche an; Verfügbarkeit und Zeiten werden bei Buchung oder vor Ort mitgeteilt.
    2. Ist das Frühstück nicht im Zimmerpreis enthalten, gilt die jeweils ausgewiesene Preisliste bzw. die Buchungsbestätigung.
    3. Besondere Ernährungswünsche/Unverträglichkeiten werden – nach Verfügbarkeit – berücksichtigt, ohne Rechtsanspruch.

    7. Nutzung der Zimmer / Hausordnung
    1. Die Zimmer dürfen ausschließlich von den angemeldeten Personen genutzt werden; Besuche sind nur nach vorheriger Absprache gestattet.
    2. Die Hausordnung (Aushang) ist Bestandteil des Vertrages und zu beachten.

    8. Ruhezeiten
    • Von 22:00 Uhr bis 06:00 Uhr gelten Hausruhezeiten; auf andere Gäste ist Rücksicht zu nehmen.

    9. Haftung
    1. Gastwirt‑Haftung für eingebrachte Sachen (§§ 701 ff. BGB): Das Gästehaus haftet nach den gesetzlichen Bestimmungen für Schäden an eingebrachten Sachen des Gastes. Die Haftung ist gesetzlich der Höhe nach begrenzt (§ 702 BGB). Ausschluss‑ und Begrenzungsgründe nach Gesetz bleiben unberührt.
    2. Allgemeine Haftung des Gästehauses: Bei Vorsatz und grober Fahrlässigkeit haftet das Gästehaus unbeschränkt. Bei einfacher Fahrlässigkeit haftet das Gästehaus nur bei Verletzung wesentlicher Vertragspflichten (Kardinalpflichten) und beschränkt auf den vertragstypischen, vorhersehbaren Schaden. Die Haftung für Schäden aus der Verletzung des Lebens, des Körpers oder der Gesundheit bleibt unberührt. Dies gilt ebenso für gesetzliche Ansprüche aus Produkthaftung.
    3. Haftung der Gäste: Gäste haften für Schäden, die sie selbst, Mitreisende oder deren Besucher schuldhaft verursachen; dies gilt auch für übermäßige Verschmutzung und Schlüsselverlust (Ziff. 11, 12).

    10. Haustiere
    1. Das Mitbringen von Haustieren ist grundsätzlich gestattet und spätestens vor Anreise anzumelden. Bestimmte Tierarten/-größen kann das Gästehaus ablehnen.
    2. Für Haustiere kann eine zusätzliche Reinigungs‑ oder Übernachtungspauschale anfallen. Tiere dürfen nicht unbeaufsichtigt im Zimmer verbleiben. In bestimmten Bereichen (z. B. Frühstücksraum) sind Tiere nicht gestattet.
    3. Der Gast haftet für alle durch das Tier verursachten Schäden und Verunreinigungen.

    11. Schlüssel / Schlüsselverlust
    1. Der Gast erhält bei Anreise die erforderlichen Schlüssel/Transponder.
    2. Bei Verlust haftet der Gast für die notwendigen Ersatzkosten (inkl. Schließanlagentausch, sofern aus Sicherheitsgründen erforderlich).

    12. Reinigung / außergewöhnliche Verschmutzung
    1. Die Zimmer werden in ordnungsgemäß gereinigtem Zustand übergeben und sind entsprechend zu hinterlassen.
    2. Eine tägliche Zimmerreinigung erfolgt grundsätzlich nicht; auf Wunsch kann bei Anreise eine tägliche Reinigung vereinbart werden.
    3. Bei Aufenthalten von mehr als einer Woche behält sich das Gästehaus Zwischenreinigungen vor.
    4. Hygieneartikel/Handtücher sind auf Anfrage jederzeit erhältlich.
    5. Bei außergewöhnlicher Verschmutzung oder vertragswidrigem Gebrauch kann das Gästehaus eine angemessene zusätzliche Reinigungsgebühr verlangen; dem Gast bleibt der Nachweis eines geringeren Schadens vorbehalten.

    13. Haftung für persönliche Gegenstände
    Soweit keine gesetzliche Gastwirt‑Haftung greift (Ziff. 9 Abs. 1), bewahrt der Gast seine persönlichen Gegenstände, Bargeld, Wertsachen und technischen Geräte auf eigenes Risiko auf. Für Gegenstände in Gemeinschaftsbereichen, Fahrzeuge oder Außenanlagen besteht – vorbehaltlich der gesetzlichen Haftung – keine Einstandspflicht des Gästehauses.

    14. Parkplatz
    1. Die Nutzung der Parkplätze (soweit verfügbar; kein Anspruch) erfolgt auf eigene Gefahr.
    2. Das Gästehaus haftet für Parkplatzschäden nur nach Maßgabe von Ziff. 9; eine Obhutspflicht wird nicht übernommen.

    15. Rauchen
    1. Rauchen (einschließlich E‑Zigaretten) ist in sämtlichen Innenräumen untersagt.
    2. Rauchen ist ausschließlich im Außenbereich gestattet.
    3. Bei Verstoß wird eine pauschale Reinigungs‑ und Nutzungsausfallgebühr von 200,00 € erhoben. Dem Gast bleibt der Nachweis vorbehalten, dass kein oder ein geringerer Schaden entstanden ist; dem Gästehaus bleibt der Nachweis eines höheren Schadens vorbehalten.

    16. WLAN‑Nutzung
    1. Das Gästehaus stellt ein passwortgeschütztes Gäste‑WLAN ohne Gewähr für bestimmte Geschwindigkeit oder Verfügbarkeit bereit (unentgeltlicher Zugangsdienst).
    2. Der Zugang darf ausschließlich gesetzeskonform genutzt werden; insbesondere sind Urheberrechtsverletzungen (z. B. Filesharing) und rechtswidrige Inhalte untersagt.
    3. Zugangsdaten sind vertraulich zu behandeln und nicht an Dritte weiterzugeben.
    4. Im Falle behördlicher oder gerichtlicher Anfragen wird der Gast – im Rahmen des Zumutbaren – bei der Aufklärung mitwirken.
    5. Das Gästehaus haftet für fremde Rechtsverletzungen über den Internetzugang nur nach den gesetzlichen Bestimmungen für Zugangsanbieter; weitergehende Pflichten bestehen nicht.

    17. Hausrecht / Vertragsbeendigung
    Bei groben Verstößen gegen diese AGB oder die Hausordnung (insb. erhebliche Ruhestörung, Trunkenheit, Rauchverbot, Sachbeschädigung oder rechtswidriges Verhalten) kann das Gästehaus den Beherbergungsvertrag fristlos kündigen und den Gast des Hauses verweisen. Ein Anspruch auf Rückerstattung bereits gezahlter Entgelte besteht in diesem Fall nicht, soweit dem Gästehaus ein Anspruch auf Vergütung oder Schadensersatz verbleibt.

    18. Höhere Gewalt
    Kann der Aufenthalt aufgrund höherer Gewalt (z. B. Naturereignisse, behördliche Anordnungen, Strom‑/Heizungsausfall, Pandemien) nicht oder nur teilweise erbracht werden, haftet das Gästehaus nicht; bereits erbrachte Leistungen bleiben unberührt. Gesetzliche Rechte (z. B. Unmöglichkeit) bleiben vorbehalten.

    19. Minderjährige Gäste
    Minderjährige dürfen sich nur in Begleitung oder unter Aufsicht eines Erziehungsberechtigten im Gästehaus aufhalten. Die Aufsichtspflicht liegt ausschließlich bei den Begleitpersonen.

    20. Nutzung von Gemeinschaftsflächen
    Gemeinschaftsflächen sind pfleglich zu behandeln und nach Gebrauch in ordentlichem Zustand zu hinterlassen. Für Schäden haftet der verursachende Gast.

    21. Rechnungsstellung / Mängelanzeige
    1. Rechnungen sind – sofern nicht anders vereinbart – sofort nach Rechnungserhalt ohne Abzug fällig.
    2. Bei Zahlungsverzug können gesetzliche Verzugszinsen und angemessene Mahnkosten verlangt werden (vgl. Ziff. 3 Abs. 3).
    3. Mängel sind unverzüglich anzuzeigen, damit Abhilfe geschaffen werden kann.

    22. Datenschutz
    Personenbezogene Daten werden nach Maßgabe der Datenschutzhinweise des Gästehauses verarbeitet (abrufbar über Aushang/Website). Rechtsgrundlagen sind insbesondere Art. 6 Abs. 1 DSGVO. Eine Weitergabe an Dritte erfolgt nur im gesetzlich zulässigen Rahmen.

    23. Widerrufshinweis (Fernabsatz)
    Bei Beherbergungsverträgen besteht kein Widerrufsrecht für Verbraucher bei Fernabsatzverträgen (§ 312g Abs. 2 Nr. 9 BGB). Dieses gesetzliche Nichtbestehen wird hiermit vor Vertragsschluss klarstellend mitgeteilt.

    24. Verjährung
    Gesetzliche Verjährungsfristen gelten. Eine generelle Verkürzung gegenüber Verbrauchern findet nicht statt. Gegenüber Unternehmern bleiben zwingende gesetzliche Vorschriften unberührt; etwaige vertragliche Verjährungsregelungen bedürfen ausdrücklicher Einzelvereinbarung.

    25. Schlussbestimmungen / Gerichtsstand / Salvatorische Klausel
    1. Es gilt deutsches Recht.
    2. Ist der Gast Kaufmann, eine juristische Person des öffentlichen Rechts oder hat er keinen allgemeinen Gerichtsstand in Deutschland, ist Gerichtsstand der Sitz des Gästehauses. Für Verbraucher gelten die gesetzlichen Gerichtsstände.
    3. Sollten einzelne Bestimmungen dieser AGB unwirksam sein oder werden, bleibt die Wirksamkeit der übrigen Regelungen unberührt; an die Stelle der unwirksamen Bestimmung tritt die gesetzliche Regelung.
    """
}
