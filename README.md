# zenuwstelsel.com

A one-minute self-test and resource about vagus nerve / nervous-system
dysregulation. Single-file static site: `index.html`.

## Deploy

The `build/` folder contains everything the live site needs. Upload its
contents to any static host (Netlify, Cloudflare Pages, GitHub Pages, S3,
own server) and point DNS for zenuwstelsel.com at the host. Done.

### What's in `build/`

```
build/
├── index.html    — the entire site (markup, styles, scoring JS, copy)
└── favicon.svg   — browser tab icon, referenced from index.html
```

That's the whole production payload. No CSS/JS bundles, no fonts, no
images — every visual asset is inlined in `index.html` (CSS in `<style>`,
SVGs as inline `<svg>`, the only external link being the favicon).

### Updating `build/`

`build/` is a hand-mirrored copy of the source files at the repo root —
there is no compile step or build script. After editing `index.html` or
`favicon.svg` at the root, copy them into `build/` before deploying:

```sh
cp index.html favicon.svg build/
```

Tests, docs, and the `.vscode/` folder stay out of `build/` on purpose —
they aren't part of the live site.

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
