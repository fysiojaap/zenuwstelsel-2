# zenuwstelsel.com

A one-minute self-test and resource about vagus nerve / nervous-system
dysregulation. Single-file static site: `index.html`.

## Deploy

The site is hosted on **Hostinger** with git auto-deploy. Hostinger pulls
this repo into the domain's docroot on every deploy; the `.htaccess` at
the repo root internally rewrites every request into the `build/`
subdirectory, so visitors only ever see the production payload — source
files at the root, `tests/`, `docs/`, and `.git/` all 404.

To ship a change:

1. Edit the source files at the repo root (`index.html`, `favicon.svg`,
   `robots.txt`, `sitemap.xml`).
2. Run `./sync.sh` to mirror them into `build/`. Forgetting this is the
   classic failure: the commit lands, the live site doesn't change.
   `./sync.sh --check` fails if `build/` is behind.
3. Commit and push to `main`.
4. Hostinger picks up the new commit and redeploys.

If a change doesn't appear on the live site after a deploy, hard-refresh
the browser (Ctrl/Cmd + Shift + R) — Hostinger and the browser both
cache static assets.

### Repo layout

```
.htaccess        — Apache: canonical 301s, then rewrite into build/
sync.sh          — mirrors source files into build/
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
- Run reports: `docs/reports/`

Hard rule from the brief: once burn-out or overspanning becomes a page's main
subject, it does not belong here — link to burnout-help.nl instead.

## Spec and plan

- Design spec: `docs/superpowers/specs/2026-04-24-zenuwstelsel-design.md`
- Implementation plan: `docs/superpowers/plans/2026-04-24-zenuwstelsel-implementation.md`
