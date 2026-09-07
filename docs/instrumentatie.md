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

## 3. Wat Jaap moet doen — de provider aanzetten

De agent kan geen analytics-account aanmaken. Dit is de enige handeling die
nodig is om de meting te laten lopen.

### Aanbevolen: Plausible

Waarom Plausible en niet GA4:

- **Cookieloos.** Geen consent-banner nodig, geen cookiemuur op een pagina die
  juist op vertrouwen draait.
- **De privacybelofte blijft verdedigbaar.** Bij GA4 moet je uitleggen wat
  Google met de data doet. Bij Plausible is dat verhaal kort.
- **Schone scheiding van de controlegroep.** psychosomatischefysio.nl draait
  GA4; zenuwstelsel.com op een aparte provider betekent dat de twee datasets
  nooit per ongeluk door elkaar lopen. De controlegroep uit brief §5 blijft
  zuiver.
- Custom events zitten in het basisabonnement (~€9/maand).

**Stap 1** — maak een account op plausible.io en voeg `zenuwstelsel.com` toe
als site.

**Stap 2** — zet in `index.html`, vlak vóór `</head>`, deze regel:

```html
<script defer data-domain="zenuwstelsel.com" src="https://plausible.io/js/script.js"></script>
```

**Stap 3** — spiegel naar `build/` (`cp index.html build/`), commit, push.

**Stap 4** — maak in Plausible vijf custom-event-goals aan met exact deze
namen: `zs_test_start`, `zs_test_vraag`, `zs_test_klaar`, `zs_test_opnieuw`,
`zs_cta_klik`.

### Alternatief: GA4

Werkt ook — de laag ondersteunt `gtag` en `dataLayer`. Plak de GA4- of
GTM-snippet in de `<head>` en de events komen binnen als custom events. Gebruik
dan wel een **aparte property**, niet `G-70V3CY4G1B` van
psychosomatischefysio.nl, anders is de controlegroep vervuild. En houd er
rekening mee dat GA4 cookies zet: dan is een consent-oplossing nodig, en dan
moet de belofte onder de test opnieuw tegen het licht.

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
