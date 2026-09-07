# zenuwstelsel.com

A one-minute self-test and resource about vagus nerve / nervous-system
dysregulation. Single-file static site: `index.html`.

## Deploy

The site is hosted on **Hostinger**, which pulls this repo into the domain's
docroot. The `.htaccess` at the repo root internally rewrites every request
into the `build/` subdirectory, so visitors only ever see the production
payload — source files at the root, `tests/`, `docs/`, and `data/` all 404.

**Hostinger deploys from `main`, not from your branch.** A push to a feature
branch changes nothing on the live site until it's merged.

### How auto-deploy actually works here

Three pieces have to be in place. Two of them were missing until 7 September
2026, which is why the live site sat frozen on the 25 April build for four
months while `main` moved on:

1. **SSH access** enabled in hPanel → Advanced → SSH Access.
2. **A deploy key** on the GitHub repo (Settings → Deploy keys), holding the
   public key Hostinger generates. Read-only; the repo is private, so without
   this the pull is unauthorised. Hostinger's git config must use the SSH URL
   (`git@github.com:fysiojaap/zenuwstelsel-2.git`) — with the HTTPS URL the key
   is never consulted.
3. **A webhook** on the GitHub repo (Settings → Webhooks) pointing at the
   deploy URL from hPanel → Advanced → GIT, content type `application/json`,
   push events only. This is what tells Hostinger *when* to pull.

The webhook URL is effectively a password — anyone holding it can trigger a
deploy. Keep it out of this repo.

A webhook only fires on **future** pushes. To deploy a commit that already
landed, press Deploy in hPanel or use Redeliver under the webhook's Recent
Deliveries.

### The failure mode to watch for

A broken deploy is silent. The commit lands, CI says nothing, the site simply
doesn't change — and every measurement after that describes the old version.
This is the most dangerous thing that can go wrong in this experiment, because
it looks exactly like "the change didn't help".

After any deploy, run:

```sh
./verify-live.sh
```

It compares the live homepage against `build/index.html` as it exists on
`origin/main`, checks that `robots.txt` and `sitemap.xml` return 200, that the
www and `/index.html` redirects fire, and that no source file is reachable. It
also tells you when your working tree is ahead of `main`, so an unmerged branch
doesn't read as an outage.

To ship a change:

1. Edit the source files at the repo root (`index.html`, `favicon.svg`,
   `robots.txt`, `sitemap.xml`).
2. Run `./sync.sh` to mirror them into `build/`. Forgetting this is the
   classic failure: the commit lands, the live site doesn't change.
   `./sync.sh --check` fails if `build/` is behind.
3. Commit, push, and merge to `main`.
4. Hostinger's webhook fires and it redeploys.
5. Run `./verify-live.sh` to confirm the live site actually changed.

If a change doesn't appear on the live site after a deploy, hard-refresh
the browser (Ctrl/Cmd + Shift + R) — Hostinger and the browser both
cache static assets.

### Repo layout

```
.htaccess        — Apache: canonical 301s, then rewrite into build/
sync.sh          — mirrors source files into build/
verify-live.sh   — checks the live site matches origin/main
index.html       — source-of-truth markup (edit here)
favicon.svg      — source-of-truth icon
robots.txt       — source-of-truth
sitemap.xml      — source-of-truth
build/           — deployed copy of the four files above (served by Hostinger)
tests/           — local-only, not deployed
data/            — baseline and AI-query measurements, not deployed
docs/            — brief, master prompt, plans, run reports; not deployed
CHANGELOG.md     — every change: hypothesis, expected impact, measured result
```

The whole production payload is just two files. No CSS/JS bundles, no
fonts, no external images — every visual asset is inlined in
`index.html` (CSS in `<style>`, SVGs as inline `<svg>`).

`build/` is a hand-mirrored copy of the source files at the repo root —
there is no compile step or build script. The mirror exists so that the
`.htaccess` rewrite has a clean directory to point at, isolated from
tests, docs, and git internals.

## Tests

Tests are not deployed. Open `tests/scoring.test.html` in a browser
locally. All 17 scoring cases should show green "✓" — covers all four
result paths (activatie, uitschakeling, wisselend, gereguleerd) and edge
cases.

## Edit content

- Questions, options, result copy, FAQ → inline HTML inside `index.html`.
- Scoring rules → JS block at the end of `index.html`, AND the test
  harness. Change both; then re-run `tests/scoring.test.html`.
- Visual tokens → CSS custom properties in the `:root` block near the top
  of `index.html`.

## External link and attribution

The primary CTA and all four result CTAs point at
`https://www.psychosomatischefysio.nl/neem-contact-op` (external intake).
Each carries UTM parameters with a campaign per result type, so the receiving
GA4 can tell which result copy actually moves people. Do not strip them —
without UTMs the experiment's primary KPI is unmeasurable.

## Measurement

The funnel is instrumented but **dormant**: it needs an analytics provider on
the page before anything is counted. See `docs/instrumentatie.md` for what is
measured (behaviour, never answers) and how to switch it on.

## The experiment

This site is a time-boxed experiment with a decision point in June 2027, run by
an agent against a written brief. Read these before changing anything:

- Brief (leading; wins over the master prompt on conflict):
  `docs/zenuwstelsel-experiment-brief.md`
- Master prompt for the agent: `docs/master-prompt.md`
- Cluster plan: `docs/clusterplan.md`
- Instrumentation and attribution: `docs/instrumentatie.md`
- Search Console setup (blocked on a missing DNS record): `docs/gsc-setup.md`
- The intake question that tests the riskiest assumption: `docs/intakevraag.md`
- Run reports: `docs/reports/`

Hard rule from the brief: once burn-out or overspanning becomes a page's main
subject, it does not belong here — link to burnout-help.nl instead.

## Spec and plan

- Design spec: `docs/superpowers/specs/2026-04-24-zenuwstelsel-design.md`
- Implementation plan: `docs/superpowers/plans/2026-04-24-zenuwstelsel-implementation.md`
