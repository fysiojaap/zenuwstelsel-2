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

1. Edit `index.html` / `favicon.svg` at the repo root.
2. Mirror them into `build/` (`cp index.html favicon.svg build/`).
3. Commit and push to `main`.
4. Hostinger picks up the new commit and redeploys.

If a change doesn't appear on the live site after a deploy, hard-refresh
the browser (Ctrl/Cmd + Shift + R) — Hostinger and the browser both
cache static assets.

### Repo layout

```
.htaccess        — Apache rewrite: routes every request into build/
index.html       — source-of-truth markup (edit here)
favicon.svg      — source-of-truth icon (edit here)
build/
├── index.html   — deployed copy (mirror of root, served by Hostinger)
└── favicon.svg  — deployed copy
tests/           — local-only, not deployed
docs/            — specs and plans, not deployed
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

## External link

Primary CTA and all four result CTAs point at
`https://www.psychosomatischefysio.nl/neem-contact-op` (external intake).

## Spec and plan

- Design spec: `docs/superpowers/specs/2026-04-24-zenuwstelsel-design.md`
- Implementation plan: `docs/superpowers/plans/2026-04-24-zenuwstelsel-implementation.md`
