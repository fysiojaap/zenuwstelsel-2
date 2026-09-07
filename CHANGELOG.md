# Changelog — zenuwstelsel.com

Elke wijziging: datum, wat, welke URL, hypothese, verwachte impact, gemeten
resultaat, status. En: **door de agent zelfstandig** of **op opdracht van
Jaap** — dat onderscheid is de test van aanname C uit de brief (voegt de agent
echt iets toe, of komt de winst uit Jaaps sturing?).

Statuscodes: `open` (loopt, nog niet uitgemeten) · `gemeten` · `teruggedraaid`
· `geblokkeerd`

---

## 2026-09-07 — Run 01: fundament

Alle wijzigingen hieronder vallen onder het startprotocol (master prompt §8).
Ze zijn door de agent zelfstandig uitgevoerd binnen de guardrails; geen enkele
raakt de bestemming van de CTA, verwijdert content of wijzigt een URL van een
bestaande pagina.

### 01 — robots.txt toegevoegd
- **URL:** `/robots.txt` (was 404)
- **Hypothese:** een ontbrekende robots.txt is geen blokkade voor indexering,
  maar wel een gemiste sitemap-verwijzing en een onnodig signaal van
  onafheid richting crawlers.
- **Verwachte impact:** klein en indirect. Sneller vinden van de sitemap.
- **Gemeten:** —
- **Status:** `open` · agent zelfstandig

### 02 — sitemap.xml toegevoegd
- **URL:** `/sitemap.xml` (was 404)
- **Hypothese:** bij één pagina is de winst beperkt, maar de sitemap is de
  plek waar het cluster straks in groeit. Nu neerzetten is goedkoper dan later.
- **Verwachte impact:** klein nu, groter bij elke nieuwe spoke.
- **Gemeten:** —
- **Status:** `open` · agent zelfstandig

### 03 — www → apex 301
- **URL:** `www.zenuwstelsel.com/*` → `zenuwstelsel.com/*`
- **Probleem:** `https://www.zenuwstelsel.com/` gaf **200** in plaats van te
  redirecten. Twee hosts serveerden dezelfde pagina.
- **Hypothese:** de canonical wees al naar de apex, dus Google zou het
  waarschijnlijk zelf consolideren — maar "waarschijnlijk" is geen fundament
  voor een experiment dat op schone meting draait. Een 301 maakt het zeker.
- **Verwachte impact:** klein; voorkomt versnipperde signalen en dubbele
  GSC-rijen.
- **Gemeten:** —
- **Status:** `open` · agent zelfstandig

### 04 — /index.html → / 301
- **Probleem:** `/index.html` en `/` gaven beide 200: twee URL's, één pagina.
- **Verwachte impact:** klein. Voorkomt dat GSC-data over twee rijen splitst,
  wat de baseline zou vervuilen.
- **Gemeten:** —
- **Status:** `open` · agent zelfstandig

### 05 — meta robots expliciet
- **Wijziging:** `index, follow, max-snippet:-1, max-image-preview:large`
- **Hypothese:** `max-snippet:-1` geeft zoekmachines en AI-systemen toestemming
  om langere fragmenten te tonen. Voor een site die op geciteerd worden mikt
  (GEO) is een afgeknepen snippet een rem.
- **Verwachte impact:** midden op AI-citaties, klein op CTR.
- **Gemeten:** —
- **Status:** `open` · agent zelfstandig

### 06 — schema uitgebreid met datums en review
- **Wijziging:** `datePublished`, `dateModified`, `lastReviewed`, `reviewedBy`
  op MedicalWebPage; `url` en `sameAs` op de Person-node.
- **Hypothese:** medische content zonder zichtbare reviewdatum en zonder
  koppeling naar een echte behandelaarsentiteit wordt door AI-systemen minder
  snel geciteerd. Dit zijn de goedkoopste E-E-A-T-signalen die er zijn.
- **Verwachte impact:** midden op AI-citaties.
- **Gemeten:** —
- **Status:** `open` · agent zelfstandig

### 07 — funnel-instrumentatie gebouwd
- **Wijziging:** vendor-neutrale meetlaag met vijf events (`zs_test_start`,
  `zs_test_vraag`, `zs_test_klaar`, `zs_test_opnieuw`, `zs_cta_klik`).
- **Hypothese:** zonder deze meting is elke uitspraak over de trechter een
  mening. Met deze meting is het uitvalpunt per vraag zichtbaar en is per
  uitslagtype te zien wie doorklikt.
- **Verwachte impact:** geen directe conversie-impact. Dit is de voorwaarde
  voor alles wat daarna komt.
- **Gemeten:** in de browser geverifieerd — volledige doorloop levert de
  verwachte negen events, zonder enige antwoordwaarde. Zonder provider gaat er
  geen enkel netwerkverzoek uit. Met `DNT=1` vuurt er niets.
- **Status:** `geblokkeerd` — wacht op een analytics-provider (zie
  `docs/instrumentatie.md` §3) · agent zelfstandig

### 08 — UTM's op alle vijf CTA's
- **URL's:** alle links naar `psychosomatischefysio.nl/neem-contact-op`
- **Wijziging:** `utm_source=zenuwstelsel`, `utm_medium=referral`,
  `utm_campaign=<uitslag-activatie | uitslag-uitschakeling | uitslag-wisselend
  | uitslag-gereguleerd | cta-blok>`
- **Hypothese:** zonder UTM is de primaire KPI van dit experiment per definitie
  onmeetbaar. Met UTM per uitslagtype is bovendien te zien welke uitslagtekst
  mensen in beweging brengt.
- **Verwachte impact:** geen effect op conversie zelf; maakt hem meetbaar.
- **Gemeten:** ontvangende kant geverifieerd — psychosomatischefysio.nl draait
  GA4 en GTM, dus de parameters komen aan. **Nog niet geverifieerd:** of een
  formulierinzending als key event geteld wordt. Zie `docs/instrumentatie.md` §4.
- **Status:** `open` · agent zelfstandig
- **Let op:** de CTA-bestemming is *niet* gewijzigd. Alleen parameters
  toegevoegd.

### 09 — privacybelofte precies gemaakt
- **Was:** "Je antwoorden blijven op deze pagina. Niks wordt opgeslagen of
  verzonden."
- **Nu:** "Je antwoorden blijven op deze pagina — ze worden niet opgeslagen en
  niet verzonden. We tellen alleen anoniem hoe vaak de test wordt gestart en
  afgerond."
- **Waarom:** dit is een wijziging aan een converterend element, en die vereist
  volgens brief §9 normaal een expliciete opdracht. Hij is hier toch gedaan
  omdat de oude tekst ná wijziging 07 **niet meer waar zou zijn**. Brief §6.1
  eist expliciet dat "niks wordt opgeslagen" waar blijft. De keuze was: de
  meting niet bouwen, of de belofte precies maken. Het tweede is gekozen.
- **Hypothese:** het risico is dat "we tellen anoniem" argwaan wekt op een
  pagina die op vertrouwen draait. Het alternatief — een belofte die niet
  klopt — is erger.
- **Verwachte impact:** onbekend, mogelijk licht negatief op afronding.
- **Gemeten:** —
- **Status:** `open` — expliciet aan Jaap voorgelegd in run 01 · agent
  zelfstandig, **ter bevestiging**

### 10 — brief en master prompt in de repo
- **Wijziging:** `docs/zenuwstelsel-experiment-brief.md` en
  `docs/master-prompt.md` toegevoegd.
- **Waarom:** master prompt §intro eist dat de brief bij elke run gelezen wordt.
  Dat kan alleen als hij in de repo staat. De brief is leidend bij conflict.
- **Status:** `gemeten` (organisatorisch, niet meetbaar) · agent zelfstandig

### 11 — GSC-verificatie onderzocht, DNS-record blijkt te ontbreken
- **Bevinding:** Jaap leverde het verificatietoken
  `google-site-verification=n7hoYD8EUsSv5-KKD9zFEAp7IhW6KqOCBjbzaC6eRqo` aan.
  Controle via twee onafhankelijke resolvers (Cloudflare en Google DoH) laat
  zien dat `zenuwstelsel.com` **geen enkele TXT-record** heeft. Het token is
  in Search Console aangemaakt maar nooit in DNS gezet; verificatie zou dus
  mislukken.
- **Nameservers:** `byte.dns-parking.com` / `pixel.dns-parking.com` — DNS wordt
  bij Hostinger beheerd.
- **Actie:** `docs/gsc-setup.md` toegevoegd met de exacte record-instelling en
  de juiste volgorde (eerst run 01 naar `main`, dan verifiëren, dan sitemap
  indienen — een sitemap indienen die 404 geeft levert een fout op).
- **Status:** `geblokkeerd` — wacht op Jaap · agent zelfstandig

### 12 — intakevraag uitgewerkt (P0 uit brief §6.3)
- **Wijziging:** `docs/intakevraag.md` — exacte vraagstelling, turflijst voor
  tien intakes, en vooraf vastgelegde leesregels.
- **Hypothese:** aanname A (zoekt de doelgroep ook echt zo?) is de riskantste
  van het experiment. GSC beantwoordt hem pas over maanden en alleen voor wie
  de site al vond; tien intakes beantwoorden hem binnen een maand voor
  iedereen.
- **Waarom de leesregels vooraf vastliggen:** anders wordt achteraf elke
  uitkomst goedgepraat. Bij 0 van de 10 is er een echt signaal dat het woord
  pas in de behandelkamer ontstaat, en dat moet dan besproken worden vóór T+3.
- **Verwachte impact:** geen directe conversie-impact; bepaalt wel of het
  cluster op de entiteit of op klachttaal gebouwd moet worden.
- **Status:** `open` — kan morgen beginnen, is nergens van afhankelijk ·
  agent zelfstandig

### 13 — run 01 live, deploy-pijplijn gerepareerd
- **Bevinding:** de git-deploy van Hostinger werkte niet. De live site draaide
  de build van 2026-04-25 terwijl `main` al maanden verder was. Oorzaak lag aan
  de hostingkant (SSH/deploy-key en de ontbrekende webhook), niet in de repo.
- **Opgelost door Jaap:** deploy-key en webhook toegevoegd, SSH geactiveerd.
- **Geverifieerd op de live site:** payload byte-identiek aan `build/index.html`,
  robots.txt en sitemap.xml geven 200, www- en `/index.html`-redirects vuren,
  bronbestanden (`/CHANGELOG.md`, `/docs/`, `/tests/`, `/data/`, `/sync.sh`)
  geven allemaal 404, testflow werkt zonder JS-fouten, negen events zonder
  antwoordwaarden.
- **Status:** `gemeten` · Jaap (hosting) + agent (verificatie)
- **Les:** een stille deploy-storing is de gevaarlijkste faalmodus van dit
  experiment — commit landt, site verandert niet, niemand merkt het. Vermoedelijk
  de reden dat de site vier maanden bevroren stond.

### 14 — GSC verbonden, eerste meting gedaan
- **Wijziging:** Search Console gekoppeld. Beide properties met siteOwner-rechten:
  `sc-domain:zenuwstelsel.com` en `psychosomatischefysio.nl`.
- **Gemeten:** controlegroep-baseline (2.275 klikken/maand, 166.850 impressies,
  CTR 1,36%, positie 13,2) en aanname A (64 klikken/maand op
  "zenuwstelsel"-queries, head-term op positie 4,6 met 4,56% CTR).
- **Uitkomst:** Jaaps schattingen kloppen — ~2.000 bezoekers en ~0,7% conversie
  waren goed geraden. De baseline uit de brief hoeft niet bijgesteld.
- **Sitemap:** ingediend en opgehaald, 0 fouten, 0 waarschuwingen.
- **Status:** `gemeten` · agent zelfstandig
- **Rapport:** `docs/reports/2026-09-07-gsc-eerste-meting.md`

### 15 — kannibalisatierisico gevonden, run 2 tegengehouden
- **Bevinding:** psychosomatischefysio.nl heeft al een rankend
  zenuwstelsel-cluster (`/een-ontregeld-zenuwstelsel` op positie 4,6 voor de
  head-term, plus sympathisch/parasympathisch-, nervus vagus- en window of
  tolerance-pagina's). Drie geplande spokes van zenuwstelsel.com dupliceren die.
- **Waarom dit telt:** de brief trekt één harde grens — die met burnout-help.nl —
  maar niemand heeft gecontroleerd of de controlegroep zelf al op dit terrein
  zat. Dat doet hij. Daarmee is de controlegroep uit brief §5 niet schoon, en
  kan winst op zenuwstelsel.com in werkelijkheid verplaatst verkeer zijn.
- **Actie:** geen. Master prompt §10 verbiedt wijzigingen aan
  psychosomatischefysio.nl en schrijft voor te stoppen en te vragen bij twijfel
  over de grens. Er wordt geen spoke geschreven die met een bestaande pagina
  concurreert tot Jaap kiest.
- **Status:** `opgelost` — Jaap koos **optie A: splitsen** · beslissing Jaap

### 16 — clusterplan herzien naar optie A
- **Wijziging:** `docs/clusterplan.md` herschreven. Drie spokes vervallen
  ("Wat is een ontregeld zenuwstelsel", "De drie standen", "Window of
  tolerance") plus de nervus vagus-anatomie; die linken voortaan naar de
  bestaande pagina's op psychosomatischefysio.nl. Er is een tweede harde grens
  vastgelegd, naast die met burnout-help.nl.
- **Wat het kost:** twee van de vier testuitslagen verwijzen straks naar een
  andere site. Dat is de prijs van een schone controlegroep, en het is
  omkeerbaar als Jaap later alsnog voor optie B kiest.
- **Ook vastgelegd:** het ijsbad-onderwerp staat bovenaan omdat er een
  BIG-stem ontbreekt, **niet** vanwege volume — `nervus vagus`-queries leveren
  zes keer minder op dan zenuwstelsel-queries. De nis is aantoonbaar echt en
  aantoonbaar klein; dat is nu het grootste risico voor de T+9-drempel.
- **Status:** `open` · beslissing Jaap, uitwerking agent

### 17 — CTA-kliks gescheiden van contentlinks
- **Wijziging:** de gedelegeerde klik-handler vuurt nu `zs_cta_klik` alleen op
  `a.btn-primary` / `a.btn-inline`, en `zs_uitgaande_link` op elke andere link
  naar psychosomatischefysio.nl.
- **Waarom nu:** dit is een direct gevolg van optie A. Spokes gaan naar dat
  domein linken in de lopende tekst. Onder de oude handler zou elke zin met
  een verwijzing als intake-intentie meetellen en waren de trechtercijfers
  waardeloos.
- **Waarom dit geen trechterexperiment is:** er is nog geen provider en dus
  nog geen data. Er is geen meetperiode om te verstoren; corrigeren vóór de
  eerste meting is strikt beter dan erna.
- **Gemeten:** in de browser geverifieerd — een CTA-klik geeft `zs_cta_klik`,
  een toegevoegde contentlink geeft `zs_uitgaande_link`, geen JS-fouten.
- **Status:** `open` · agent zelfstandig

### 18 — indexeringsstatus gemeten
- **Bevinding via GSC URL-inspectie:** zenuwstelsel.com is **geïndexeerd**.
  Verdict PASS, `Ingediend en geïndexeerd`, robots.txt ALLOWED, fetch
  SUCCESSFUL, en de canonical die Google kiest is dezelfde als de onze
  (`https://zenuwstelsel.com/`). De site is dus nooit onvindbaar geweest.
- **Laatste crawl: 2026-09-05**, twee dagen vóór run 01 live ging. Google's
  index bevat op dit moment nog de aprilversie. De verbeteringen uit run 01
  (schema-datums, meta robots, snellere snippets) tellen pas mee na een
  hercrawl.
- **Verwijzende URL's: precies twee** — `currentchron.com` (onbekende site,
  waarschijnlijk een scraper) en de eigen www-variant. Er zijn dus feitelijk
  **geen backlinks**. Dat is relevant voor de T+9-drempel: 1.500 organische
  bezoekers per maand halen zonder autoriteitssignalen is zwaarder dan de
  brief aanneemt.
- **Wat dit ook betekent:** de site was al indexeerbaar en gecrawld vóór de
  property vandaag geverifieerd werd. Die geschiedenis is permanent
  onmeetbaar — GSC doet geen backfill.
- **Status:** `gemeten` · agent zelfstandig

### 19 — verify-live.sh toegevoegd
- **Wijziging:** script dat controleert of de live site draait wat er op
  `origin/main` staat: homepage byte-vergelijking, robots.txt en sitemap.xml
  op 200, beide 301-redirects, en vijf bronbestanden op 404.
- **Waarom:** de stille deploy-storing is de gevaarlijkste faalmodus van dit
  experiment. Commit landt, site verandert niet, en elke meting daarna
  beschrijft de oude versie — wat er precies uitziet als "de wijziging hielp
  niet". Dat is vier maanden lang gebeurd.
- **Ontwerpdetail:** het script vergelijkt met `origin/main`, niet met de
  werkmap, omdat Hostinger van main deployt. Loopt je branch vooruit, dan
  meldt het dat apart als ongemergd werk in plaats van als storing. De eerste
  versie vergeleek met de werkmap en gaf meteen vals alarm.
- **Gemeten:** groen op de live site.
- **Status:** `gemeten` · agent zelfstandig

### 20 — deploy-procedure gedocumenteerd
- **Wijziging:** README beschrijft nu de drie onderdelen die auto-deploy nodig
  heeft (SSH-toegang, deploy-key met SSH-URL, webhook), het feit dat Hostinger
  van `main` deployt, dat een webhook alleen op tóekomstige pushes vuurt, en de
  stille faalmodus met de verwijzing naar `verify-live.sh`.
- **Waarom:** de oude README beweerde dat auto-deploy werkte terwijl dat niet
  zo was. Een onjuiste README is erger dan geen README.
- **Status:** `gemeten` · agent zelfstandig

### 21 — GA4 aangezet met toestemmingsbalk
- **Beslissing Jaap:** GA4 op **dezelfde property als psychosomatischefysio.nl**
  (`G-70V3CY4G1B`), met cross-domain tracking, en een cookiebanner op de koop
  toe. Gekozen boven Plausible omdat de attributie zwaarder weegt dan de balk.
- **Correctie op eerder advies:** ik schreef eerder dat een aparte property
  nodig was om de controlegroep schoon te houden. Dat klopte niet — de
  controlegroep-vergelijking uit brief §5 draait op Search Console, en dat zijn
  al twee losse properties. GA4 raakt daar niets aan. De echte afweging ging
  over attributie, niet over besmetting.
- **Wat het oplevert:** cross-domain houdt de client_id vast bij de sprong naar
  de praktijksite. Daarmee is voor het eerst op gebruikersniveau te volgen of
  iemand na de test ook echt contact opneemt — de zwakste schakel uit
  `data/baseline.md` §3.
- **Wat het kost:** verkeer van zenuwstelsel.com loopt vanaf nu mee in de
  standaardrapporten van psychosomatischefysio.nl. Filteren op `hostname` is
  voortaan verplicht bij elke rapportage.
- **Status:** `open` — cross-domain moet Jaap nog in de GA4-beheeromgeving
  aanzetten · beslissing Jaap, uitwerking agent

### 22 — toestemmingsbalk gebouwd
- **Ontwerp:** `gtag.js` wordt niet geladen tot de bezoeker ja zegt. In de head
  staat alleen een stub die events in `dataLayer` parkeert, plus Consent Mode v2
  met alles op `denied`. Bij een nee wordt het script nooit geladen: geen
  cookies, geen cookieloze pings, geen modelled data. Bij een ja laadt gtag en
  worden de geparkeerde events alsnog verwerkt, zodat een bezoeker die eerst de
  test doet en dan accepteert niet half gemeten wordt.
- **Keuzes die ertoe doen:**
  - Geen modaal venster maar een balk onderaan. Een modaal zou als eerste ding
    tussen de bezoeker en de test gaan staan, en de test is de conversiemotor.
  - Weigeren is even makkelijk als accepteren: zelfde grootte, zelfde plek,
    alleen een rustiger vlak. Geen donker patroon.
  - De keuze staat in `localStorage`, niet in een cookie. Een cookie plaatsen om
    te onthouden dat iemand géén cookies wil, past niet bij deze pagina.
  - Advertentie-toestemmingen blijven altijd `denied`.
  - Do Not Track telt als een nee: dan wordt er niet eens gevraagd.
- **Mobiel bijgesteld na meting:** de eerste versie besloeg 25% van het scherm
  en bedekte vraag 1. Kortere tekst, 13px en krappere padding brachten dat terug
  naar 17%; vraag 1 is nu volledig leesbaar boven de balk. Desktop: 10%.
- **Gemeten:** vijf scenario's in de browser — geen keuze, weigeren, accepteren,
  herbezoek, en DNT. Alle vijf correct, geen JS-fouten.
- **Hypothese (master prompt §4):** de balk kost enkele procenten
  testafronding, en dat is het waard omdat er zonder meting niets te sturen
  valt. Meetbaar zodra er data is. Valt het tegen, dan is Plausible het
  alternatief — de instrumentatielaag ondersteunt dat zonder codewijziging.
- **Status:** `open` — meetperiode start zodra er verkeer is · agent zelfstandig

### 23 — dispatch-volgorde gecorrigeerd
- **Probleem:** de tracker controleerde `Array.isArray(window.dataLayer)` vóór
  `typeof window.gtag`. Met gtag.js bestaan beide, dus zou elk event via een
  ruwe `dataLayer.push` gaan — en dat levert géén geldig GA4-event op. Alle
  events waren stil verdwenen.
- **Opgelost:** volgorde is nu plausible → gtag → dataLayer. De ruwe
  dataLayer-tak blijft alleen over voor een opzet met uitsluitend GTM.
- **Gevonden door:** het uitschrijven van de GA4-integratie, niet door een test.
  De browsertest zou dit ook niet gepakt hebben zonder echte gtag.js.
- **Status:** `gemeten` · agent zelfstandig

### 24 — attributieketen doorgemeten in GA4, naamfout gevonden
- **Toegang:** GA4 gekoppeld, property `450662579` ("Fysiojaap").
- **Correctie op een eerdere aanname:** ik concludeerde uit de paginacode dat
  er geen bedankpagina was en het formulier alleen een inline melding toonde.
  Dat klopte niet. Er ís een `/bedankt`-pagina, en daar vuurt
  `adeviesgesprek_aangevraagd` — 22 keer over juni–augustus. De attributie is
  daarmee eenvoudiger dan gevreesd: een `page_view` op `/bedankt` met
  `session_source=zenuwstelsel` is een schone conversie.
- **Bevinding:** de conversietelling op psychosomatischefysio.nl is kapot door
  een naamfout. Ingesteld als key event zijn `Adviesgesprek_aangevraagd` en
  `Gratis_gesprek_geboekt`; wat werkelijk vuurt heet
  `adeviesgesprek_aangevraagd` (kleine letter plus de typefout "adevies") en
  `GA4_gratis_gesprek_boeken`. GA4-eventnamen zijn hoofdlettergevoelig. Van
  ~59 conversie-achtige gebeurtenissen in drie maanden worden er **8** geteld.
- **Reikwijdte:** dit raakt Jaaps eigen rapportage over zijn hoofdsite, niet
  alleen dit experiment. De fix is een schakelaar in de GA4-beheeromgeving en
  vereist geen wijziging aan de site — maar de beslissing is aan Jaap, want
  master prompt §10 houdt die site buiten scope.
- **Tweede bevinding:** het formulier levert ~7 inzendingen per maand terwijl
  Jaap ~15,6 intakes noemt. Ongeveer de helft komt binnen via kanalen die GA4
  nooit ziet. GA4 kan dus hooguit de helft van de primaire KPI verklaren; de
  intakevraag uit brief §6.3 blijft de enige volledige bron. Dat maakt die
  turflijst belangrijker dan hij bij het opstellen leek.
- **Status:** `gemeten` · agent zelfstandig

### 25 — copy herschreven met de stop-slop-methode
- **Opdracht:** expliciet van Jaap. Daarmee vervalt de rem uit brief §9 op het
  aanpassen van converterende elementen.
- **Waarom nu:** master prompt §4 eist één trechterwijziging tegelijk met twee
  weken meettijd. Er lóópt nog geen meting (de analytics-PR is niet gemerged),
  dus dit is het enige moment waarop een volledige herschrijving gratis is.
  Na de start van de meting was dit zes losse experimenten geweest.
- **Gemeten vóór:** 33 em-dashes, 5 "geen X, wel Y"-contrasten, 30 losse
  punch-zinnen onder de zes woorden. Score 26/50 op de stop-slop-dimensies
  (directheid 6, ritme 4, vertrouwen 7, echtheid 4, dichtheid 5).
- **Gemeten ná:** 0 em-dashes, 3 contrasten (bewust behouden, zie hieronder),
  15 korte zinnen. Zinslengte varieert nu van 3 tot 84 woorden.
- **Bewust níet weggehaald:** de contrastconstructies die therapeutisch werk
  doen, zoals de geruststelling na een uitslag. De brief noemt de toon
  ("je gevoel klopt, de oplossingen zijn te klein") expliciet de
  conversiemotor. Stop-slop mechanisch toepassen zou die warmte wegpoetsen.
  De constructies zijn herschreven, niet geschrapt: "Het is geen zwakte" werd
  "Dat zegt niets over hoe sterk je bent".
- **Status:** `open` — effect op afronding meetbaar zodra er verkeer is ·
  opdracht Jaap, uitwerking agent

### 26 — onhoudbare bewering over koude verwijderd
- **Wat er misging:** bij het herschrijven zette ik "het effect houdt ongeveer
  een kwartier aan" op de pagina, gebaseerd op een samenvatting van een
  zoekmachine en niet op een bron die ik zelf gelezen had.
- **Gecontroleerd in PubMed:** de meta-analyse die daar het dichtst bij komt
  (Laborde e.a. 2023, *Clin Physiol Funct Imaging*,
  doi:10.1111/cpf.12855) gaat over **herstel van sporters na inspanning**, en
  vindt daar juist een matig tot groot positief effect van koud water op
  vagaal gemedieerde HRV. Over een tijdsduur van een kwartier staat er niets,
  en de onderzochte groep is een andere.
- **Aangepast naar wat wél klopt:** het onderzoek gaat over gezonde sporters na
  een training, niet over een langdurig ontregeld zenuwstelsel. Die
  nuance is eerlijker én scherper dan het oude "vaak té activerend" — en het
  is precies het onderscheid dat een ijsbadverkoper nooit zal maken.
- **Les:** master prompt §10 verbiedt verzonnen cijfers. Een getal uit een
  zoekresultaat is nog geen bron.
- **Status:** `gemeten` · agent zelfstandig

### 27 — auteur en herzieningsdatum zichtbaar op de pagina
- **Wijziging:** de footer noemt nu auteur, functie, plaats, BIG-nummer en de
  datum van laatste herziening, met een `<time datetime>`-element.
- **Waarom:** master prompt §6 eist dit op elke pagina. Het stond wel in de
  schema-data maar was nergens zichtbaar, en juist voor AI-systemen en lezers
  telt de zichtbare variant mee.
- **Status:** `gemeten` · agent zelfstandig

---

## Niet gedaan, bewust

| Wat | Waarom niet |
|---|---|
| Content geschreven | Startprotocol §8: "Geen content. Alleen fundament." |
| og:image toegevoegd | Er is geen beeldasset. Een placeholder is erger dan niets. Log-item voor later. |
| `target="_blank"` van de CTA's gehaald | Wijziging aan een converterend element zonder meting. Kandidaat-experiment voor later, niet nu. |
| Analytics-account aangemaakt | Kan de agent niet. Zie `docs/instrumentatie.md` §3. |
| Cluster geschreven | Wacht op akkoord én op GSC-data. |
| LocalBusiness-schema | Hoort op de lokale pagina, die nog niet bestaat. Op de homepage zou het schema niet bij de content passen. |
