# Instrumentatie — zenuwstelsel.com

Hoe de funnel-meting werkt, wat hij wel en niet meet, en wat er nog moet
gebeuren om hem aan te zetten.

---

## 1. Het principe

**Gedrag meten, inhoud niet.**

De test belooft onder aan de vragen: *"Je antwoorden blijven op deze pagina —
ze worden niet opgeslagen en niet verzonden. We tellen alleen anoniem hoe vaak
de test wordt gestart en afgerond."*

Die belofte is hard. De instrumentatie meet daarom uitsluitend:

| Event | Props | Wat het zegt |
|---|---|---|
| `zs_test_start` | — | iemand beantwoordde vraag 1 |
| `zs_test_vraag` | `vraag: 1..6` | tot hoe ver iemand kwam (uitvalpunt) |
| `zs_test_klaar` | `uitslag: activatie \| uitschakeling \| wisselend \| gereguleerd` | welk uitslagtype verscheen |
| `zs_test_opnieuw` | — | iemand deed de test opnieuw |
| `zs_cta_klik` | `campagne: <utm_campaign>` | welke CTA is aangeklikt |
| `zs_uitgaande_link` | `campagne: <utm_campaign>` | een contentlink naar psychosomatischefysio.nl (géén CTA) |

**Wat er nadrukkelijk níet in zit:** geen enkel gegeven antwoord (A/B/C), geen
antwoordcombinatie, geen vrije tekst, geen persoonsgegevens, geen identifier.
Het uitslagtype is een categorie uit vier, geen reconstructie van de antwoorden.

Dit is geverifieerd in de browser: bij een volledige testdoorloop bevatten de
verstuurde events geen enkele antwoordwaarde.

### Do Not Track

Staat `navigator.doNotTrack === '1'`, dan vuurt er geen enkel event. De
bezoeker die om privacy vraagt, krijgt privacy — ook al zou een cookieloze
provider juridisch gezien mogen tellen.

---

## 2. Hoe het technisch werkt

In `index.html` staat vóór het testscript een kleine, vendor-neutrale laag die
`window.zsTrack(event, props)` definieert. Die stuurt het event naar de eerste
provider die op de pagina aanwezig is:

1. `window.plausible(...)` — Plausible
2. `window.dataLayer.push(...)` — Google Tag Manager
3. `window.gtag('event', ...)` — GA4 direct

**Staat er geen provider, dan is het een no-op.** Geverifieerd: bij een
volledige testdoorloop zonder provider verlaat er geen enkel netwerkverzoek
de browser (afgezien van Google Fonts). De site werkt gewoon door; er wordt
alleen niets geteld.

Dat betekent: de meting is nú al ingebouwd en wacht alleen op een provider.
Er hoeft geen code meer bij.

Uitgaande kliks worden **gedelegeerd** afgevangen op elke link naar
`psychosomatischefysio.nl`. De campagnenaam wordt uit de `utm_campaign` in de
href gelezen, niet apart gehardcodeerd. Markup en meting kunnen dus niet uit
elkaar lopen, en een toekomstige CTA telt automatisch mee.

**Twee soorten links, twee events.** Sinds Jaaps keuze voor optie A (zie
`docs/clusterplan.md`) verwijst zenuwstelsel.com voor sommige onderwerpen naar
bestaande pagina's op psychosomatischefysio.nl in plaats van ze te dupliceren.
Zulke contentlinks gaan naar hetzelfde domein als de CTA's, en als ze samen
geteld werden zou elke verwijzing in de lopende tekst als intake-intentie
meetellen — de trechtercijfers zouden onbruikbaar zijn.

Het onderscheid hangt aan de knopklassen:

| Link | Event |
|---|---|
| `a.btn-primary` of `a.btn-inline` | `zs_cta_klik` |
| elke andere link naar psychosomatischefysio.nl | `zs_uitgaande_link` |

**Bij het schrijven van een spoke: geef een contentlink nooit `btn-primary` of
`btn-inline`.** Dat is de enige manier waarop deze twee door elkaar kunnen
gaan lopen.

---

## 3. De provider: GA4 op property G-70V3CY4G1B

**Gekozen op 2026-09-07 door Jaap.** Dezelfde property als
psychosomatischefysio.nl, met cross-domain tracking en een toestemmingsbalk.

### Waarom dezelfde property, en niet een aparte

De eerste redenering hier was dat een aparte property nodig was om de
controlegroep schoon te houden. Dat klopte niet: de controlegroep-vergelijking
uit brief §5 draait op **Search Console**, en dat zijn sowieso al twee losse
properties. GA4 raakt daar niets aan.

De echte winst van één property is attributie. Alleen binnen één property kan
cross-domain de reis volgen van de test naar de contactpagina. Dat repareert de
zwakste schakel uit `data/baseline.md` §3: tot nu toe wisten we alleen dat er
sessies met `utm_source=zenuwstelsel` binnenkwamen, niet of dezelfde persoon
daarna daadwerkelijk contact opnam.

**Scheiden gebeurt op de dimensie `hostname`.** In elk rapport waar het om
zenuwstelsel.com gaat, filter je daarop.

**Let op — dit raakt de bestaande rapportage.** Verkeer van zenuwstelsel.com
loopt vanaf nu mee in de standaardrapporten van psychosomatischefysio.nl.
Zonder hostname-filter tel je twee sites bij elkaar op.

### Hoe de toestemming werkt

`gtag.js` wordt **niet** geladen bij het openen van de pagina. In de `<head>`
staat alleen een stub die commando's in `dataLayer` parkeert, plus Consent Mode
v2 met alles op `denied`.

| Situatie | Wat er gebeurt |
|---|---|
| Nog geen keuze | Balk verschijnt. Events parkeren in dataLayer. `gtag.js` wordt niet geladen; er verlaat niets de browser. |
| Klikt "Liever niet" | Keuze opgeslagen. `zsTrack` stopt met parkeren. `gtag.js` wordt nooit geladen. |
| Klikt "Prima" | `consent update` naar `granted`, `gtag.js` laadt, de geparkeerde events worden alsnog verwerkt. |
| Herbezoek na keuze | Geen balk. Bij "ja" laadt gtag meteen. |
| Do Not Track aan | Geen balk, geen events, geen gtag. DNT telt als een nee. |

Er zijn dus **geen cookieloze pings** en geen "modelled data" bij weigering.
Wie nee zegt, wordt niet gemeten. Punt.

De keuze staat in `localStorage`, niet in een cookie — een cookie plaatsen om
te onthouden dat iemand géén cookies wil, is precies het soort ding waar deze
pagina niet aan mee moet doen. Advertentie-toestemmingen blijven altijd
`denied`; er wordt hier niets geadverteerd.

In de footer staat "Cookievoorkeur wijzigen", zodat een keuze terug te draaien
is.

### Wat Jaap nog moet doen in GA4

De code is klaar. Twee dingen kan de agent niet doen:

**1. Cross-domain instellen.** GA4 → Beheer → Gegevensstromen → de stream van
psychosomatischefysio.nl → Tag-instellingen configureren → **Je domeinen
configureren**. Voeg toe: `zenuwstelsel.com` én `psychosomatischefysio.nl`.
Zonder deze stap krijgt de bezoeker bij de sprong een nieuwe client_id en is de
reis alsnog niet te volgen.

**2. De key-event-namen repareren.** Uitgezocht op 2026-09-07; dit was de
laatste onbekende in de keten en het antwoord is dubbel.

*Het goede nieuws:* het formulier op `/neem-contact-op` stuurt door naar
**`/bedankt`**, en daar vuurt `adeviesgesprek_aangevraagd` — ~7 per maand. De
attributie is dus eenvoudiger dan gedacht: een `page_view` op `/bedankt` met
`session_source=zenuwstelsel` is een schone conversie.

*Het slechte nieuws:* dat event telt niet mee. De ingestelde key events zijn
`Adviesgesprek_aangevraagd` en `Gratis_gesprek_geboekt`; wat werkelijk vuurt
heet `adeviesgesprek_aangevraagd` (kleine letter én een typefout) en
`GA4_gratis_gesprek_boeken`. GA4-eventnamen zijn hoofdlettergevoelig, dus over
juni–augustus werden van ~59 conversie-achtige gebeurtenissen er **8** geteld.

**De fix, in GA4 → Beheer → Gebeurtenissen — geen wijziging aan de site:**
zet de schakelaar "Markeren als sleutelgebeurtenis" aan bij de events die
écht vuren:

| Zet aan | Wat het is | Per maand |
|---|---|---|
| `adeviesgesprek_aangevraagd` | formulier verzonden, vuurt op `/bedankt` | ~7 |
| `GA4_gratis_gesprek_boeken` | CTA-klik naar de intakepagina | ~12 |

De oude, verkeerd gespelde key events kunnen blijven staan; ze vuren toch
nooit. Hernoemen van het bestaande event is óók een optie, maar dan breekt de
historie — aanzetten van het juiste event is veiliger.

**Let op bij het lezen van de cijfers:** het formulier levert ~7 inzendingen
per maand terwijl Jaap ~15,6 intakes per maand heeft. Ongeveer de helft komt
binnen via telefoon, mail, WhatsApp of verwijzing. GA4 kan dus hooguit de
helft van de intakes verklaren; de intakevraag uit brief §6.3 blijft de enige
volledige bron.

Daarna: doe de test één keer zelf, accepteer de balk, en kijk in GA4 →
Realtime of `zs_test_start` en `zs_test_klaar` binnenkomen. Dat is het bewijs
dat de keten werkt.

### Over de UTM's naast cross-domain

De CTA's houden hun UTM-parameters. Dat betekent dat GA4 de landing op de
contactpagina als een **nieuwe sessie** met campagne `zenuwstelsel` telt, ook
al is het dezelfde bezoeker — een campagnewissel start in GA4 altijd een nieuwe
sessie.

Dat is geen fout en geen verlies: cross-domain houdt de **client_id** vast, dus
op gebruikersniveau is de reis wel te volgen. En de UTM's blijven de robuuste
terugvaloptie als cross-domain om welke reden dan ook niet werkt. Verwacht
alleen geen sessie die netjes over twee domeinen doorloopt.

### Als de balk de conversie schaadt

De balk is een wijziging aan de trechter en valt dus onder master prompt §4:
één wijziging tegelijk, hypothese vooraf, minimaal twee weken meten.

**Hypothese:** de balk kost enkele procenten testafronding, en dat is het waard
omdat er zonder meting helemaal niets te sturen valt.

**Hoe je het merkt:** het afrondingspercentage is meetbaar zodra er data is.
Blijkt de balk duurder dan verwacht, dan is Plausible het alternatief —
cookieloos, geen balk, ~€9/maand, en de instrumentatielaag ondersteunt het
zonder één regel code te veranderen.

---

## 4. Attributie — de UTM-keten

Alle vijf uitgaande CTA's dragen sinds 2026-09-07 UTM-parameters:

```
https://www.psychosomatischefysio.nl/neem-contact-op
  ?utm_source=zenuwstelsel
  &utm_medium=referral
  &utm_campaign=<campagne>
```

| Plek op de pagina | `utm_campaign` |
|---|---|
| Uitslag "verhoogde activatie" | `uitslag-activatie` |
| Uitslag "uitschakeling" | `uitslag-uitschakeling` |
| Uitslag "wisselend" | `uitslag-wisselend` |
| Uitslag "gereguleerd" | `uitslag-gereguleerd` |
| Het grote CTA-blok onderaan | `cta-blok` |

Zo is per uitslagtype te zien welke groep doorklikt — en dus of de
uitslagteksten hun werk doen.

### De ontvangende kant

**Gecontroleerd op 2026-09-07:** psychosomatischefysio.nl draait GA4
(`G-70V3CY4G1B`, `G-6WBKRW6390`) en GTM (`GTM-MPMNRTG4`). GA4 registreert
UTM-parameters automatisch als `session_source` / `session_medium` /
`session_campaign`. De parameters komen dus aan.

**Twee dingen die Jaap nog moet verifiëren:**

1. **Doet de keten het echt?** Klik één keer op een CTA op zenuwstelsel.com en
   kijk in GA4 → Realtime of er een sessie binnenkomt met bron `zenuwstelsel`.
   Vijf minuten werk, en het is het verschil tussen aannemen en weten.

2. **Wordt een formulierinzending als key event geteld?** Dit is de zwakke
   schakel. Zonder key event op de inzending laat GA4 wel zien hoevéél mensen
   vanaf zenuwstelsel.com op de contactpagina landen, maar niet hoeveel er
   daadwerkelijk een intake aanvragen. Te checken in GA4 → Admin → Events.

Zolang punt 2 niet rond is, is de **intakevraag uit brief §6.3** de enige
harde bron voor de primaire KPI: vraag bij de eerstvolgende tien intakes hoe
iemand binnenkwam en welk woord diegene zocht.

---

## 5. Wat er bewust níet gemeten wordt

- **Scrolldiepte, heatmaps, sessieopnames.** Passen niet bij de belofte, en
  voegen niets toe aan de primaire KPI.
- **Individuele antwoordcombinaties.** Zou verleidelijk zijn ("welke vraag
  voorspelt conversie?"), maar breekt de belofte. Niet doen.
- **A/B-tests met cookies.** Zelfde reden. Wijzigingen aan de trechter gaan
  sequentieel, één tegelijk, met minimaal twee weken meettijd (master prompt §4).
