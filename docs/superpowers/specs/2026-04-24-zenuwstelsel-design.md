# zenuwstelsel.com — design spec

**Date:** 2026-04-24
**Status:** approved for implementation
**Language:** Dutch (nl-NL)
**Brand wordmark (working):** `vagus·`
**Domain:** zenuwstelsel.com

## 1. Purpose

A standalone, test-first landing page about the vagus nerve and nervous-system
dysregulation. The page leads with an interactive six-question self-test.
Educational content sits below as secondary material. Primary conversion goal
is the external intake link at `https://www.psychosomatischefysio.nl/neem-contact-op`.

The page serves two audience moments:

1. **Test-takers** — someone landing from a search or link, ready to do a
   one-minute check. They see the test immediately, answer six questions, get
   a personalized result, and are guided toward intake.
2. **Readers** — someone who wants context before or after the test. They
   scroll down to educational sections: anatomy, three patterns, evidence
   review, practical exercises, limits of self-regulation, and FAQ.

The design intentionally pushes identity: Fraunces display serif, paper-grain
texture, chapter-style content dividers, oversized editorial numerals, hairline
grid, one breathing-dot accent. The feel should be editorial, calm, and
distinctive rather than generic-clinical.

## 2. Page structure

### 2.1 Masthead (thin, persistent)

- Left: wordmark `vagus·` with an animated breath-dot (8px circle, 4s
  `breathe` keyframe — gentle scale + opacity pulse).
- Right: practitioner attribution in small uppercase Inter
  (`Jaap Leemeijer · BIG 09925473804`).
- Bottom divider: 1px hairline in `--line-fine`.
- No navigation links — this is a single-page site.

### 2.2 Above-the-fold hero (test-first)

- Eyebrow: `Zelftest · 1 minuut · geen mail` (small uppercase Inter with a
  leading hairline).
- H1: `In welke stand staat jouw zenuwstelsel?` — "stand" set in italic, type
  up to 76px, Fraunces display weight 300, optical size 144, max 16ch.
- Lead: one sentence under 48ch in Inter — points to test above, content below.
- The self-test component sits directly on the paper background (no card
  chrome). It occupies the rest of the initial viewport.

### 2.3 Self-test component

The test is the centerpiece. Structure:

- **Header row:** six progress dots on the left (active / done / pending
  states) + `01 / 06` counter on the right. Hairline divider below.
- **Question number:** oversized Fraunces numeral (`01` up to 150px) in warm
  accent color, with a small `/06` secondary.
- **Question text:** Fraunces 38px, weight 400, optical size 60, max 22ch.
- **Options:** flat rows with 2px gap between, hairline top/bottom borders on
  the container. Each row: full-width Inter 17px, left-aligned text, right
  arrow appears on hover. Hover shifts content 8px right and reveals a 3px
  ink-colored left accent bar at 60% height.
- **Footer note:** small Inter hint — "Je antwoorden blijven op deze pagina.
  Niks wordt opgeslagen of verzonden."

### 2.4 Content sections (below fold)

All content sections share a two-column grid on desktop (`180px 1fr`, 48px
gap): left column holds a sticky chapter label (`§ 01 Anatomie`, `§ 02
Patronen`, etc.), right column holds the H2, body text, and any components.
On mobile (<720px), grid collapses to single column and the chapter label
sits above the H2.

Section order follows the content draft:

1. **Secondary intro** — transition from test to content. "Wil je weten waar
   het op gebaseerd is? Hier is de korte, eerlijke versie." Oversized italic
   accent on "korte, eerlijke versie".
2. **§ 01 Anatomie** — "Wat is de nervus vagus eigenlijk?" Prose + one pull
   quote styled with left-border + italic Fraunces.
3. **§ 02 Patronen** — "Drie standen van je zenuwstelsel." Three-column
   hairline grid (`activatie`, `uitschakeling`, `gereguleerd`) with numbered
   01/02/03 in matching warm/cool/green accents.
4. **§ 03 Evidence** — "Wat werkt echt — en wat is hype?" List of verdict
   rows. Each row: italic lowercase stamp on the left (`bewezen`,
   `gedeeltelijk`, `hype`, `ondergewaardeerd`, `niet eerste stap`) color-coded
   by credibility; topic + body on the right.
5. **§ 04 Praktijk** — "Drie oefeningen die je nu kunt doen." Each oefening
   numbered with oversized Fraunces numeral + H3 title + how-to + italic why.
6. **§ 05 Grenzen** — "Wanneer zelf-regulatie niet meer lukt." Prose only,
   transitions to CTA.

### 2.5 CTA block (full-bleed)

Dark forest-green block (`#1A2F25`) spanning the full viewport width. Paper
grain overlay at low opacity.

- Eyebrow: `Vrijblijvende intake · 30 minuten`
- H2: `Herken je jezelf in dit verhaal?` — "jezelf" in warm-accent italic.
- Body: one supportive sentence.
- Button: `Plan een intake →` — paper-cream background, ink text, Fraunces
  italic arrow. Hover swaps to warm accent fill with cream text.
- Opens external URL in a new tab: `https://www.psychosomatischefysio.nl/neem-contact-op`.

### 2.6 FAQ (`§ 06 Vragen`)

Five `<details>` elements with Fraunces summaries and `+` indicator that
rotates to `×` on open. First FAQ item is open by default for SEO
discoverability. Answers in Inter 16px, `--ink-soft`.

### 2.7 Footer

Thin, two-column row:
- Left: `zenuwstelsel.com · een zenuwstelsel-check`
- Right: `Jaap Leemeijer · BIG: 09925473804 · Psychosomatische fysiotherapie`

## 3. Self-test logic

Preserve the scoring and result content from `zelftest-zenuwstelsel.html`.

### 3.1 Questions

Six questions, three options each. Every option maps to one of three
"stand" codes: `A` (verhoogde activatie), `B` (uitschakeling), `C`
(gereguleerd). Question content is unchanged from the existing HTML.

### 3.2 Scoring

```
count A, B, C responses across 6 answers
if count(C) >= 4 → gereguleerd
else if count(A) >= 4 → activatie
else if count(B) >= 4 → uitschakeling
else if count(A) >= 2 AND count(B) >= 2 → wisselend
else if count(A) > count(B) → activatie
else if count(B) > count(A) → uitschakeling
else → wisselend
```

Four result types total: `activatie`, `uitschakeling`, `wisselend`,
`gereguleerd`.

### 3.3 Result display

When a user clicks the final question's option:

1. The test card's question content is replaced in place by the matching
   result (inline — same container, smooth cross-fade, ~300ms).
2. Result content for each type is unchanged from `zelftest-zenuwstelsel.html`
   but restyled to match the new identity: Fraunces H3 for the stand title,
   a small colored "badge" with the stand name, a short paragraph of uitleg,
   two oefening cards, and a closing CTA sentence + link to intake.
3. After the result is rendered, the page auto-scrolls to end at the CTA
   block. This is a deliberate cinematic pass-through of the educational
   content, ending on the primary action. Implementation: custom smooth
   scroll with ~1.8s duration and `ease-out-expo` easing
   (`cubic-bezier(0.16, 1, 0.3, 1)`), targeting the top of the CTA block
   offset by 80px. If `prefers-reduced-motion` is set, jump directly to
   the CTA without animation.
4. A small "← test opnieuw doen" button appears in the result footer,
   which resets answers and restores question 1.

### 3.4 Result content per stand

- **Activatie** — warm accent. Oefeningen: 4-6 ademhaling, dagelijkse
  afspraak met jezelf.
- **Uitschakeling** — cool accent. Oefeningen: 5-4-3 grondingsoefening,
  kleine beweging.
- **Wisselend** — warm accent (same warm family as activatie). Oefeningen:
  4-6 ademhaling, micro-pauze per uur.
- **Gereguleerd** — green accent. One maintenance oefening. Softer CTA
  copy: "Heb je deze pagina gevonden voor iemand anders, of wil je
  preventief sparren? Dat kan altijd." Button reads
  `Stel je vraag →` but links to the same intake URL — the practice has
  only one external destination.

## 4. Visual design system

### 4.1 Color tokens

```
--ink:         #1A2F25   /* deepened forest green, text + darks     */
--ink-soft:    #4a5a51   /* secondary text                           */
--ink-faint:   #8a968f   /* meta, hints, chapter labels              */
--paper:       #EEE7D6   /* primary background, warm cream           */
--paper-warm:  #E6DEC7   /* hover fill, slightly warmer              */
--paper-deep:  #1A2F25   /* inverse surfaces (CTA block)             */
--line:        #C9BFA5   /* visible hairlines                        */
--line-fine:   #D8CEB6   /* subtle hairlines                         */
--accent:      #C66B5D   /* warm — activatie, primary emphasis       */
--accent-cool: #4a6b8a   /* cool — uitschakeling                     */
--accent-green:#5E7A60   /* muted green — gereguleerd, "bewezen"     */
```

The palette derives from burnout-help.nl's earth system but deepens ink and
warms paper for more identity. `--accent` (warm terracotta) is the single
attention color.

### 4.2 Typography

- **Display / headings:** `Fraunces` (variable, Google Fonts) — weight 300–400,
  optical sizes 14 (small italic) through 144 (display numerals), `SOFT` axis
  30–50 for a rounder feel at large sizes. Used for H1/H2/H3, question text,
  question numerals, pull quotes, italic emphases.
- **UI / body:** `Inter` (Google Fonts) — 400/500/600. Used for lead
  paragraphs, body text, options, meta, labels, buttons.
- **Line heights:** 1.04 for display, 1.2 for H2/H3, 1.6 for body.
- **Letter spacing:** `-0.025em` on display sizes, `-0.01em` on H3, `0.1–0.15em`
  uppercase on labels/eyebrows.

### 4.3 Spacing

Values used directly (no named tokens beyond these common steps): 4, 8, 12,
16, 24, 32, 48, 80, 120 px. Section padding top/bottom on content articles:
80px. Hero padding top/bottom: 48/80px.

### 4.4 Grid

- Max content width: 1280px.
- Content sections use a two-column grid: `180px 1fr` with 48px gap.
- Hero and test are single-column, aligned left, max 720px for the test body.
- Mobile breakpoint: 720px — collapses all grids to single column.

### 4.5 Surfaces, borders, motion

- **Surfaces:** paper (default) and paper-deep (CTA). No cards with borders in
  the hero. Content sections use hairline dividers between, not containers.
- **Borders:** 1px `--line-fine` for subtle dividers, 1px `--line` for
  visible separators (e.g., between major sections). No border-radius on
  options (flat rows). Buttons are rectangular.
- **Shadows:** none. Hierarchy comes from type scale and hairlines.
- **Paper grain:** fixed SVG turbulence filter at 0.5 opacity, multiply blend
  mode, `pointer-events:none`. Applied to both body and the CTA block
  (separate overlay with lighter tint).
- **Motion:**
  - Breath-dot: 4s ease-in-out infinite, scale 1→1.4→1, opacity 1→0.7→1.
  - Option hover: 240ms cubic-bezier, background + padding-left + left accent bar.
  - Question transition: 300ms cross-fade on answer click.
  - Auto-scroll to CTA: ~1.8s custom easing, triggered after last answer.
    Details in §3.3.
  - FAQ `+` rotation: 240ms ease to 45° on open.
- **`prefers-reduced-motion`:** disable breath pulse and hover transforms; keep
  state changes instant.

## 5. Component inventory

### 5.1 Wordmark

Inline flex: text `vagus` in Fraunces 22px + absolutely-positioned 8px
accent-colored dot, baseline-aligned. Animation on the dot only.

### 5.2 Test card

Stateful: shows one question at a time, transitions to result after question
6. Owns: active question index, answer array, render logic, scroll trigger.
Persists nothing between sessions (no `localStorage`).

### 5.3 Progress dots

Six inline dots. Each dot has one of three classes:
`is-active` (current question), `is-done` (answered), unstyled (upcoming).

### 5.4 Verdict row (content)

Grid `140px 1fr` on desktop, single column on mobile. Left: italic lowercase
label in one of three colors. Right: topic (Inter 600) + body (Inter 400).
Separated by top hairline.

### 5.5 Stand card (content)

Three-column hairline grid. Each card: numeral + H3 + subtitle + ul of 4-5
symptoms. One colored top accent per card (warm / cool / green).

### 5.6 Oefening row (content)

Two-column grid `48px 1fr`. Left: oversized Fraunces numeral. Right: H3
title + "hoe" paragraph + italic "why" note.

### 5.7 CTA block

Full-bleed section (`margin: 0 calc(-50vw + 50%)`). Dark surface + grain.
Inner max-width matches main grid.

### 5.8 FAQ item

`<details>` / `<summary>` with custom `::after` rotator. Summary uses
Fraunces 22px. Body uses Inter 16px.

## 6. Tech architecture

### 6.1 File structure

Single file: `index.html`.

- Embedded `<style>` in `<head>` with all CSS.
- Embedded `<script>` at end of `<body>` for the test behavior.
- No build step, no bundler, no package.json. Host as static HTML anywhere
  (Netlify, GitHub Pages, Cloudflare Pages, own hosting).

Optional static asset: a favicon (`favicon.svg` or `favicon.ico`) referenced
from `<head>`.

### 6.2 Fonts

Loaded from Google Fonts with `preconnect`:

```html
<link href="https://fonts.googleapis.com/css2?family=Fraunces:ital,opsz,wght@0,9..144,300;0,9..144,400;0,9..144,500;0,9..144,700;1,9..144,400&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
```

`display=swap` prevents FOIT; system sans fallback covers the load window.

### 6.3 JavaScript

One IIFE scoped to the self-test. Responsibilities:

- Track `answers[]` and `currentQuestion` index.
- Click handler on each option button stores the answer code and advances.
- On last question, runs `bepaalStand()` scoring function and renders the
  matching result fragment in place.
- Updates progress dots and `01 / 06` counter on every transition.
- After result renders, waits one animation frame, then calls
  `scrollIntoView` on the CTA block.
- "Opnieuw" button resets `answers=[]` and `currentQuestion=0` and re-renders
  question 1.

No frameworks, no dependencies. ~80-120 lines of JS.

### 6.4 Accessibility

- Semantic HTML: `<main>`, `<section>`, `<article>`, `<h1>`–`<h3>`,
  `<details>`/`<summary>`, `<button>` (not clickable divs).
- Skip link to main content at top of body, visually hidden until focus.
- Focus-visible rings on all interactive elements (2px ring in `--accent`).
- Question changes announced to screen readers via
  `aria-live="polite"` on the question container.
- `prefers-reduced-motion` respected (see Motion section).
- Color contrast: ink on paper = 11.2:1, ink-soft on paper = 6.4:1, both
  AAA. Accent on paper at 4.7:1 (AA for large text — used on display only).

### 6.5 SEO

- `<title>`: `In welke stand staat jouw zenuwstelsel? — zenuwstelsel.com`
- `<meta name="description">`: from content draft, trimmed to ~155 chars.
- `<link rel="canonical" href="https://zenuwstelsel.com/">` — updated from
  the draft's burnout-help.nl canonical, since this is now standalone.
- Open Graph + Twitter tags for social share preview.
- Schema.org JSON-LD in `<head>`:
  - `MedicalWebPage` with `about: VagusNerve`, `mainEntity` pointing at the
    FAQPage.
  - `FAQPage` with five `Question`/`Answer` pairs matching the FAQ section.
  - `Person` entry for Jaap Leemeijer with `hasCredential` (BIG number).
- Language: `<html lang="nl-NL">`.
- Sitemap and robots.txt are out of scope for this spec (can be added at
  deploy time).

## 7. Out of scope

- Blog section, additional pages, or internal navigation. Future work.
- Intake form, contact form, booking widget. External link only.
- Analytics, cookie banner, tracking. Site collects no data.
- Email signup, newsletter.
- Multi-language. Dutch only.
- Dark mode. Paper-cream is the only theme.
- CMS / SSG migration. If this page moves to Astro or similar later, the
  HTML/CSS/JS carries over near-1:1.
- Print stylesheet.
