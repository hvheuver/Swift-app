# Willem Tell iOS app
## Student
Hendrik Van Heuverswyn
3TIN - 3C

Willem Tell is een boogschuttersclub. Ik heb de inspiratie daar gehaald. Een schutter kan inloggen, zijn persoonlijke statistieken bekijken, zichzelf vergelijken met anderen en de agenda raadplegen.

Er is ook nog een optie om de uitrusting te bekijken. De intentie was om hier een "stockbeheer" te implementeren voor de schutter. (Hoeveel volledige pijlen, veren, pijlpunten ...)
Helaas werd deze optie niet verder uitgewerkt.
## Gebruik repository
Code (inclusief pods) werden opgenomen in de repository. Het volstaat om de repository te clonen.

Na het clonen gebruikt u het `swift-app.xcworkspace` bestand om het project te openen. Vervolgens kan u het project builden en runnen.

## Functionaliteit
### Login
- Gebruikt Firebase Databank en authenticatie
- Validatie
- Geen manier om zelf een account te maken, gesloten applicatie.
Testgebruikers hebben allemaal het wachtwoord `testerino` voor de eenvoud.
Er zijn in totaal 4 gebruikers, waarvan 1 gebruiker zonder data:
- aaron@wt.be
- berry@wt.be
- hendrik@wt.be
- empty@wt.be

### Home - Opties   
- `UICollectionView` met verschillende opties
- Afbeeldingen volgens de @1x, @2x, @3x standaard

### Statistieken
- `UIView` met de `Charts` pod
- Geprobeerd om een zo mooi mogelijke grafiek te bekomen
- Mogelijkheid tot toevoegen van data aan de grafiek

### Add Data
- `UITableView` met statische rijen
- Input met validatie
- Firebase databank

### Klassement
- `UITableView` dat statistieken ophaalt van elke gebruiker van de club
- Berekening van score en sortering op score
- Header

### Schietingen
- `UITableView` met data van schietingen
- Conversie van datum, gebruik maken van de `Dateformatter` voor localisatie
- Sortering op datum

### Uitrusting
- `UITableView`
TODO
