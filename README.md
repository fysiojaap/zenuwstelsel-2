# zenuwstelsel.com

A one-minute self-test and resource about vagus nerve / nervous-system
dysregulation. Single-file static site: `index.html`.

## Deploy

No build step. Copy `index.html`, `favicon.svg`, and the `tests/` folder to
any static host (Netlify, Cloudflare Pages, GitHub Pages, S3, own server).

Point DNS for zenuwstelsel.com at the host. Done.

## Tests

Open `tests/scoring.test.html` in a browser. All 17 scoring cases should
show green "✓" — covers all four result paths (activatie, uitschakeling,
wisselend, gereguleerd) and edge cases.

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
