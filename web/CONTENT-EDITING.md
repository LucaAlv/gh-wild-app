# Inhalte der Website bearbeiten

Die Website wird unter `/admin` mit Sveltia CMS gepflegt. Nach der Anmeldung mit dem dafür eingerichteten GitHub-Konto erscheinen Seiten, Zimmer, Gästemappe, Ausflugsziele und Einstellungen als Formulare.

## Ablauf

1. `/admin` öffnen und mit GitHub anmelden.
2. Links den gewünschten Bereich wählen.
3. Deutsch und Englisch gemeinsam aktualisieren. Deutsch ist die redaktionelle Quelle; nach jeder Änderung die englische Fassung prüfen.
4. Speichern. Sveltia legt die Änderung als Git-Commit ab; Vercel baut danach automatisch eine neue Vorschau.
5. Erst veröffentlichen, wenn die Vorschau in beiden Sprachen geprüft wurde.

## Schutzregeln

- Die Einträge **Notruf 112** und **Polizei 110** nie löschen.
- Keine internen Texte mit `BITTE BESTÄTIGEN` speichern. Die Inhaltsprüfung stoppt sonst den Build.
- WLAN-Daten dürfen nur zum isolierten Gastnetz gehören, niemals zum privaten Hausnetz.
- Bilder möglichst als JPEG oder WebP mit mindestens 1600 × 1200 Pixeln hochladen.
- Änderungen an Impressum, Datenschutz oder AGB immer fachlich prüfen lassen.

## Offene Einträge

Zehn Einträge der Gästemappe tragen intern `needsOwnerReview: true`. Sie zeigen Gästen bis zur Klärung nur den ehrlichen Hinweis, direkt nachzufragen. Nach einer bestätigten Antwort beide Sprachen eintragen und den Schalter deaktivieren.
