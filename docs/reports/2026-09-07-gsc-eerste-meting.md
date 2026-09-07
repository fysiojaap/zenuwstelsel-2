# GSC eerste meting — 7 september 2026

Search Console is verbonden. Dit is de eerste keer dat er harde cijfers in dit
experiment zitten in plaats van schattingen. Er zit één bevinding tussen die
de opzet van het experiment raakt en waar ik een beslissing van Jaap voor nodig
heb.

---

## 1. zenuwstelsel.com

**Geen data.** Nul rijen. Dat is precies wat je verwacht: GSC verzamelt pas
vanaf het moment van verificatie (vandaag) en loopt daarna twee tot drie dagen
achter. Er is geen historische backfill.

Sitemap is ingediend en opgehaald: `lastDownloaded 2026-09-07T06:34`, 1 URL
ingediend, 0 geïndexeerd, **0 fouten, 0 waarschuwingen**. Indexering volgt.

Eerste zinvolle meting: rond 14 september.

---

## 2. Controlegroep psychosomatischefysio.nl — nu gemeten in plaats van geschat

| Maand | Klikken | Impressies | CTR | Gem. positie |
|---|---|---|---|---|
| juni 2026 | 2.144 | 152.832 | 1,40% | 13,6 |
| juli 2026 | 2.397 | 173.096 | 1,38% | 13,1 |
| augustus 2026 | 2.285 | 174.621 | 1,31% | 12,8 |
| **gemiddeld** | **2.275** | **166.850** | **1,36%** | **13,2** |

**Jaaps schatting van ~2.000 bezoekers/maand klopt.** De werkelijke organische
klikken liggen op ~2.275 per maand. De afgeleide conversie van ~0,7% klopt ook:
15,6 intakes op 2.275 klikken is **0,69%**.

Twee dingen vallen op:

**De site staat op pagina 2.** Gemiddelde positie 13,2 met 167.000 impressies
per maand. Er is een enorme impressiebasis die nauwelijks klikken oplevert —
CTR 1,36%. Dit is diagnostische informatie over de controlegroep, geen
actiepunt: de site wordt in dit experiment niet aangeraakt.

**Het verkeer is grotendeels niet-koopbaar.** De grootste queries zijn
`spierreuma ervaringen` (147 klikken), `spierreuma benen` (129),
`degeneratieve veranderingen` (127), `emoties lijst` (81), `dopamine tekort`
(33) en `aardbeien ontstekingsremmend` (27). Dat is informatieverkeer dat
vrijwel zeker geen intake oplevert.

Dat verklaart de 0,69% conversie, en het **onderbouwt de hele premisse van
zenuwstelsel.com**: gerichter verkeer is meer waard dan meer verkeer.

---

## 3. Aanname A — beantwoord, en het antwoord is ja (met maat)

De riskantste aanname uit de brief: *zoeken mensen ook echt zo?*

Gemeten over juni–augustus op psychosomatischefysio.nl:

| Querygroep | Queries | Klikken | Impressies | CTR | Per maand |
|---|---|---|---|---|---|
| bevat "zenuwstelsel" | 60+ | 193 | 10.135 | 1,90% | 64 klikken / 3.378 impressies |
| bevat "vagus" | 40 | 29 | 1.957 | 1,48% | 10 klikken / 652 impressies |

**Ja, mensen zoeken zo.** De taal uit de behandelkamer bestaat ook in Google.
De head-term `ontregeld zenuwstelsel` haalt in drie maanden 768 impressies op
positie 4,6 met een CTR van **4,56%** — ruim drie keer het sitegemiddelde.
Mensen die dit intypen klikken.

Maar houd de maat in de gaten: samen is dit **3,3% van de klikken** en 2,4% van
de impressies van de site. Het is een echte nis, geen goudmijn. Om de
T+9-drempel van 1.500 organische bezoekers per maand te halen moet
zenuwstelsel.com fors meer pakken dan wat er nu op dit thema binnenkomt.

**Bijvangst:** "zenuwstelsel" is zes keer zo groot als "vagus" (64 vs 10
klikken per maand). Dat bevestigt de regel uit brief §8 — bind aan de entiteit,
niet aan het modewoord — nu met een getal in plaats van een intuïtie.

---

## 4. De bevinding die om een beslissing vraagt

**psychosomatischefysio.nl heeft al een zenuwstelsel-cluster, en het rankt.**

Pagina's die op "zenuwstelsel"-queries binnenkomen, juni–augustus:

| Pagina | Klikken | Impressies | CTR | Positie |
|---|---|---|---|---|
| `/een-ontregeld-zenuwstelsel` | 169 | 6.834 | 2,47% | 12,9 |
| `/sympatisch-en-parasympatisch-zenuwstelsel` | 13 | 5.258 | 0,25% | 18,3 |
| `/hoe-het-parasympathisch-zenuwstelsel-werkt` | 10 | 3.568 | 0,28% | 14,3 |
| `/de-nervus-vagus-uitgelegd` | 0 | 76 | 0% | 67,6 |
| `/window-of-tolerance-nederlands` | 0 | 1 | — | 3,0 |

Voor de head-term `ontregeld zenuwstelsel` staat die eerste pagina op **positie
4,6**.

Leg dat naast het clusterplan van zenuwstelsel.com:

| Geplande spoke | Bestaat al op psychosomatischefysio.nl? |
|---|---|
| Wat is een ontregeld zenuwstelsel? | **ja** — `/een-ontregeld-zenuwstelsel`, positie 4,6 |
| De drie standen van je zenuwstelsel | **ja, deels** — de sympathisch/parasympathisch-pagina's |
| Window of tolerance | **ja** — `/window-of-tolerance-nederlands` |
| Nervus vagus-content | **ja** — `/de-nervus-vagus-uitgelegd` |

### Waarom dit een probleem is

De brief trekt één harde grens: die met burnout-help.nl. Er is nooit
gecontroleerd of psychosomatischefysio.nl al op ditzelfde terrein zit. Dat doet
het, en dat breekt twee dingen tegelijk:

**1. De controlegroep is niet schoon.** Brief §5 zegt: stijgen beide sites, dan
was het de markt. Maar als zenuwstelsel.com de query `ontregeld zenuwstelsel`
wint, verliest psychosomatischefysio.nl hem. De controlegroep daalt dan dóór
het experiment. De logica draait om en de meting is stuk.

**2. Winst kan schijnwinst zijn.** Als zenuwstelsel.com 60 klikken per maand
pakt die nu al naar psychosomatischefysio.nl gaan, dan is de netto opbrengst
nul — maar het experiment rapporteert succes. Dat is precies het soort
zelfbedrog waar deze hele opzet tegen bedoeld is.

### Wat ik níet ga doen

Master prompt §10 verbiedt wijzigingen aan psychosomatischefysio.nl, en §10
zegt: stoppen en vragen bij twijfel over de grens. Ik raak die site dus niet
aan en ik schrijf geen spoke die met een bestaande pagina concurreert totdat
Jaap hierover beslist.

### De keuze

| Optie | Wat het betekent |
|---|---|
| **A. Splitsen** | zenuwstelsel.com pakt alleen wat psychosomatischefysio.nl níet dekt: hype-versus-bewijs, het ijsbad, polyvagaal-kritiek, zelfregulatie-grenzen. Spokes 3, 4 en 6 vervallen. Schoonste meting, kleinste ambitie. |
| **B. Verhuizen** | De zenuwstelsel-pagina's gaan van psychosomatischefysio.nl naar zenuwstelsel.com, met 301-redirects. Eén sterke bron in plaats van twee zwakke. Maar: de controlegroep is dan definitief weg, en dit valt buiten de scope van deze agent. |
| **C. Accepteren** | Bewust dubbelen en accepteren dat kannibalisatie de meting vertroebelt. Alleen verdedigbaar als de primaire KPI intakes is en het niet uitmaakt wélke site ze levert. |

**Mijn advies: A.** Het houdt de controlegroep intact, het is omkeerbaar, en het
richt zenuwstelsel.com precies op het gat dat in de SERP-analyse al zichtbaar
was — de eerlijke hype-versus-bewijs-stem die in Nederland niet bestaat. Dat is
ook het stuk waar psychosomatischefysio.nl níets heeft.

Optie B is op termijn misschien sterker, maar is een beslissing over twee sites
tegelijk en hoort niet bij een agent die er één beheert.

---

## 5. Wat dit betekent voor het clusterplan

Onder optie A wordt de volgorde:

1. Werkt een ijsbad voor je nervus vagus? — geen overlap, gat in de markt
2. Wat werkt en wat is hype — geen overlap, het citeerbare bezit
3. Polyvagaal-theorie: wat klopt — geen overlap
4. Wanneer lukt zelfregulatie niet meer — geen overlap, hoogste intake-intentie
5. De 4-6 ademhaling — controleren op overlap vóór schrijven
6. Lokale pagina Den Bosch — apart spoor, zoals eerder

Vervallen onder optie A: "Wat is een ontregeld zenuwstelsel", "De drie standen",
"Window of tolerance" — die linken dan naar de bestaande pagina's in plaats van
ze te dupliceren.

**Ik wacht op Jaaps keuze voordat run 2 begint te schrijven.**
