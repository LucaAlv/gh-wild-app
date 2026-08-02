# Inhalte der Gästehaus-Wild-App bearbeiten

Diese App funktioniert offline. Texte und Bilder werden deshalb mit der App ausgeliefert. Änderungen erscheinen erst nach einem neuen App-Build.

## Texte ändern

Alle Inhalte stehen im Ordner `GaestehausWild/Content`.

- `Content.swift`: Startseite, Zimmer, Kontaktdaten und Galerie
- `Content+Stay.swift`: Frühstück, Garten und Aufenthaltsinfos
- `Content+Guide.swift`: digitale Gästemappe A–Z
- `Content+Arrival.swift`: Offline-Spickzettel für Messe, Hauptbahnhof und Flughafen
- `Content+Notifications.swift`: Texte der lokalen Erinnerungen
- `Content+House.swift`: Über uns, sonstige Leistungen und Gutscheine
- `Content+Nearby.swift`: Ausflugsziele
- `Content+Legal.swift`: Impressum, Datenschutz und AGB

Die meisten Texte sehen so aus:

```swift
LocalizedText(
    de: "Deutscher Text",
    en: "English text"
)
```

Nur den Text innerhalb der Anführungszeichen ändern. Bei längeren Texten stehen drei Anführungszeichen (`"""`) am Anfang und Ende. Umlaute können direkt eingegeben werden.

Wichtig: Deutsch ist die Quelle. Nach einer deutschen Änderung immer auch den englischen Text prüfen. Die englischen Texte und insbesondere die Rechtsseiten müssen vor Veröffentlichung von der Familie geprüft werden.

## Kontaktdaten und Preise

Telefon, E-Mail und Adresse stehen oben in `Content.swift`. Zimmerpreise stehen in der Liste `rooms`, der Frühstückspreis in `Content+Stay.swift` als Zahl. Das €-Zeichen wird von der App ergänzt.

Frühstückszeiten stehen ebenfalls in `Content+Stay.swift`:

```swift
static let weekday = BreakfastWindow(startHour: 7, startMinute: 0, endHour: 10, endMinute: 0)
static let sunday = BreakfastWindow(startHour: 8, startMinute: 0, endHour: 10, endMinute: 0)
```

## WLAN-Zugangsdaten

SSID und Passwort stehen in `Content+Stay.swift` unter `Content.WiFi`:

```swift
static let ssid = "Gaestehaus-Wild-Gast"
static let password = "..."
```

Vor Veröffentlichung muss hier das echte **Gastnetz** eingetragen und von der Familie bestätigt werden. Niemals das private Hausnetz verwenden. Das Passwort ist Bestandteil der öffentlich herunterladbaren App. Sonderzeichen wie `;`, `:`, `,`, `\` und `"` dürfen normal eingegeben werden; der QR-Code maskiert sie automatisch.

## Zimmerkarte & App-QR-Codes

Die gedruckte Zimmerkarte sollte als großen, primären QR-Code den App-Store-Link tragen. Dieser Link ist noch ein Platzhalter, bis der endgültige App-Store-Eintrag verfügbar ist. Als kleinerer, sekundärer QR-Code kommt der Direktlink für bereits installierte Apps auf die Karte:

```text
gaestehauswild://gast
```

Der Direktlink öffnet WLAN, Frühstückszeiten und die wichtigsten Hausinfos ohne Eingabe von Reisedaten. Beliebige QR-Codes erzeugt die App technisch über `QRCode.image(from:)`; der WLAN-Code verwendet weiterhin automatisch SSID und Passwort aus `Content+Stay.swift`. Beide gedruckten Codes vor jeder neuen Auflage mit einem echten iPhone testen.

## Gästemappe (A–Z)

Alle Einträge stehen in `Content+Guide.swift` in der Liste `Content.guide`. Für einen neuen Eintrag einen vollständigen `.init(...)`-Block kopieren und eine eindeutige, dauerhaft stabile `id` vergeben. `title` und `answer` müssen immer auf Deutsch und Englisch gepflegt werden. `keywords` enthält Suchbegriffe und Synonyme aus beiden Sprachen, die nicht schon selbstverständlich im Titel oder Antworttext stehen.

Verfügbare Kategorien sind `.emergency`, `.room`, `.house`, `.food`, `.practical` und `.departure`. Mögliche Aktionen sind:

- `.call("tel:...")` – Telefonnummer anrufen
- `.map(query: "...")` – eine Suche in Apple Karten öffnen
- `.link("https://...")` – Website öffnen
- `.page(.breakfast)` – eine Seite innerhalb der App öffnen

Die Notruf-Einträge **112 und 110 dürfen niemals entfernt werden**. Angaben mit dem Kommentar `// FAMILIE BESTÄTIGEN:` sind redaktionelle Platzhalter. Der sichtbare Platzhaltertext muss vor Veröffentlichung durch bestätigte deutsche und englische Angaben ersetzt werden; danach auch den Kommentar entfernen.

## Umgebung & Kategorien

Alle Ausflugsziele stehen in `Content+Nearby.swift`. Einen vorhandenen `.init(...)`-Block kopieren, eine eindeutige `id` vergeben und deutsche sowie englische Texte ausfüllen. Verfügbare Kategorien:

- `.food` – Essen & Trinken
- `.withKids` – Mit Kindern
- `.fair` – Messe & Anreise
- `.rainyDay` – Bei Regen
- `.shopping` – Einkaufen
- `.nature` – Natur & Bewegung

Ein Ziel darf mehrere Kategorien haben. `travel:` enthält die von der Familie geprüften Wegzeiten und Verkehrsmittel. Diese Werte werden offline angezeigt und sollten bei Fahrplanänderungen kontrolliert werden. `latitude` und `longitude` bestimmen Luftlinie, Sortierung, Karte und Karten-Link.

`image:` ist optional. Ohne Bild zeigt die Karte automatisch ein passendes Kategoriesymbol. `openingHours`, `priceHint`, `website` und `phone` dürfen ebenfalls entfallen. `familyNote` sollte bei jedem Ziel gepflegt werden – hier gehört der persönliche Tipp hinein, den allgemeine Karten-Apps nicht kennen.

## Anreise-Spickzettel

Die drei Offline-Routen stehen in `Content+Arrival.swift`. Jeder Eintrag enthält ein Ziel, eine grobe Gesamtdauer, nummerierte Schritte und optional einen Familientipp. Bei VGN-Fahrplanwechseln besonders Linien, Umstiege und Fahrtrichtungen prüfen. Die App berechnet absichtlich keine Online-Route.

## Benachrichtigungstexte

Alle Titel und Texte stehen in `Content+Notifications.swift`. Sie werden beim Aktivieren in der gerade gewählten App-Sprache geplant. Nach einem neuen App-Build werden bereits geplante Erinnerungen beim nächsten Öffnen der App aktualisiert.

In Texten wie `Content.StayCopy.upcoming` steht `{n}` für eine Zahl; beim Frühstück steht `{time}` für die Uhrzeit. Diese Tokens inklusive geschweifter Klammern nicht übersetzen oder entfernen. Singular und Plural sind getrennte Texte, weil Deutsch und Englisch unterschiedlich formuliert werden.

## Datenschutz vor Veröffentlichung

Der aktuell eingebaute Datenschutztext wurde wie vereinbart von der Website übernommen. Er beschreibt Wix, Cookies und Website-Formulare und passt deshalb nicht vollständig zu dieser offline arbeitenden App. In der App wird er gut sichtbar als Platzhalter markiert. Vor einer Veröffentlichung muss der mit der Eigentümerin abgestimmte App-Text eingesetzt werden.

## Galeriefoto austauschen

Die Bilder liegen in `GaestehausWild/Resources/Assets.xcassets`. Jede Mappe `galerie-01.imageset` bis `galerie-25.imageset` enthält ein `image.jpg`.

1. Das neue Foto als JPEG vorbereiten, idealerweise 1600 × 1200 Pixel.
2. Das vorhandene `image.jpg` in der gewünschten `.imageset`-Mappe ersetzen.
3. Dateiname und `Contents.json` nicht ändern.
4. `make build` ausführen und die Galerie kontrollieren.

Weitere Seitenbilder werden genauso ersetzt. Die zugehörigen Mappen heißen
`breakfast.imageset`, `garden.imageset`, `nearby-01.imageset`,
`nearby-02.imageset` und `nearby-03.imageset`. Wappen und Wortmarke liegen in
`wild-wappen.imageset` beziehungsweise `wordmark.imageset`.

## Herkunft der Galerie-Fotos

Stand: 31. Juli 2026. Die Bildrechte wurden laut Eigentümerin mit allen Urhebern geklärt.

| Asset | Wix-Medien-ID |
|---|---|
| galerie-01 | `bd2394_15f42d53fedf48448ef5e9a93a097f18~mv2.jpg` |
| galerie-02 | `bd2394_1c0866858f3b4df9b3d5c75898d8c006~mv2.jpeg` |
| galerie-03 | `bd2394_2048e6e9d7a04099812692676fa00bb4~mv2.jpeg` |
| galerie-04 | `bd2394_207002de5b4b489a923fba12e364acfc~mv2.jpg` |
| galerie-05 | `bd2394_2463d10eb69c47799920194c8a1a60a4~mv2.jpeg` |
| galerie-06 | `bd2394_2664f93c79c54ad4b260daf0773e75a2~mv2.jpg` |
| galerie-07 | `bd2394_28e5e4cbb9e04294871d6a5a266ed5e9~mv2.jpeg` |
| galerie-08 | `bd2394_3032eda2daab4edf87e753191dd17823~mv2.jpg` |
| galerie-09 | `bd2394_5392b5f1e1c049739262f5f7d1a381e2~mv2.jpeg` |
| galerie-10 | `bd2394_56b4dcacaea4441c8e93ee988243dc6c~mv2.jpeg` |
| galerie-11 | `bd2394_5af6883ba24842f5acb353c63c2dc179~mv2.jpeg` |
| galerie-12 | `bd2394_5d1098532af34adebab34705f88f0575~mv2.jpeg` |
| galerie-13 | `bd2394_7474266a1a1d4882851650bc74c23cf1~mv2.jpeg` |
| galerie-14 | `bd2394_7d38c5bd03de4202a25e0eb579ba8ab1~mv2.jpeg` |
| galerie-15 | `bd2394_9990c4bd0ad84a1097d2aba3105565ba~mv2.jpeg` |
| galerie-16 | `bd2394_a07fd53d997b42a2806c9e04533559b2~mv2.jpeg` |
| galerie-17 | `bd2394_a264d0129aff44119fbbf5ff6b9a1f47~mv2.jpeg` |
| galerie-18 | `bd2394_c30fb5e123d24a95a8c4f5b0a2721ffb~mv2.jpeg` |
| galerie-19 | `bd2394_c431ef03855c4f99ab215c05a5ab2b0e~mv2.jpeg` |
| galerie-20 | `bd2394_c475fbf089a14e72a3e9a8fa0150ce80~mv2.jpeg` |
| galerie-21 | `bd2394_c52c7778ca614116809d16db75ccad2d~mv2.jpeg` |
| galerie-22 | `bd2394_cc99b744042b42b8835285c478c32b20~mv2.jpg` |
| galerie-23 | `bd2394_e2ddbaef88e944eb9b11ae21b6552217~mv2.jpeg` |
| galerie-24 | `bd2394_e9a5fe23b9534aa890919fa1052a53c9~mv2.jpeg` |
| galerie-25 | `bd2394_f1d60960a2194592ab7ef6be1a81d451~mv2.jpg` |

Ein Foto erneut laden (Medien-ID einsetzen):

```bash
curl -L "https://static.wixstatic.com/media/ MEDIEN-ID /v1/fill/w_1600,h_1200,al_c,q_80/file.jpg" -o image.jpg
```

Die Leerzeichen um `MEDIEN-ID` im Beispiel entfernen.

## Projekt öffnen

Das Xcode-Projekt wird aus `project.yml` erzeugt und nicht eingecheckt:

```bash
make generate
open GaestehausWild.xcodeproj
```

Für einen vollständigen Simulator-Build:

```bash
make run
```

Die schnellen Logiktests für Aufenthaltsphasen, Sommerzeit, Frühstück, Erinnerungen, Entfernungen und WLAN-QR-Code laufen mit:

```bash
make test
```
