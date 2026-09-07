# Google Search Console — opzetten

**Status op 2026-09-07: niet geverifieerd. De DNS-record ontbreekt.**

GSC is de bron van waarheid voor verkeer in dit experiment (master prompt §1:
"Als GSC het niet laat zien, is het niet gebeurd"). Zonder GSC kan run 2 niet
zinvol beginnen.

---

## Wat er aan de hand is

Jaap heeft dit verificatietoken uit Search Console:

```
google-site-verification=n7hoYD8EUsSv5-KKD9zFEAp7IhW6KqOCBjbzaC6eRqo
```

Dat is het token voor een **domeinproperty**, die via een DNS TXT-record
geverifieerd wordt. Gecontroleerd op 2026-09-07 via twee onafhankelijke
resolvers (Cloudflare en Google):

```
zenuwstelsel.com  TXT  ->  geen enkel record
```

Beide antwoorden bevatten alleen een SOA-record en geen Answer-sectie. Het
domein bestaat, de nameservers antwoorden, maar er staat **geen enkele
TXT-record** in de zone. Het token is dus wel aangemaakt in Search Console,
maar nooit in DNS gezet. Verificatie zal daarom mislukken.

Nameservers: `byte.dns-parking.com` en `pixel.dns-parking.com` — de DNS wordt
dus bij **Hostinger** beheerd, niet bij een aparte registrar.

---

## Wat Jaap moet doen

### Stap 1 — TXT-record toevoegen bij Hostinger

In hPanel: **Domeinen → zenuwstelsel.com → DNS / Nameservers → DNS-records
beheren**. Voeg toe:

| Veld | Waarde |
|---|---|
| Type | `TXT` |
| Naam / Host | `@` (of leeg — dit is de root van het domein, niet `www`) |
| TTL | 3600 (of de standaard) |
| Waarde / Content | `google-site-verification=n7hoYD8EUsSv5-KKD9zFEAp7IhW6KqOCBjbzaC6eRqo` |

Let op twee dingen die vaak misgaan:
- De naam moet `@` zijn, niet `zenuwstelsel.com` en niet `www`. Sommige panelen
  vullen het domein automatisch aan; typ je het er zelf bij, dan krijg je
  `zenuwstelsel.com.zenuwstelsel.com` en werkt het niet.
- De waarde is de **hele string** inclusief `google-site-verification=`, zonder
  aanhalingstekens er zelf omheen te zetten.

### Stap 2 — wachten op propagatie

Meestal 5 tot 30 minuten. De TTL van de zone staat op 600 seconden, dus lang
duurt het niet.

### Stap 3 — verifiëren in Search Console

Terug in GSC op "Verifiëren" klikken. Daarna duurt het nog enkele dagen voordat
er data in staat — GSC begint pas te verzamelen vanaf het moment van
verificatie en loopt bovendien twee tot drie dagen achter.

### Stap 4 — sitemap indienen

Zodra de property geverifieerd is: **Sitemaps → `sitemap.xml` toevoegen**.
Die staat klaar in de repo maar is nog niet live (zie hieronder).

### Stap 5 — de agent toegang geven

Autoriseer de koppeling zodat de agent GSC kan uitlezen. Vraag er in de sessie
om; de link is tien minuten geldig, dus hij wordt op het moment zelf gemaakt.

---

## Volgorde is belangrijk

Er zit een afhankelijkheid in die makkelijk over het hoofd te zien is:

1. **Run 01 moet eerst live** — `sitemap.xml` en `robots.txt` staan nu alleen
   op de branch `claude/new-session-c7kngq`, nog niet op `main`. Hostinger
   deployt van `main`. Op de live site geeft `/sitemap.xml` nog steeds 404.
2. **Dan pas sitemap indienen** in GSC. Een sitemap indienen die 404 geeft
   levert een fout op in GSC en moet je later opnieuw doen.

Dus: eerst mergen naar `main`, dan verifiëren, dan sitemap indienen.

---

## Controle achteraf

Of de TXT-record live is, is van buitenaf te controleren:

```sh
curl -s "https://dns.google/resolve?name=zenuwstelsel.com&type=TXT"
```

Zodra er een `Answer`-sectie in het antwoord staat met het token erin, is de
record gepubliceerd. Zolang er alleen een `Authority`-sectie staat, is hij er
nog niet.
