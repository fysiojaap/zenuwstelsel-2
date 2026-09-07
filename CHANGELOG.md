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
- **Status:** `geblokkeerd` — wacht op beslissing · agent zelfstandig

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
