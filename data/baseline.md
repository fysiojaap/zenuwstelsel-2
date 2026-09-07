# Baseline — zenuwstelsel.com

**Vastgelegd:** 7 september 2026 (T+0, run 01)
**Door:** groei-agent, eerste run
**Regel:** ontbrekende data heet hier "ontbreekt". Nooit een geschat getal
zonder dat het als schatting gemarkeerd staat.

---

## 1. zenuwstelsel.com

| Metric | Waarde op 2026-09-07 | Bron | Betrouwbaarheid |
|---|---|---|---|
| Organische klikken / maand | **0 rijen** | GSC | property vandaag geverifieerd; geen backfill |
| Impressies / maand | **0 rijen** | GSC | idem |
| Gemiddelde positie | **geen data** | GSC | idem |
| Geïndexeerde pagina's | **0 van 1** | GSC sitemaps | sitemap opgehaald 06:34, 0 fouten |
| Teststarts / maand | **0 gemeten** | — | instrumentatie bestond niet vóór vandaag |
| Testafrondingen / maand | **0 gemeten** | — | idem |
| Afrondingspercentage | **ontbreekt** | — | idem |
| CTA-kliks / maand | **0 gemeten** | — | idem |
| Toegeschreven intakes | **0 gemeten** | — | geen UTM's vóór vandaag |

**Belangrijk:** "0 gemeten" betekent níet dat er nul verkeer was. Het betekent
dat er niets meette. Alles vóór 2026-09-07 is en blijft onmeetbaar. De echte
nulmeting begint op de dag dat de analytics-provider aanstaat (zie
`docs/instrumentatie.md`) — niet vandaag.

### Technische staat op 2026-09-07 (vóór deze run)

| Check | Status vóór | Status na run 01 |
|---|---|---|
| HTTPS | ok | ok |
| http → https redirect | ok (301) | ok |
| www → apex redirect | **ontbrak** (www gaf 200) | opgelost (301) |
| /index.html duplicaat | **gaf 200** | opgelost (301 → /) |
| robots.txt | **404** | aanwezig |
| sitemap.xml | **404** | aanwezig |
| canonical | ok | ok |
| meta robots | ontbrak (impliciet ok) | expliciet, met max-snippet |
| Compressie | ok (brotli, 55 kB → 12 kB) | ok |
| JSON-LD | valide, zonder datums | + datePublished/dateModified/lastReviewed |
| Analytics | **geen enkele** | vendor-neutrale laag, wacht op provider |
| UTM's op CTA's | **geen** | alle 5 |
| og:image | ontbreekt | ontbreekt nog (geen beeldasset) |

Serverdatum van de laatst gedeployde build vóór deze run: `2026-04-25`.
De site stond dus ruim vier maanden ongewijzigd en ongemeten live.

---

## 2. Controlegroep: psychosomatischefysio.nl

Gemeten in GSC op 2026-09-07, over juni t/m augustus 2026:

| Metric | Waarde | Bron | Betrouwbaarheid |
|---|---|---|---|
| Organische klikken / maand | **2.275** | GSC | gemeten |
| Impressies / maand | **166.850** | GSC | gemeten |
| CTR | **1,36%** | GSC | gemeten |
| Gemiddelde positie | **13,2** | GSC | gemeten |
| Gratis intakes jan–sep 2026 | 125 (~15,6 / maand) | eigen opgave Jaap | niet geverifieerd |
| Conversie klik → intake | **0,69%** | 15,6 / 2.275 | afgeleid uit één gemeten en één opgegeven getal |

Per maand: juni 2.144 klikken · juli 2.397 · augustus 2.285.

**Jaaps schatting klopt.** ~2.000 bezoekers per maand was een goede
inschatting (werkelijk 2.275), en de afgeleide conversie van ~0,7% klopt
op 0,69%. De baseline uit de brief hoeft niet bijgesteld te worden.

**Twee dingen die de brief niet wist:**

1. De site staat gemiddeld op **positie 13,2** — pagina 2 — met 167.000
   impressies per maand en een CTR van 1,36%. Grote impressiebasis, weinig
   klikken.
2. Het verkeer is grotendeels **niet-koopbaar**: de grootste queries zijn
   `spierreuma ervaringen`, `degeneratieve veranderingen`, `emoties lijst`,
   `dopamine tekort`, `aardbeien ontstekingsremmend`. Informatieverkeer dat
   vrijwel zeker geen intake oplevert. Dat verklaart de 0,69% conversie en
   onderbouwt de premisse van zenuwstelsel.com: gerichter is meer waard
   dan meer.

**Wel geverifieerd op 2026-09-07:** de site draait GA4 (property-id's
`G-70V3CY4G1B` en `G-6WBKRW6390`) en Google Tag Manager (`GTM-MPMNRTG4`).
Dat is goed nieuws voor de attributie — zie §3.

De site wordt in dit experiment **niet aangeraakt**. Hij is de controlegroep.

---

## 3. Attributieketen — status

De keten die een intake herleidbaar moet maken naar zenuwstelsel.com:

1. **Bezoeker klikt CTA op zenuwstelsel.com** → vanaf nu met UTM. ✅ gebouwd
2. **GA4 op psychosomatischefysio.nl vangt de UTM op** → technisch aanwezig
   (GA4 registreert `session_source=zenuwstelsel`, `session_medium=referral`,
   `session_campaign=<uitslagtype>` automatisch). ⚠️ moet één keer in de
   praktijk bevestigd worden met een echte testklik.
3. **Formulierinzending wordt gemeten** → ✅ **ja, beter dan gedacht.**
   Gemeten in GA4 op 2026-09-07 (property `450662579`, "Fysiojaap"):

   Er ís een bedankpagina. Het formulier op `/neem-contact-op` stuurt door naar
   **`/bedankt`**, en daar vuurt het event `adeviesgesprek_aangevraagd`. Over
   juni–augustus 22 keer, oftewel ~7 per maand.

   *Correctie op een eerdere aanname in dit document: ik las in de paginacode
   een inline "Bedankt"-melding en concludeerde dat er geen bedankpagina was.
   Dat klopte niet. De pagina bestaat, en daarmee is de attributie een stuk
   eenvoudiger dan gevreesd: een `page_view` op `/bedankt` met
   `session_source=zenuwstelsel` is een schone, telbare conversie.*

4. **Maar het telt niet als key event** → ⚠️ **kapot door een naamfout.**
   De ingestelde key events zijn `purchase`, `Adviesgesprek_aangevraagd` en
   `Gratis_gesprek_geboekt`. Het event dat werkelijk vuurt heet
   `adeviesgesprek_aangevraagd` — kleine letter én een typefout
   ("adevies" in plaats van "advies"). GA4-eventnamen zijn hoofdlettergevoelig,
   dus die 22 inzendingen tellen als **nul** conversies.

   Hetzelfde geldt voor `GA4_gratis_gesprek_boeken` (37 keer in drie maanden,
   de CTA-klik op diverse pagina's): geen key event. Alleen
   `Gratis_gesprek_geboekt` telt, en dat vuurde 8 keer.

   **Netto: van ~59 conversie-achtige gebeurtenissen in drie maanden worden er
   8 geteld.** Dit raakt Jaaps eigen rapportage over zijn hoofdsite, niet
   alleen dit experiment.

5. **De intake-afspraak zelf** → valt buiten GA4. Hier is de intakevraag
   ("hoe bent u hier gekomen, welk woord zocht u?") de enige harde bron.

**Open vraag uit deze meting:** het formulier levert ~7 inzendingen per maand,
terwijl Jaap ~15,6 intakes per maand noemt. Ongeveer de helft komt dus
vermoedelijk binnen via telefoon, mail, WhatsApp of verwijzing — kanalen die
GA4 nooit ziet. Dat is geen probleem, maar het bepaalt wel hoe je de cijfers
leest: **GA4 kan hooguit de helft van de intakes verklaren.** De intakevraag
uit brief §6.3 blijft daarmee de enige volledige bron.

**Wat dit betekent voor de primaire KPI:** de keten wérkt. Zelfs zonder de
key-event-fix te repareren is een conversie uit zenuwstelsel.com te meten als
een `page_view` op `/bedankt` met `session_source=zenuwstelsel`. Het
repareren van de namen maakt het alleen netter en herstelt Jaaps eigen
conversierapportage.

---

## 4. Google Search Console — opgelost op 2026-09-07

GSC-toegang is er. Beide properties zijn zichtbaar met `siteOwner`-rechten:
`sc-domain:zenuwstelsel.com` en `https://www.psychosomatischefysio.nl/`. De
controlegroep is dus niet alleen te vergelijken, maar ook direct te meten.

De volledige eerste meting staat in
`docs/reports/2026-09-07-gsc-eerste-meting.md`.

## 4b. Aanname A — gemeten, en hij houdt stand

De riskantste aanname uit de brief (§7.A: zoeken mensen ook echt zo?) is
beantwoord met echte data uit de controlegroep, juni–augustus 2026:

| Querygroep | Klikken / maand | Impressies / maand | CTR |
|---|---|---|---|
| bevat "zenuwstelsel" (60+ queries) | 64 | 3.378 | 1,90% |
| bevat "vagus" (40 queries) | 10 | 652 | 1,48% |

**Ja, de taal uit de behandelkamer bestaat ook in Google.** De head-term
`ontregeld zenuwstelsel` staat op positie 4,6 met een CTR van 4,56% — ruim
drie keer het sitegemiddelde. Wie dit intypt, klikt.

Maar: samen is dit 3,3% van de klikken van de site. Een echte nis, geen
goudmijn. En "zenuwstelsel" is zes keer zo groot als "vagus" — wat de regel
uit brief §8 bevestigt met een getal: bind aan de entiteit, niet aan het
modewoord.

## 4c. Openstaand risico: kannibalisatie van de controlegroep

psychosomatischefysio.nl heeft **al** een zenuwstelsel-cluster dat rankt —
onder meer `/een-ontregeld-zenuwstelsel` (169 klikken in drie maanden,
positie 4,6 op de head-term), plus pagina's over sympathisch/parasympathisch,
de nervus vagus en window of tolerance.

Drie geplande spokes van zenuwstelsel.com dupliceren die. Dat maakt de
controlegroep onzuiver en kan winst op zenuwstelsel.com verwarren met
verplaatst verkeer. **Beslissing van Jaap nodig vóór run 2 begint te
schrijven.** Zie het GSC-rapport §4.

---

## 5. Doelen uit de brief, ter herinnering

| Mijlpaal | Organisch / maand | Intakes / maand | Kill-signaal |
|---|---|---|---|
| T+3 — dec 2026 | ≥ 300 | — | onder de helft → diagnose, geen kill |
| T+6 — mrt 2027 | ≥ 800 | ≥ 3 | < 300 bezoekers, óf conversie < 1% |
| T+9 — jun 2027 | ≥ 1.500 | ≥ 8 | schalen of stoppen |

**Openstaand (brief §10.4):** is het doel 30 intakes/maand, of was 3-5 per week
het echte doel? De huidige 15,6/maand ≈ 3,5/week zit al in die bandbreedte.
Dat verschil bepaalt of dit experiment een optimalisatie is of een verdubbeling.
