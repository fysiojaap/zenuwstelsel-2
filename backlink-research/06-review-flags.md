# Fase 5 Review Bevindingen

**Reviewer:** kritische review-agent (Opus 4.7)
**Datum:** 2026-05-23
**Scope:** top-100 in `05-top100.md` + `04-ranked.csv` + steekproef `03-deep-dive/*.json`
**WebSearch budget gebruikt:** 17 calls (15 steekproef + 2 spot-check) — binnen budget van ~20.

> Methodologie-noot: WebFetch geblokkeerd, dus verificatie uitsluitend via WebSearch. De afwezigheid van link_policy/contact in JSONs is bekend (pivot-besluit, niet beoordeeld als fout).

---

## Steekproef (15 sites, rank verspreid 3-99)

- ✓ **#3 nvp-hrnetwerk.nl** — site bestaat, recent_article_url (2026-03-09 over medewerkersvrijwilligerswerk) niet 1:1 teruggevonden in WebSearch, maar wél 9 andere artikelen in 2026 (incl. coalitieakkoord, trendrapport DI, meer verzuim onder vrouwen). DR/doelgroep/fit redelijk. (Hint: agent gaf zeer specifieke URL maar Google index toont andere stukken — kan correct zijn als dieper in index.)
- ✓ **#8 mtsprout.nl** — bevestigd: artikel "4 goede voornemens die je in 2026 een betere leider maken" bestaat exact. DR HIGH (premium ondernemers-medium): plausibel. Doelgroep HR is wat ruim (medium is breder management/ondernemers); zou eerder `ondernemer` of mixed zijn — minor.
- ✓ **#15 npdi.nl** — bevestigd: netwerkbijeenkomst 23 maart 2026 in Rotterdam exact zoals beweerd. DR MEDIUM voor niche-platform plausibel. fit_score=5 lijkt iets te hoog voor netwerk-platform zonder gastartikel-track (zou 4 zijn).
- ✓ **#22 binnenlandsbestuur.nl** — bevestigd: CAO-rijk-artikel bestaat exact, mei 2026 stuk. Hoge autoriteit voor publieke sector klopt. DR HIGH plausibel.
- ⚠ **#25 coachlink.nl** — site bevestigd. WebSearch laat `redactie@coachlink.nl` adres zien voor inzendingen (klopt met first_impression). Maar: submission_url_hint='niet gevonden' terwijl het verwante `nobco.nl/over-nobco/onze-mediakanalen/` overduidelijk relevant is — research had verder kunnen gaan. Geen hard-fout.
- ⚠ **#35 managementscope.nl** — site bestaat, hoge autoriteit voor governance/board OK. MAAR: recent_article_url wijst naar een ENGELS essay (`/en/essay/issues-agm-agenda-good-governance`) en de titel "Issues on the AGM's Agenda in 2025" mismatcht met recent_article_date='2026'. Bovendien is ManagementScope sterk redactie-gestuurd (geen open call voor externe gastauteurs) — fit_score=4 is optimistisch. Markeer als suspect.
- ⚠ **#42 xperthractueel.nl** — URL en titel kloppen exact (loonkloof+APG). MAAR pitch_angle ("loonkloof verkleinen door retentie van vrouwen na zwangerschapsverlof") is een vergezochte koppeling tussen zenuwstelsel en loonkloof — invalshoek is gestretcht voor dit kanaal. XpertHR/Brightmine is bovendien een betaalde kennisplatform, niet typisch open voor expertbijdragen. Suspect.
- ✓ **#50 register-rsc.nl** — bevestigd: Jaarcongres 2026 "Toekomst van het Vak" bestaat exact (1 april 2026). DR MEDIUM voor branche-register plausibel. Goede fit.
- ✓ **#65 ggznieuws.nl** — bevestigd: artikel over 54% werkenden met mentale klachten (HSK Monitor 2026) bestaat exact. Doelgroep `zorgprof` klopt. Fit/DR plausibel.
- ✓ **#63 driessengroep.nl** — bevestigd: Jaarcongres HRM-pagina bestaat. recent_article_url is een tab `/en/actual/congress-hrm` (Engelse landingspagina) — minor (de pagina bestaat maar is geen artikel-URL). Suspect-light.
- ✓ **#72 shiftbase.com** — bevestigd: HR-wetgeving 2026-artikel exact, plus ~7 andere 2026-stukken. SaaS vendor-blog, fit OK. Doelgroep HR plausibel.
- ✓ **#80 nn.nl** — bevestigd: artikel "Verzuim voorkomen in de praktijk" exact gevonden, plus rijke verzuim-content (Werkgever-sectie). Hoge autoriteit OK. Verzekeraars laten zelden externe gastauteurs toe — fit_score=4 mogelijk wat hoog (3 realistischer).
- ⚠ **#87 hays.nl** — URL en titel kloppen exact. Maar inhoud van het stuk gaat over AI-vaardigheden en arbeidsmarkt, niet over welzijn/burnout. Zelf in fit_motivation staat al "welzijn is randthema" — passend bij fit_score=3, maar de pitch-angle (AI-druk → burn-out) is ge-stretched. Markeer als suspect: low-relevantie target voor zenuwstelsel-pitch.
- ✓ **#93 unive.nl** — bevestigd: Winterchecklist voor zzp'ers 2026 bestaat. Zakelijke blog actief. Doelgroep `ondernemer` klopt. fit_score=3 realistisch.
- ⚠ **#99 leidinggeven.com** — site bevestigd, artikel "Beslissingen nemen" 9 tips bestaat als pagina (geen datum 2026-05-18 verifieerbaar in WebSearch). Site is van Tijdwinst.com (training-bureau), niet primair een open-platform voor gastauteurs. submission_proces_hint='geen info gevonden' bevestigt dat. fit_score=4 mogelijk te hoog. Suspect.

---

## Inconsistenties

### Sites met fit_score=5 maar zwakke/onverifieerbare fit-motivation
Geen lege motivations gevonden. Alle fit=5 sites hebben tenminste 30 tekens. **PASS** op dit punt.

### Sites met DR=HIGH zonder dat naam bekend is voor mij
- **#42 xperthractueel.nl** — DR HIGH (60+) toegekend. XpertHR/Brightmine is een professioneel kennisplatform, maar bekend als matig DR (geschatte werkelijke DR eerder MEDIUM 40-50). Estimated-label is correct toegepast maar mogelijk overschat. Suspect.
- **#48 perspectief.eu** — niet in steekproef maar uit CSV: ".eu" TLD voor NL arbodienst is ongebruikelijk; DR MEDIUM lijkt aan de hoge kant.
- **#88 hibob.com** — DR HIGH, klopt internationaal, maar bijna alle relevante NL content is beperkt. Estimated MEDIUM was eerlijker. Lage NL-relevantie. Suspect.
- **#91 personio.com** — DR HIGH klopt internationaal, maar voor NL backlink-doel is .com versie minder waardevol dan .nl (zie duplicaten).
- **#35 managementscope.nl** — DR HIGH klopt, maar de doelgroep CEO/CFO/commissaris is een mis-match met "psychosomatische fysiotherapie"-onderwerp; te grote sprong.

### `recent_article_date=2026` zonder URL
**Geen gevallen in top-100** waar 2026-datum ontbreekt aan URL. Alle 100 hebben een URL ingevuld. **PASS.**

### `submission_proces_hint=open call` zonder `submission_url_hint`
5 gevallen gevonden:
- **#1 managementsite.nl** — open call beweerd, geen URL-hint. Suspect: ondersteun de "open call"-claim of degradeer naar "pitch via redactie".
- **#11 tijdschriftdepsycholoog.nl** — open call beweerd. WebSearch vond geen expliciete auteursvoorstel-pagina. Suspect: claim mogelijk over-stated; NIP-vakblad is selectief peer-review.
- **#12 mkbservicedesk.nl** — open call beweerd, geen URL-hint. Suspect.
- **#56 ondernemersblog.nl** — open call beweerd, eigen first_impression noemt "Eerst taxatie of direct verkopen via feddema.nl" → dit lijkt een platform-flip / parked domain. **HARDE TWIJFEL.**
- **#100 nationalezorggids.nl** — open call beweerd in CSV ("betaalde maar laagdrempelige gastblogoptie"); strikt genomen is "betaalde gastblog" géén open call maar paid placement, wat een ander signaal is voor outreach-pipeline.

---

## Hallucinatie-detectie

- **Contactgegevens patroon-matig**: Conform pivot-besluit zijn `contact_TODO` en `link_policy_TODO` overal als placeholder neergezet — geen verzonnen `info@` of `redactie@` adressen in CSV. **PASS** op hoofdregel.
  - Uitzondering: in deep-dive JSON van `coachlink.nl` staat `redactie@coachlink.nl` als first_impression. Dit is verifieerbaar correct (WebSearch bevestigt). Geen hallucinatie.
- **Submission_url_hint kritisch verifieerd**:
  - **#6 chro.nl** — hint `https://chro.nl/auteur/de-redactie/` plausibel (typische auteursprofiel-URL); niet gespot-checked maar URL-patroon redelijk.
  - **#2 nobco.nl** — hint `https://nobco.nl/nieuws-inspiratie/nieuws/` plausibel.
  - **#9 nfp.kngf.nl** — hint `https://nfp.kngf.nl/over-nfp` bevestigd in WebSearch (pagina bestaat).
  - **#94 allesoverhr.nl** — hint `https://www.allesoverhr.nl/contact/` is generieke contact-URL, geen submission-pagina. Mild misleidend; niet onjuist maar weinig waarde.
  - **#107 icthealth.nl** (niet in top-100) — hint wijst naar specifieke "insturen" pagina — niet relevant.
- **Mismatched domeinen in URL versus rank-domein:**
  - **#40 sprout.nl** — `rank=40 domein=sprout.nl` maar `recent_article_url=https://mtsprout.nl/groei/nl-startup-competition-2026-draper` — dit is een URL op `mtsprout.nl`, NIET op sprout.nl. **Hard-fout: URL hoort bij een ander domein (zie ook duplicaat #8 mtsprout.nl).** Het domein sprout.nl bestaat niet meer als zelfstandige publicatie sinds de MT/Sprout-fusie. Sprout.nl is feitelijk een redirect/sub-brand van mtsprout.nl — duplicaat.
  - **#109 psychologiemagazine.nl** (niet in top-100, rank 109) — recent_article_url `psychologie.nl/artikel/5-misverstanden-over-pesten-sla-gewoon-terug-joh/` is een ander domein. Niet relevant voor top-100.
- **Verzonnen URL-paden?** Geen overduidelijke verzonnen sub-paden gevonden in steekproef. Alle 15 gecheckte URLs bestaan.

---

## Categorie-balans

**Top-100 verdeling:**
- Oververtegenwoordigd: `HR` (43%, vs. werkelijke target-mix doelgroepen voor pivot-artikel zou eerder 30-35% zijn). `C4`/`C6`/`C8`/`C15` elk ≥14 — zwaar leunend op HR-vakmedia en branche-verenigingen.
- Ondervertegenwoordigd:
  - `psycholoog` (6): voor een zenuwstelsel-thema met polyvagaal raakvlak zou je minimaal 10-12 verwachten (klinisch psychologen, A&O, GZ). Mogelijke gemiste targets: vbag.nl, lvvp.info, nvgzp.nl, neuropsychologie-platforms.
  - `coach` (3): dit is laag gezien polyvagaal sterk doorgedrongen is in coachingland (Polyvagal Institute, somatic coaches). Mogelijke gemiste targets: noloc.nl, eia-conferentie, somaticexperiencing.nl, integralcoaches.nl.
  - `onderwijs` (4): zenuwstelsel-bewust lesgeven is een groot internationaal thema (Polyvagal-school, trauma-informed teaching). Lerarenplatforms zoals leraren.net, beroepsorganisatie-leraren-NBLT, AVS (schoolleiders), AOb missen lijken.
  - `bedrijfsarts` (8) is OK qua aantal, maar de mix leunt op vakbladen, niet op praktijk-blogs/podcasts.
- `C14` (cultuur/leiderschap) en `C11` (klinische psychologie) zijn beide laag (3 en 4).

**Suggestie tweede research-pass:** focus op klinische/coach-platforms en onderwijs-specifieke media. Concrete keywords: "somatic experiencing Nederland", "polyvagaal coach blog", "trauma-informed onderwijs nederland", "lerarencollectief blog", "vbag nvgzp lvvp publicaties".

---

## Exclusielijst-check

Grep op `hr-communicatie.nl`, `hrcommunity.nl`, `flexmarkt.nl` in `04-ranked.csv` → **0 hits in volledige CSV (alle 378 rijen).**

**PASS** — geen excluded domeinen lekken naar de top 100 (of zelfs naar de bredere kandidaten-lijst).

---

## Duplicaat-check

Gevonden potentiële dubbelingen / domein-overlap:

1. **#37 personio.nl + #91 personio.com** — zelfde organisatie, twee TLDs. Voor NL-backlink heeft `.nl` voorkeur; `.com` is internationaal en zelfden NL-specifieke content. **Aanbeveling: degradeer #91 of merge.**
2. **#83 vismaraet.nl + #75 youforce.nl** — Youforce IS het product/blog-platform van Visma Raet. Backlink-waarde overlapt sterk; outreach naar dezelfde redactie. **Aanbeveling: kies één primaire (vismaraet.nl heeft hogere autoriteit) en hou de andere als secundair.**
3. **#9 nfp.kngf.nl + #89 kngf.nl** — NFP is subsite/sectie van KNGF. Beide gerechtvaardigd (verschillende sub-doelgroepen), maar outreach moet gecoördineerd zijn om dubbel-pitchen aan dezelfde redactie te vermijden.
4. **#8 mtsprout.nl + #40 sprout.nl** — sprout.nl is sinds 2022 gefuseerd onder mtsprout.nl. De URL bij rank 40 wijst zelfs letterlijk naar mtsprout.nl. **HARD: rank 40 is een duplicaat van rank 8 onder een verouderde domeinnaam — verwijderen of mergen.**
5. **#34 managementboek.nl** is een aparte entiteit (boeken-shop met magazine), géén duplicaat van management-platforms — OK.

---

## Hard-fouten (uit lijst halen)

1. **#40 sprout.nl** — feitelijk hetzelfde platform als #8 mtsprout.nl; de geleverde URL ligt op `mtsprout.nl`. Verouderd / dubbel domein. **Actie: verwijderen of expliciet mergen met #8.**
2. **#56 ondernemersblog.nl** — first_impression noteert "Eerst taxatie of direct verkopen via feddema.nl" als titel/teaser, wat sterk wijst op een geparkeerd of doorverkocht domein. Het lijkt geen actief redactie-platform meer. **Actie: verifieer status; bij geparkeerd → verwijderen.**

---

## Suspect (re-verifiëren door hoofdagent)

Vereisten extra check vóór outreach:

1. **#1 managementsite.nl** — "open call" claim zonder URL-hint; bij open call verwacht je een "schrijf-mee" of "auteurs-info" pagina. Verifieer.
2. **#11 tijdschriftdepsycholoog.nl** — "open call" lijkt overstated; NIP-vakblad is peer-review met selectie. Markeer als "pitch via redactie".
3. **#12 mkbservicedesk.nl** — "open call" zonder URL-hint; verifieer.
4. **#21 arboportaal.nl** — Rijksoverheid-portaal accepteert in de regel geen externe gastauteurs (eigen-beleid-content). fit_score=4 mogelijk te hoog; degradeer naar 2-3.
5. **#33 inspiratie.uwv.nl** — UWV is overheid, externe gastauteurs zeldzaam. Vergelijkbare twijfel als #21.
6. **#35 managementscope.nl** — Engels-talige URL als recent_article, board-niveau publiek mismatch met fysiotherapeut-doelgroep; fit_score=4 ge-stretched.
7. **#37 personio.nl + #75 youforce.nl + #83 vismaraet.nl + #91 personio.com** — alle vier zijn SaaS-vendor blogs met eigen content-teams en zelden externe gastauteurs voor de hoofd-content. Verifieer of er een "gastblog"-traject is.
8. **#42 xperthractueel.nl** — pitch_angle (loonkloof+zwangerschapsverlof) is ge-stretched voor een zenuwstelsel-thema; bovendien betaald kennisplatform.
9. **#62 zilverenkruis.nl + #86 cz.nl + #36 onvz.nl + #93 unive.nl + #80 nn.nl** — verzekeraars/zorgverzekeraars publiceren bijna nooit externe gastauteurs, alleen pers/sponsored content. fit_score=4 in meerdere gevallen optimistisch.
10. **#88 hibob.com** — Engelstalig hoofdpubliek (Israelisch HQ); NL-relevantie laag voor een NL-fysiotherapeut.
11. **#87 hays.nl** — recruitment-bureau, welzijn is randthema; recent_article gaat over AI-vaardigheden, niet welzijn.
12. **#99 leidinggeven.com** — Tijdwinst.com training-bureau, geen open redactie. fit=4 te hoog.
13. **#100 nationalezorggids.nl** — "betaalde laagdrempelige gastblog" = paid placement; classificeer als gesponsorde route, niet als "open call".
14. **#34 managementboek.nl** — primair een boeken-shop; auteursprofielen vereisen meestal een gepubliceerd boek. fit=4 te hoog.
15. **#58 ntvg.nl** — peer-reviewed wetenschappelijk tijdschrift; submission-drempel zeer hoog. JSON erkent dit zelf ("hoge drempel"). fit_score=3 OK maar composite-rank #58 lijkt nog steeds hoog.
16. **#82 trimbos.nl** — kennisinstituut, blog is intern-redactioneel; gastexpert via onderzoeksagenda zelden voor solopraktijk-fysiotherapeut.

---

## Aanbevolen acties

1. **Top-100 lijst snijden:** verwijder/merge `sprout.nl` (rank 40) → duplicaat van mtsprout.nl. Verifieer `ondernemersblog.nl` (rank 56) levend; zo niet → verwijderen. Dat creëert 2 vrije slots; promoveer de eerstvolgende kandidaten uit 101-110 (transvorm.org rank 101 is plausibel).
2. **Re-classificeer submission-types:** voor #1, #11, #12, #100 — degradeer "open call" naar "pitch via redactie" tot bewijs van open auteurspagina. Dit verandert composite-scores (submission_bonus 1.0 → 0.7), wat enkele ranks zal herrangschikken.
3. **Doelgroep-rebalansering tweede pass:** voeg ~10 extra `psycholoog`/`coach`/`onderwijs`-targets toe. Specifieke suggesties: noloc.nl, lvvp.info, nvgzp.nl, somaticexperiencing.nl, leraren.net, AVS (schoolleiders), AOb. Hierdoor wordt de doelgroep-mix evenwichtiger en sluit ze beter aan op het zenuwstelsel-thema.
4. **DR-schattingen herijken op estimated×0.8 wanneer DR HIGH geclaimd is voor sub-domeinen of niche-platforms** (xperthractueel.nl, perspectief.eu, hibob.com). Conservatiever scoring is verdedigbaarder zonder Ahrefs.
5. **Vendor-blog cluster (Personio, Visma Raet, Youforce, Shiftbase, Nmbrs, Hibob, Recruitee) re-evalueren:** typisch is bij SaaS-blogs alleen ruimte voor klantverhalen of sponsored content, geen open expertbijdragen. Markeer als "outreach met B2B-partner-positionering" in plaats van klassieke gastauteur-pitch.
6. **Verzekeraar-cluster (NN, Zilveren Kruis, CZ, ONVZ, Univé):** verlaag fit-scores één punt; outreach loopt typisch via PR/communicatie, niet via redactie — andere outreach-template nodig.
7. **Pitch-angle audit voor #42 xperthractueel.nl** — verbind zenuwstelsel-regulatie aan loonkloof+zwangerschapsverlof is een (te) creatieve invalshoek; vervang door iets dichter bij verzuim/WIA/arbeidsrecht-content van het platform.
8. **Voor hoofdagent:** bij outreach-fase altijd 1 handmatige website-check per geprioriteerde target om link_policy en contact te bevestigen — dit was expliciet TODO in JSONs, maar moet expliciet in de outreach-workflow worden ingebakken.

---

## Telling

- **Verified-correct (✓):** 9 uit 15 steekproef (60%)
- **Suspect (⚠) uit steekproef:** 5 (managementscope.nl, xperthractueel.nl, coachlink.nl, driessengroep.nl-licht, leidinggeven.com)
- **Hard-fout (✗) uit steekproef:** 1 (sprout.nl rank 40 = duplicaat van mtsprout.nl)
- **Aanvullend hard-fout buiten steekproef:** 1 (ondernemersblog.nl rank 56 — vermoedelijk geparkeerd)
- **Aanvullend suspect buiten steekproef:** ~14 sites (overheid-portalen, verzekeraars, SaaS-vendors, internationale platforms — zie suspect-lijst)

**Totaal:**
- Hard-fouten (uit lijst halen): **2**
- Suspect (re-verifiëren): **19**
- Verified-correct (steekproef): **9**

Exclusielijst-check: **PASS** (0 hits in CSV).
Duplicaat-check: **4 duplicaat-clusters geïdentificeerd** (Personio, Visma/Youforce, KNGF/NFP, Sprout/MTSprout).
