# Clusterplan — zenuwstelsel.com

**Opgesteld:** 7 september 2026 (run 01)
**Status:** *herzien op 2026-09-07 na de eerste GSC-meting en Jaaps keuze voor
optie A (splitsen).*

Dit plan is nu gebaseerd op echte GSC-data, niet meer op vermoedens. Zie
`docs/reports/2026-09-07-gsc-eerste-meting.md` voor de meting.

---

## De vorm: hub en spokes

**De test is de hub.** Alles verwijst ernaar; de test verwijst door naar de
spoke die bij de uitslag past. Dat is niet alleen SEO-structuur — het is de
trechter. Iemand die net "je zenuwstelsel staat vooral aan" heeft gelezen is
op dat moment het meest ontvankelijk voor precies één vervolgpagina.

Concreet, per uitslag:

| Uitslag | Logische vervolgpagina |
|---|---|
| activatie | de 4-6 ademhaling (spoke 5) |
| uitschakeling | de drie standen (spoke 3) |
| wisselend | wanneer zelfregulatie niet meer lukt (spoke 8) |
| gereguleerd | wat werkt en wat is hype (spoke 1) |

Die interne links bestaan nu nog niet. Ze komen erbij zodra de spokes er zijn.

---

## Prioritering

Gewogen op de primaire KPI (intakes), niet op verkeer. Een pagina die veel
bezoekers trekt maar niemand naar een intake beweegt, staat laag.

### De tweede grens: psychosomatischefysio.nl

De brief kent één harde grens, die met burnout-help.nl. Uit de GSC-meting van
7 september blijkt dat er een **tweede** grens nodig is, en die was niemand
opgevallen: psychosomatischefysio.nl heeft al een zenuwstelsel-cluster dat
rankt.

| Bestaande pagina | Klikken (3 mnd) | Positie |
|---|---|---|
| `/een-ontregeld-zenuwstelsel` | 169 | 4,6 op de head-term |
| `/sympatisch-en-parasympatisch-zenuwstelsel` | 13 | 18,3 |
| `/hoe-het-parasympathisch-zenuwstelsel-werkt` | 10 | 14,3 |
| `/de-nervus-vagus-uitgelegd` | 0 | 67,6 |
| `/window-of-tolerance-nederlands` | — | 3,0 |

**Jaap koos optie A: splitsen.** zenuwstelsel.com schrijft niet wat daar al
staat en rankt. De regel is dezelfde als bij burnout-help.nl, maar dan om een
andere reden — daar is het positionering, hier is het kannibalisatie van de
eigen controlegroep.

**Regel:** dekt psychosomatischefysio.nl een onderwerp al met een rankende
pagina, dan schrijf je die pagina hier niet. Je linkt ernaar. Controleer dat
per onderwerp in GSC vóór je begint, niet achteraf.

### Voorstel voor run 2 en verder

| # | Pagina | Prioriteit | Overlap? | Waarom |
|---|---|---|---|---|
| 1 | **Werkt een ijsbad voor je nervus vagus?** | **hoog** | geen | het gat in de markt, zie hieronder |
| 2 | **Wat werkt echt en wat is hype** (evidence-hub) | **hoog** | geen | het citeerbare bezit |
| 3 | Polyvagaal-theorie: wat klopt, wat is populair-wetenschappelijk | midden | geen | kritische stem die nergens bestaat |
| 4 | Wanneer lukt zelfregulatie niet meer | midden | geen | de brug naar behandeling — hoogste intake-intentie |
| 5 | De 4-6 ademhaling | laag-midden | **controleren** | staat al deels op de homepage; check GSC vóór schrijven |
| 6 | Psychosomatische fysiotherapie Den Bosch (lokaal) | **apart spoor** | geen | zie hieronder |

### Vervallen onder optie A — linken in plaats van schrijven

| Onderwerp | Verwijst naar |
|---|---|
| Wat is een ontregeld zenuwstelsel? | `/een-ontregeld-zenuwstelsel` |
| De drie standen van je zenuwstelsel | `/sympatisch-en-parasympatisch-zenuwstelsel` |
| Window of tolerance | `/window-of-tolerance-nederlands` |
| Nervus vagus, anatomie en functie | `/de-nervus-vagus-uitgelegd` |

Dit kost wat: de test-uitslagen verwijzen straks voor twee van de vier standen
naar een andere site. Dat is de prijs van een schone meting, en het is
omkeerbaar als Jaap later alsnog voor optie B (verhuizen met 301's) kiest.

**Let op bij het leggen van die links:** contentlinks naar
psychosomatischefysio.nl vuren `zs_uitgaande_link`, geen `zs_cta_klik`. Dat
onderscheid zit sinds 7 september in de instrumentatie en hangt aan de
knopklassen (`btn-primary` / `btn-inline`). Geef een contentlink dus **nooit**
zo'n klasse, anders telt elke verwijzing in de lopende tekst mee als
intake-intentie en zijn de trechtercijfers waardeloos.

### Waarom 1 en 2 bovenaan staan

Op 2026-09-07 is de Nederlandse SERP voor "werkt een ijsbad voor je nervus
vagus" gecontroleerd. Van de zes best vindbare bronnen:

- **twee verkopen ijsbaden** (ijsbad-kopen.nl, cryotubs.com)
- één is een LinkedIn-post
- één is een contentsite, één een Belgische coachingpraktijk
- **één is een echte medische stem** (jessicagal.nl, sportartsen)

Er is dus geen enkele Nederlandse BIG-geregistreerde behandelaar die deze vraag
eerlijk beantwoordt. Dat is precies wat brief §8 "het grootste bezit" noemt,
en het is nu geverifieerd in plaats van vermoed.

Hetzelfde geldt breder: op "ontregeld zenuwstelsel herstellen" bestaat het veld
uit coachingpraktijken, een chiropractor, een supplementenverkoper en een
alternatief-medisch magazine. Geen richtlijn, geen academische bron, geen
BIG-registratie.

De onderscheidende factor is dus niet betere SEO. Het is **de enige zijn met
een BIG-nummer die eerlijk is over wat niet werkt.** Dat is een positie die
concurrenten niet kunnen kopiëren, en het is precies wat AI-systemen citeren:
een bron die een claim durft af te zwakken.

**Kanttekening:** de gebruikte zoekmachine is US-gelokaliseerd. De echte
Nederlandse SERP kan afwijken. Dit is richting, geen bewijs.

**Wat GSC hieraan toevoegt (7 september):** `nervus vagus`-queries leveren op
psychosomatischefysio.nl 10 klikken en 652 impressies per maand op —
zes keer minder dan de zenuwstelsel-queries (64 klikken, 3.378 impressies).
Het ijsbad-onderwerp is dus **geen volumespel**. Het staat bovenaan omdat het
het enige onderwerp is waar een BIG-geregistreerde stem ontbreekt én waar
psychosomatischefysio.nl niets heeft — niet omdat er veel verkeer op zit.

Voor de T+9-drempel van 1.500 organische bezoekers per maand zal het volume
elders vandaan moeten komen. Dat is een open vraag voor de volgende meting,
en eerlijk gezegd het grootste risico in de hele opzet: de nis is
aantoonbaar echt, maar aantoonbaar klein.

### Waarom de lokale pagina een apart spoor is

Master prompt §3 wil één lokale pagina met LocalBusiness-schema. Maar brief
§7.D noemt dit de openstaande beslissing: landelijk verkeer wordt alleen lokale
patiënt als er ook online behandeld wordt. Master prompt §3 zegt dat Jaap
online én offline behandelt, met voorkeur voor offline.

Die twee zijn niet in tegenspraak, maar ze bepalen wel hoe zwaar de lokale
pagina weegt. Voorstel: de lokale pagina komt er, maar pas nadat spoke 1 of 2
live staat en er verkeer is om te wegen — anders optimaliseren we een trechter
zonder instroom.

---

## De grens met burnout-help.nl

Bewaakt bij elke pagina. De regel uit brief §8 is eenrichtingsverkeer: zodra
burn-out of overspanning het *hoofdonderwerp* zou worden, schrijven we die
pagina niet maar linken we.

Twijfelgevallen die zich zullen aandienen, en hoe ze vallen:

| Onderwerp | zenuwstelsel.com? | Invalshoek |
|---|---|---|
| hartkloppingen | ja | wat doet het autonome zenuwstelsel, waarom, wat helpt |
| slecht slapen | ja | activatie die 's nachts niet uitschakelt |
| uitputting | **grens** | vanuit het systeem: ja. Als "burn-out-moeheid": nee, link |
| ziekmelden, werkhervatting | **nee** | puur label-terrein → burnout-help.nl |
| hersteltijdlijn burn-out | **nee** | idem |
| vergoeding | **nee** | idem — staat al in de FAQ, dat is genoeg |

**Vóór spoke 5 en 8 geschreven worden** moet gecontroleerd worden of
burnout-help.nl al een pagina over hetzelfde symptoom heeft. Zo ja: linken,
niet dupliceren.

---

## Per pagina verplicht (master prompt §6)

Geldt voor elke spoke, zonder uitzondering:

- direct antwoord in de eerste alinea
- één H1, heldere H2-structuur
- bronnen: richtlijn, review of primaire studie — **geen blogs**
- auteur met BIG-nummer, publicatie- en updatedatum
- FAQ alleen waar de vraag echt bestaat
- passend schema (Article of MedicalWebPage; FAQPage alleen bij een echte FAQ;
  LocalBusiness alleen op de lokale pagina)
- interne links naar de hub én naar minimaal één andere spoke
- toon: **upgraden, niet ontkrachten.** Nooit een debunk-artikel. De lijn is:
  je gevoel klopt, er is echt iets met je zenuwstelsel, alleen zijn de
  oplossingen die je online vindt te klein voor waar jij zit.

---

## Status en volgende stap

Het clusterplan is akkoord op hoofdlijn en de scope-vraag is beslist (optie A).
GSC is aangesloten, maar heeft voor zenuwstelsel.com nog **geen enkele rij** —
de property is op 7 september geverifieerd en er is geen backfill.

**Advies: run 2 wacht tot er GSC-data over zenuwstelsel.com zelf is**, rond
14 september. Dan is te zien op welke queries de site al impressies krijgt en
of hij geïndexeerd is. Dat is precies de validatie die master prompt §6 eist
vóór er geschreven wordt.

Wat er in de tussentijd wél kan: de analytics-provider aanzetten, zodat de
trechter gaat tellen zodra er verkeer is.
