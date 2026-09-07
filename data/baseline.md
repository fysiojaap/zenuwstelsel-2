# Baseline — zenuwstelsel.com

**Vastgelegd:** 7 september 2026 (T+0, run 01)
**Door:** groei-agent, eerste run
**Regel:** ontbrekende data heet hier "ontbreekt". Nooit een geschat getal
zonder dat het als schatting gemarkeerd staat.

---

## 1. zenuwstelsel.com

| Metric | Waarde op 2026-09-07 | Bron | Betrouwbaarheid |
|---|---|---|---|
| Organische klikken / maand | **ontbreekt** | — | geen GSC-toegang, zie §4 |
| Impressies / maand | **ontbreekt** | — | geen GSC-toegang |
| Gemiddelde positie | **ontbreekt** | — | geen GSC-toegang |
| Geïndexeerde pagina's | **ontbreekt** | — | geen GSC-toegang |
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

| Metric | Waarde | Bron | Betrouwbaarheid |
|---|---|---|---|
| Bezoekers / maand | ~2.000 | eigen opgave Jaap | niet geverifieerd |
| Gratis intakes jan–sep 2026 | 125 (~15,6 / maand) | eigen opgave Jaap | niet geverifieerd |
| Impliciete conversie | ~0,7% | afgeleid uit bovenstaande | **afgeleid, niet gemeten** |
| GSC-trend | **ontbreekt** | — | geen GSC-toegang |

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
3. **Formulierinzending wordt als key event geteld in GA4** → **onbekend**.
   Het contactformulier is een Hostinger-formulier (`Contact form 19`).
   Of de inzending een GA4-event afvuurt is niet van buitenaf vast te stellen.
   ⚠️ te controleren door Jaap in GA4.
4. **De intake-afspraak zelf** → valt buiten GA4. Hier is de intakevraag
   ("hoe bent u hier gekomen, welk woord zocht u?") de enige harde bron.

**Zwakste schakel: stap 3.** Zonder een key event op de formulierinzending
levert GA4 wel *sessies* per bron, maar geen *conversies* per bron. Dan is de
primaire KPI alleen te vullen via de intakevraag uit brief §6.3.

---

## 4. Blokkade: Google Search Console

Er is op 2026-09-07 **geen GSC-toegang** vanuit de agent. Zonder GSC:

- is de primaire verkeersbron van het experiment onmeetbaar (master prompt §1:
  "Als GSC het niet laat zien, is het niet gebeurd");
- kan de indexeringsstatus niet bevestigd worden;
- kunnen de kandidaat-spokes niet tegen echte queries gevalideerd worden;
- is er geen controlegroep-vergelijking mogelijk.

Dit is de enige echte P0-blokkade van dit experiment. Zie het runrapport
`docs/reports/2026-09-07-run-01.md` voor wat Jaap moet doen.

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
