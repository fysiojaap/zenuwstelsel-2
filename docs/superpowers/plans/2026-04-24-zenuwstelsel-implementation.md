# zenuwstelsel.com Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a single-file, test-first landing page for zenuwstelsel.com. An interactive 6-question self-test is the hero; editorial content sits below. Result completion triggers a cinematic auto-scroll to an external intake link.

**Architecture:** One production file `index.html` with embedded CSS and JS — no build step, no dependencies. A separate `tests/scoring.test.html` runs browser-based assertions on the scoring function. Fonts load from Google Fonts (Fraunces + Inter). Deploys as static HTML anywhere.

**Tech Stack:** HTML, CSS (custom properties, CSS grid, `@keyframes`), vanilla JS (ES2020, no frameworks), Google Fonts (Fraunces variable serif + Inter), JSON-LD for schema.org.

**Source of truth:**
- Design spec: `docs/superpowers/specs/2026-04-24-zenuwstelsel-design.md`
- Content draft: `nervus-vagus-content.md`
- Existing self-test (reference for questions, options, scoring, and result content): `zelftest-zenuwstelsel.html`

---

## File Structure

| File | Purpose |
|------|---------|
| `index.html` | Single-file production artifact. All HTML, CSS (embedded `<style>`), JS (embedded `<script>`). |
| `tests/scoring.test.html` | Browser-runnable test harness. Duplicates the scoring function and asserts on it. Open in browser, see pass/fail. |
| `favicon.svg` | Tiny brand mark — the breath-dot circle. |
| `README.md` | One-page deploy notes: how to host, how to run tests, how to edit content. |

Files that need to be deleted at the end: the old draft test at `zelftest-zenuwstelsel.html` and the content draft `nervus-vagus-content.md` become historical artifacts; leave them for reference until final cleanup in the last task.

---

## Task 1: HTML skeleton with meta, fonts, and section scaffolds

**Files:**
- Create: `index.html`

- [ ] **Step 1: Create `index.html` with the full structural scaffold**

Write the file exactly as below. All sections are empty placeholders; content and styling come in later tasks. This task only verifies the HTML parses and renders in a browser.

```html
<!DOCTYPE html>
<html lang="nl-NL">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>In welke stand staat jouw zenuwstelsel? — zenuwstelsel.com</title>
  <meta name="description" content="Zelftest voor een ontregeld zenuwstelsel. Zes vragen, direct antwoord met oefeningen. Plus wat wél en wat níet werkt volgens onderzoek.">
  <link rel="canonical" href="https://zenuwstelsel.com/">

  <!-- Open Graph / social -->
  <meta property="og:type" content="website">
  <meta property="og:url" content="https://zenuwstelsel.com/">
  <meta property="og:title" content="In welke stand staat jouw zenuwstelsel?">
  <meta property="og:description" content="Een 1-minuut zelftest voor je zenuwstelsel. Geen mail. Direct antwoord.">
  <meta property="og:locale" content="nl_NL">

  <!-- Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Fraunces:ital,opsz,wght@0,9..144,300;0,9..144,400;0,9..144,500;0,9..144,700;1,9..144,400&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">

  <!-- Favicon (added in later task) -->

  <!-- JSON-LD schema added in SEO task -->

  <style>
    /* Design tokens + global styles added in next task */
  </style>
</head>
<body>

  <a href="#main" class="skip-link">Spring naar de hoofdinhoud</a>

  <div class="wrap">

    <header class="masthead" role="banner">
      <!-- brand wordmark + practitioner attribution (Task 3) -->
    </header>

    <main id="main">

      <section class="hero" aria-labelledby="hero-title">
        <!-- eyebrow, H1, lead, test component (Tasks 3, 4, 6) -->
      </section>

      <div class="secondary-intro">
        <!-- transition from test to content (Task 8) -->
      </div>

      <section class="article" id="anatomie" aria-labelledby="anatomie-title">
        <!-- § 01 Anatomie (Task 8) -->
      </section>

      <section class="article" id="patronen" aria-labelledby="patronen-title">
        <!-- § 02 Patronen (Task 8) -->
      </section>

      <section class="article" id="evidence" aria-labelledby="evidence-title">
        <!-- § 03 Evidence (Task 8) -->
      </section>

      <section class="article" id="praktijk" aria-labelledby="praktijk-title">
        <!-- § 04 Praktijk (Task 8) -->
      </section>

      <section class="article" id="grenzen" aria-labelledby="grenzen-title">
        <!-- § 05 Grenzen (Task 8) -->
      </section>

    </main>

    <!-- full-bleed CTA (Task 9) -->

  </div>

  <section class="cta" id="intake" aria-labelledby="cta-title">
    <!-- dark CTA block, escapes the .wrap container via margin trick (Task 9) -->
  </section>

  <div class="wrap">

    <section class="faq-wrap" aria-labelledby="faq-title">
      <!-- § 06 Vragen (Task 10) -->
    </section>

    <footer class="site-foot" role="contentinfo">
      <!-- footer (Task 10) -->
    </footer>

  </div>

  <script>
    // Test behavior added in Task 6
  </script>

</body>
</html>
```

- [ ] **Step 2: Open `index.html` in a browser and verify it parses**

Run: open the file directly via `file://` or serve with `python -m http.server 8000` and visit `http://localhost:8000/`.
Expected: blank page loads without console errors. View Source shows the scaffold. Fonts request fires in network tab.

- [ ] **Step 3: Commit**

```bash
git add index.html
git commit -m "feat: html skeleton with meta, fonts, section scaffolds"
```

---

## Task 2: Design system — tokens, reset, typography, paper grain

**Files:**
- Modify: `index.html` (inside the `<style>` block)

- [ ] **Step 1: Replace the `<style>` block with the design system base**

Locate the empty `<style>` block added in Task 1 and replace its content with the following:

```css
/* =============================================================
   DESIGN TOKENS
   ============================================================= */
:root {
  --ink:         #1A2F25;
  --ink-soft:    #4a5a51;
  --ink-faint:   #8a968f;
  --paper:       #EEE7D6;
  --paper-warm:  #E6DEC7;
  --paper-deep:  #1A2F25;
  --line:        #C9BFA5;
  --line-fine:   #D8CEB6;
  --accent:      #C66B5D;
  --accent-cool: #4a6b8a;
  --accent-green:#5E7A60;
}

/* =============================================================
   RESET + BASE
   ============================================================= */
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

html { scroll-behavior: smooth; }

body {
  background: var(--paper);
  color: var(--ink);
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
  font-size: 17px;
  line-height: 1.6;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  position: relative;
  overflow-x: hidden;
}

/* Paper grain — fixed, behind content */
body::before {
  content: '';
  position: fixed;
  inset: 0;
  pointer-events: none;
  opacity: 0.5;
  mix-blend-mode: multiply;
  z-index: 0;
  background-image: url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='200' height='200'><filter id='n'><feTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='2' stitchTiles='stitch'/><feColorMatrix values='0 0 0 0 0.1 0 0 0 0 0.15 0 0 0 0 0.1 0 0 0 0.12 0'/></filter><rect width='100%25' height='100%25' filter='url(%23n)'/></svg>");
}

::selection { background: var(--accent); color: var(--paper); }

/* =============================================================
   LAYOUT CONTAINER
   ============================================================= */
.wrap {
  max-width: 1280px;
  margin: 0 auto;
  padding: 0 32px;
  position: relative;
  z-index: 1;
}

/* =============================================================
   ACCESSIBILITY
   ============================================================= */
.skip-link {
  position: absolute;
  top: -100px;
  left: 16px;
  background: var(--ink);
  color: var(--paper);
  padding: 12px 20px;
  text-decoration: none;
  font-weight: 500;
  z-index: 1000;
  transition: top 200ms ease;
}
.skip-link:focus { top: 16px; }

:focus-visible {
  outline: 2px solid var(--accent);
  outline-offset: 3px;
}

@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
    scroll-behavior: auto !important;
  }
}

/* =============================================================
   TYPOGRAPHY BASE (specific sections override later)
   ============================================================= */
h1, h2, h3 {
  font-family: 'Fraunces', Georgia, serif;
  color: var(--ink);
  letter-spacing: -0.02em;
  line-height: 1.1;
}

p { max-width: 62ch; }

a { color: var(--ink); text-decoration-color: var(--accent); text-underline-offset: 3px; }
a:hover { color: var(--accent); }
```

- [ ] **Step 2: Verify visually**

Reload `index.html` in the browser. Expected: background shifts to warm cream `#EEE7D6`, subtle grain texture visible, no layout yet (sections still empty). Focus a tab key and confirm the skip-link slides in from the top.

- [ ] **Step 3: Commit**

```bash
git add index.html
git commit -m "feat: design tokens, reset, typography base, paper grain"
```

---

## Task 3: Masthead and hero (eyebrow, H1, lead)

**Files:**
- Modify: `index.html` — fill `<header class="masthead">` and the top of `<section class="hero">`; append CSS to the `<style>` block.

- [ ] **Step 1: Replace the empty `<header class="masthead">` with the wordmark + attribution**

```html
<header class="masthead" role="banner">
  <div class="brand" aria-label="zenuwstelsel.com">
    vagus<span class="brand-dot" aria-hidden="true"></span>
  </div>
  <div class="masthead-meta">Jaap Leemeijer · BIG 09925473804</div>
</header>
```

- [ ] **Step 2: Replace the opening content of `<section class="hero">` with eyebrow, H1, lead**

```html
<section class="hero" aria-labelledby="hero-title">
  <p class="hero-eyebrow">Zelftest · 1 minuut · geen mail</p>
  <h1 id="hero-title" class="hero-title">In welke <em>stand</em> staat jouw zenuwstelsel?</h1>
  <p class="hero-lead">Zes vragen. Direct een patroon en oefeningen die daarbij passen. Daaronder — als je het wil lezen — waar het op gebaseerd is.</p>

  <!-- test component added in Task 4 -->
</section>
```

- [ ] **Step 3: Append masthead + hero CSS to the `<style>` block**

Append after the existing CSS:

```css
/* =============================================================
   MASTHEAD
   ============================================================= */
.masthead {
  padding: 28px 0;
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-bottom: 1px solid var(--line-fine);
}

.brand {
  font-family: 'Fraunces', serif;
  font-weight: 400;
  font-size: 22px;
  font-variation-settings: "opsz" 144, "SOFT" 50;
  letter-spacing: -0.02em;
  display: flex;
  align-items: baseline;
  gap: 6px;
  color: var(--ink);
  user-select: none;
}

.brand-dot {
  width: 8px;
  height: 8px;
  background: var(--accent);
  border-radius: 50%;
  display: inline-block;
  transform: translateY(-3px);
  animation: breathe 4s ease-in-out infinite;
}

@keyframes breathe {
  0%, 100% { transform: translateY(-3px) scale(1);   opacity: 1;   }
  50%      { transform: translateY(-3px) scale(1.4); opacity: 0.7; }
}

.masthead-meta {
  font-family: 'Inter', sans-serif;
  font-size: 12px;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: var(--ink-faint);
}

/* =============================================================
   HERO
   ============================================================= */
.hero {
  padding: 48px 0 80px;
  min-height: 90vh;
  display: flex;
  flex-direction: column;
}

.hero-eyebrow {
  font-family: 'Inter', sans-serif;
  font-size: 12px;
  letter-spacing: 0.15em;
  text-transform: uppercase;
  color: var(--ink-faint);
  margin-bottom: 16px;
  display: flex;
  align-items: center;
  gap: 12px;
}

.hero-eyebrow::before {
  content: '';
  width: 28px;
  height: 1px;
  background: var(--ink-faint);
  display: inline-block;
}

.hero-title {
  font-family: 'Fraunces', serif;
  font-weight: 300;
  font-variation-settings: "opsz" 144, "SOFT" 30;
  font-size: clamp(40px, 6vw, 76px);
  line-height: 1.04;
  letter-spacing: -0.025em;
  color: var(--ink);
  max-width: 16ch;
  margin-bottom: 24px;
}

.hero-title em {
  font-style: italic;
  font-weight: 400;
}

.hero-lead {
  font-family: 'Inter', sans-serif;
  font-size: 17px;
  color: var(--ink-soft);
  max-width: 48ch;
  margin-bottom: 56px;
}

/* On mobile, tighten hero */
@media (max-width: 720px) {
  .masthead-meta { display: none; }
  .hero { min-height: 80vh; padding-top: 24px; padding-bottom: 48px; }
}
```

- [ ] **Step 4: Verify visually**

Reload. Expected: top row shows `vagus·` wordmark with a small terracotta dot that pulses every 4s, and `Jaap Leemeijer · BIG 09925473804` aligned right. Below: uppercase eyebrow with leading dash, huge serif H1 with italic "stand", short lead paragraph. On a narrow viewport (drag to <720px), the practitioner attribution hides.

- [ ] **Step 5: Commit**

```bash
git add index.html
git commit -m "feat: masthead wordmark with breathing dot, hero eyebrow/H1/lead"
```

---

## Task 4: Test component — HTML, hidden questions and results, visual CSS

**Files:**
- Modify: `index.html` — add test markup inside `<section class="hero">`; append CSS.

This task creates the visual shell: all 6 questions as `<article>` elements (only #1 visible), all 4 result blocks hidden, progress dots and counter showing question 1. No interactivity yet — clicking does nothing.

- [ ] **Step 1: Add the test markup at the end of the `<section class="hero">` block**

Insert inside `.hero`, after the `.hero-lead` paragraph:

```html
<div class="test" aria-label="Zelftest zenuwstelsel">
  <div class="test-head">
    <div class="test-dots" role="progressbar" aria-valuemin="1" aria-valuemax="6" aria-valuenow="1" aria-label="Voortgang">
      <span class="test-dot is-active"></span>
      <span class="test-dot"></span>
      <span class="test-dot"></span>
      <span class="test-dot"></span>
      <span class="test-dot"></span>
      <span class="test-dot"></span>
    </div>
    <span class="test-count" aria-live="polite">01 / 06</span>
  </div>

  <!-- QUESTIONS -->
  <article class="vraag is-active" data-vraag="1" aria-live="polite">
    <div class="vraag-number">01<span class="vraag-number-slash">/06</span></div>
    <h2 class="vraag-text">Hoe voelt je lichaam zich meestal door de dag?</h2>
    <div class="opties">
      <button type="button" data-stand="A">Opgejaagd, hart klopt soms snel zonder reden<span class="arrow" aria-hidden="true">→</span></button>
      <button type="button" data-stand="B">Zwaar en moeilijk op gang te krijgen<span class="arrow" aria-hidden="true">→</span></button>
      <button type="button" data-stand="C">Wisselend, maar ik kan meekomen<span class="arrow" aria-hidden="true">→</span></button>
    </div>
  </article>

  <article class="vraag" data-vraag="2">
    <div class="vraag-number">02<span class="vraag-number-slash">/06</span></div>
    <h2 class="vraag-text">Hoe gaat het met je slaap?</h2>
    <div class="opties">
      <button type="button" data-stand="A">Moeite met inslapen, piekeren, vroeg wakker<span class="arrow" aria-hidden="true">→</span></button>
      <button type="button" data-stand="B">Ik slaap veel maar word niet uitgerust wakker<span class="arrow" aria-hidden="true">→</span></button>
      <button type="button" data-stand="C">Redelijk goed, soms een mindere nacht<span class="arrow" aria-hidden="true">→</span></button>
    </div>
  </article>

  <article class="vraag" data-vraag="3">
    <div class="vraag-number">03<span class="vraag-number-slash">/06</span></div>
    <h2 class="vraag-text">Als er iets onverwachts gebeurt — een telefoontje, een wijziging, drukte — wat doet je lichaam dan?</h2>
    <div class="opties">
      <button type="button" data-stand="A">Het schiet meteen in de stress, hartslag omhoog<span class="arrow" aria-hidden="true">→</span></button>
      <button type="button" data-stand="B">Ik klap dicht of word leeg, alsof ik er niet meer ben<span class="arrow" aria-hidden="true">→</span></button>
      <button type="button" data-stand="C">Ik reageer en het zakt daarna weer<span class="arrow" aria-hidden="true">→</span></button>
    </div>
  </article>

  <article class="vraag" data-vraag="4">
    <div class="vraag-number">04<span class="vraag-number-slash">/06</span></div>
    <h2 class="vraag-text">Wat voel je in je lichaam als je probeert tot rust te komen?</h2>
    <div class="opties">
      <button type="button" data-stand="A">Spanning, druk op de borst, woelige hartslag<span class="arrow" aria-hidden="true">→</span></button>
      <button type="button" data-stand="B">Zwaarte, verdoving, ver weg gevoel<span class="arrow" aria-hidden="true">→</span></button>
      <button type="button" data-stand="C">Ik kan ontspannen, soms makkelijker dan andere keren<span class="arrow" aria-hidden="true">→</span></button>
    </div>
  </article>

  <article class="vraag" data-vraag="5">
    <div class="vraag-number">05<span class="vraag-number-slash">/06</span></div>
    <h2 class="vraag-text">Sociale situaties — feestjes, vergaderingen, drukke ruimtes — voelen voor mij…</h2>
    <div class="opties">
      <button type="button" data-stand="A">Te veel; ik word er nerveus en opgejaagd van<span class="arrow" aria-hidden="true">→</span></button>
      <button type="button" data-stand="B">Te veel moeite; ik trek me liever terug<span class="arrow" aria-hidden="true">→</span></button>
      <button type="button" data-stand="C">Soms leuk, soms vermoeiend — normaal dus<span class="arrow" aria-hidden="true">→</span></button>
    </div>
  </article>

  <article class="vraag" data-vraag="6">
    <div class="vraag-number">06<span class="vraag-number-slash">/06</span></div>
    <h2 class="vraag-text">Hoe is je energie door de week?</h2>
    <div class="opties">
      <button type="button" data-stand="A">Aan totdat ik omval; weinig tussenstanden<span class="arrow" aria-hidden="true">→</span></button>
      <button type="button" data-stand="B">Ik kom moeilijk in beweging, alles kost moeite<span class="arrow" aria-hidden="true">→</span></button>
      <button type="button" data-stand="C">Wisselt met wat ik doe en hoe ik geslapen heb<span class="arrow" aria-hidden="true">→</span></button>
    </div>
  </article>

  <!-- RESULTS -->
  <article class="resultaat" data-resultaat="activatie">
    <span class="resultaat-badge resultaat-badge--activatie">Verhoogde activatie</span>
    <h2 class="resultaat-title">Je zenuwstelsel staat vooral 'aan'</h2>
    <p class="resultaat-uitleg">Je antwoorden wijzen op een patroon van vecht-of-vlucht-activatie. Je sympathische zenuwstelsel — het systeem dat je in actie zet — heeft de overhand. Dit voelt als opgejaagdheid, hartkloppingen, moeilijk doorademen, korte lont. Het is geen zwakte; het is een lichaam dat al een tijd op scherp staat.</p>

    <div class="oefening-inline">
      <h3>Doe nu: de 4-6 ademhaling</h3>
      <p>Adem 4 seconden in door je neus. Adem 6 seconden uit door je mond, alsof je een kaars laat flakkeren zonder hem uit te blazen. Doe dit 3 minuten. De verlengde uitademing is het actieve deel.</p>
    </div>

    <div class="oefening-inline">
      <h3>Maak vandaag een afspraak met jezelf</h3>
      <p>Plan twee momenten van 5 minuten zónder telefoon, zónder muziek, zónder taak. Voor een opgejaagd systeem is 'niks doen' de moeilijkste — én belangrijkste — oefening.</p>
    </div>

    <div class="resultaat-cta">
      <p>Lukt het niet om uit deze stand te komen, ook niet met oefenen? Dan is samen kijken vaak effectiever dan zelf doorworstelen.</p>
      <a href="https://www.psychosomatischefysio.nl/neem-contact-op" target="_blank" rel="noopener" class="btn-inline">Plan een vrijblijvende intake <span class="arrow">→</span></a>
    </div>
  </article>

  <article class="resultaat" data-resultaat="uitschakeling">
    <span class="resultaat-badge resultaat-badge--uitschakeling">Uitschakeling</span>
    <h2 class="resultaat-title">Je zenuwstelsel staat in de bevriezings-stand</h2>
    <p class="resultaat-uitleg">Je antwoorden wijzen op een patroon waarbij je systeem zichzelf heeft afgesloten. Niet vechten of vluchten — bevriezen. Dat voelt als leegte, zware ledematen, moeite om in beweging te komen. Vaak komt deze stand na een lange periode van overactivering.</p>

    <div class="oefening-inline">
      <h3>Doe nu: de 5-4-3 grondingsoefening</h3>
      <p>Zet beide voeten plat op de grond. Duw je hielen zacht omlaag. Voel het contact. Benoem nu 5 dingen die je ziet, 4 die je hoort, 3 die je voelt. Niet om te ontspannen — om je systeem terug te halen naar het hier en nu.</p>
    </div>

    <div class="oefening-inline">
      <h3>En daarna: kom in beweging, hoe klein ook</h3>
      <p>Sta op. Zwaai je armen een minuut. Loop een rondje. De vriesstand vraagt om kleine, veilige beweging — niet om sport. Het signaal naar je systeem is: het is veilig om te bewegen.</p>
    </div>

    <div class="resultaat-cta">
      <p>Bevriezing is moeilijk om alleen uit te komen. Dat is geen oordeel — het is hoe het systeem werkt. Begeleiding helpt om stap voor stap je raam van rek terug te bouwen.</p>
      <a href="https://www.psychosomatischefysio.nl/neem-contact-op" target="_blank" rel="noopener" class="btn-inline">Plan een vrijblijvende intake <span class="arrow">→</span></a>
    </div>
  </article>

  <article class="resultaat" data-resultaat="wisselend">
    <span class="resultaat-badge resultaat-badge--wisselend">Wisselend patroon</span>
    <h2 class="resultaat-title">Je wisselt tussen 'aan' en 'uit' — en dat is uitputtend</h2>
    <p class="resultaat-uitleg">Je antwoorden wijzen op het meest voorkomende patroon: overdag opgejaagd, 's avonds leeg op de bank. Of de ene week aan, de andere week uitgeput. Je zenuwstelsel pendelt tussen overactivering en uitschakeling, zonder veel tijd in de middenstand. Dat voelt als nooit echt rust hebben.</p>

    <div class="oefening-inline">
      <h3>Doe nu: de 4-6 ademhaling</h3>
      <p>Adem 4 seconden in door je neus, 6 seconden uit door je mond. 3 minuten lang. Bij een wisselend patroon helpt deze oefening op beide momenten — als je opgefokt raakt én als je dichtklapt.</p>
    </div>

    <div class="oefening-inline">
      <h3>Maak één micro-pauze per uur</h3>
      <p>Eén minuut. Geen scherm. Drie keer langzaam ademen. Het patroon doorbreken is belangrijker dan de duur. Je traint je systeem dat het niet alle uren door 'aan' hoeft.</p>
    </div>

    <div class="resultaat-cta">
      <p>Het wisselende patroon is meestal een teken dat je raam van rek smaller is geworden. Dat is precies wat in een traject wél te verbreden is.</p>
      <a href="https://www.psychosomatischefysio.nl/neem-contact-op" target="_blank" rel="noopener" class="btn-inline">Plan een vrijblijvende intake <span class="arrow">→</span></a>
    </div>
  </article>

  <article class="resultaat" data-resultaat="gereguleerd">
    <span class="resultaat-badge resultaat-badge--gereguleerd">Binnen je raam</span>
    <h2 class="resultaat-title">Je zenuwstelsel werkt zoals het bedoeld is</h2>
    <p class="resultaat-uitleg">Je antwoorden wijzen op een gereguleerd patroon: je voelt wat je voelt, maar het overspoelt je niet. Je kunt inspanning en rust afwisselen. Dat is niet vanzelfsprekend — koester het, en herken vroege signalen als ze ooit verschuiven.</p>

    <div class="oefening-inline">
      <h3>Voor onderhoud: blijf doen wat werkt</h3>
      <p>Beweging, slaap, sociale verbinding, momenten zonder scherm. De basis is saai en effectief. Een dagelijkse 5-minuten ademoefening helpt je raam open te houden.</p>
    </div>

    <div class="resultaat-cta">
      <p>Heb je deze pagina gevonden voor iemand anders, of wil je preventief sparren? Dat kan altijd.</p>
      <a href="https://www.psychosomatischefysio.nl/neem-contact-op" target="_blank" rel="noopener" class="btn-inline">Stel je vraag <span class="arrow">→</span></a>
    </div>
  </article>

  <button type="button" class="opnieuw" hidden>← Test opnieuw doen</button>

  <p class="test-foot">Je antwoorden blijven op deze pagina. Niks wordt opgeslagen of verzonden.</p>
</div>
```

- [ ] **Step 2: Append test CSS to the `<style>` block**

```css
/* =============================================================
   TEST COMPONENT
   ============================================================= */
.test {
  max-width: 720px;
  margin-top: auto;
}

.test-head {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-bottom: 20px;
  border-bottom: 1px solid var(--line-fine);
  margin-bottom: 48px;
}

.test-dots { display: flex; gap: 6px; }

.test-dot {
  width: 7px; height: 7px;
  border-radius: 50%;
  background: var(--line);
  transition: background 200ms ease;
}
.test-dot.is-active { background: var(--ink); }
.test-dot.is-done   { background: var(--accent); }

.test-count {
  font-family: 'Inter', sans-serif;
  font-size: 12px;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: var(--ink-faint);
  font-variant-numeric: tabular-nums;
}

/* QUESTIONS (default hidden, .is-active shows) */
.vraag { display: none; }
.vraag.is-active { display: block; animation: fadeIn 300ms ease; }

@keyframes fadeIn {
  from { opacity: 0; transform: translateY(6px); }
  to   { opacity: 1; transform: translateY(0);    }
}

.vraag-number {
  font-family: 'Fraunces', serif;
  font-variation-settings: "opsz" 144;
  font-weight: 300;
  font-size: clamp(80px, 12vw, 150px);
  line-height: 0.9;
  color: var(--accent);
  letter-spacing: -0.04em;
  margin-bottom: 24px;
  display: flex;
  align-items: baseline;
  gap: 12px;
}

.vraag-number-slash {
  font-size: 18px;
  color: var(--ink-faint);
  font-variation-settings: "opsz" 14;
  letter-spacing: 0.05em;
  font-weight: 400;
}

.vraag-text {
  font-family: 'Fraunces', serif;
  font-variation-settings: "opsz" 60, "SOFT" 50;
  font-weight: 400;
  font-size: clamp(26px, 3.2vw, 38px);
  line-height: 1.15;
  letter-spacing: -0.01em;
  color: var(--ink);
  max-width: 22ch;
  margin-bottom: 40px;
}

.opties {
  display: grid;
  gap: 2px;
  background: var(--line-fine);
  border-top: 1px solid var(--line-fine);
  border-bottom: 1px solid var(--line-fine);
}

.opties button {
  background: var(--paper);
  border: none;
  padding: 22px 28px 22px 32px;
  font-family: 'Inter', sans-serif;
  font-size: 17px;
  color: var(--ink);
  text-align: left;
  cursor: pointer;
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 24px;
  transition: all 240ms cubic-bezier(.4, 0, .2, 1);
  position: relative;
}

.opties button::before {
  content: '';
  position: absolute;
  left: 0; top: 50%;
  width: 3px; height: 0;
  background: var(--ink);
  transform: translateY(-50%);
  transition: height 240ms cubic-bezier(.4, 0, .2, 1);
}

.opties button:hover {
  background: var(--paper-warm);
  padding-left: 40px;
}

.opties button:hover::before { height: 60%; }

.opties button .arrow {
  color: var(--ink-faint);
  font-family: 'Fraunces', serif;
  font-size: 20px;
  font-style: italic;
  opacity: 0;
  transition: opacity 240ms ease;
}

.opties button:hover .arrow { opacity: 1; }

.test-foot {
  margin-top: 24px;
  font-size: 12px;
  letter-spacing: 0.05em;
  color: var(--ink-faint);
}

/* RESULTS (default hidden, .is-active shows) */
.resultaat { display: none; }
.resultaat.is-active { display: block; animation: fadeIn 300ms ease; }

.resultaat-badge {
  display: inline-block;
  font-family: 'Inter', sans-serif;
  font-size: 12px;
  font-weight: 500;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  padding: 6px 12px;
  margin-bottom: 24px;
  border: 1px solid currentColor;
}

.resultaat-badge--activatie    { color: var(--accent); }
.resultaat-badge--uitschakeling { color: var(--accent-cool); }
.resultaat-badge--wisselend    { color: var(--accent); }
.resultaat-badge--gereguleerd  { color: var(--accent-green); }

.resultaat-title {
  font-family: 'Fraunces', serif;
  font-variation-settings: "opsz" 60, "SOFT" 30;
  font-weight: 400;
  font-size: clamp(28px, 3.5vw, 42px);
  line-height: 1.15;
  letter-spacing: -0.015em;
  margin-bottom: 24px;
  max-width: 20ch;
}

.resultaat-uitleg {
  font-size: 17px;
  color: var(--ink-soft);
  margin-bottom: 40px;
  max-width: 56ch;
}

.oefening-inline {
  padding: 28px 0;
  border-top: 1px solid var(--line-fine);
}

.oefening-inline h3 {
  font-family: 'Fraunces', serif;
  font-variation-settings: "opsz" 60;
  font-weight: 400;
  font-size: 22px;
  margin-bottom: 12px;
  color: var(--ink);
  letter-spacing: -0.01em;
}

.oefening-inline p {
  font-size: 16px;
  color: var(--ink-soft);
  max-width: 60ch;
}

.resultaat-cta {
  padding: 32px 0 8px;
  border-top: 1px solid var(--line);
  margin-top: 16px;
}

.resultaat-cta p {
  font-size: 16px;
  color: var(--ink-soft);
  margin-bottom: 20px;
}

.btn-inline {
  display: inline-flex;
  align-items: center;
  gap: 12px;
  padding: 16px 28px;
  background: var(--ink);
  color: var(--paper);
  text-decoration: none;
  font-family: 'Inter', sans-serif;
  font-weight: 500;
  font-size: 16px;
  transition: background 200ms ease, transform 200ms ease;
}

.btn-inline:hover {
  background: var(--accent);
  color: var(--paper);
  transform: translateY(-1px);
}

.btn-inline .arrow {
  font-family: 'Fraunces', serif;
  font-style: italic;
  font-size: 18px;
}

.opnieuw {
  background: none;
  border: none;
  color: var(--accent);
  text-decoration: underline;
  cursor: pointer;
  padding: 16px 0;
  margin-top: 16px;
  font-size: 14px;
  font-family: 'Inter', sans-serif;
}
```

- [ ] **Step 3: Verify visually**

Reload. Expected: test component renders with progress dots (first one dark, rest light), `01 / 06` counter, oversized "01/06" serif numeral in terracotta, question 1 text, three options as flat rows with hairline dividers. Hover on an option: background warms, padding shifts 8px right, italic arrow fades in, left accent bar slides up. Questions 2-6 and all 4 results are not visible. The "← test opnieuw doen" button is hidden.

- [ ] **Step 4: Commit**

```bash
git add index.html
git commit -m "feat: test component HTML for all 6 questions and 4 results"
```

---

## Task 5: Scoring function with TDD harness

**Files:**
- Create: `tests/scoring.test.html`

This task implements and tests the scoring function in isolation, before wiring it into the production page in Task 6.

- [ ] **Step 1: Create the failing test harness**

Create `tests/scoring.test.html` with the following content. The file defines `bepaalStand` as a placeholder that always returns `null` — all assertions should fail.

```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Scoring tests — zenuwstelsel.com</title>
  <style>
    body { font-family: system-ui, sans-serif; padding: 24px; max-width: 800px; margin: 0 auto; }
    .test { padding: 8px 12px; margin: 4px 0; border-left: 4px solid; }
    .pass { background: #e8f5e9; border-color: #2e7d32; color: #1b5e20; }
    .fail { background: #ffebee; border-color: #c62828; color: #b71c1c; }
    .summary { margin: 24px 0; padding: 16px; font-weight: 600; }
    code { background: #f5f5f5; padding: 2px 6px; border-radius: 3px; font-family: ui-monospace, monospace; }
  </style>
</head>
<body>
  <h1>Scoring tests: <code>bepaalStand()</code></h1>
  <div id="results"></div>
  <div class="summary" id="summary"></div>

  <script>
    // PLACEHOLDER — intentionally wrong, tests should fail
    function bepaalStand(answers) {
      return null;
    }

    // ====================================================
    // Test runner
    // ====================================================
    const results = document.getElementById('results');
    const summary = document.getElementById('summary');
    let passed = 0, failed = 0;

    function test(label, answers, expected) {
      const actual = bepaalStand(answers);
      const ok = actual === expected;
      const el = document.createElement('div');
      el.className = 'test ' + (ok ? 'pass' : 'fail');
      el.innerHTML = `${ok ? '✓' : '✗'} <strong>${label}</strong> · input: <code>[${answers.join(',')}]</code> · expected: <code>${expected}</code> · got: <code>${actual}</code>`;
      results.appendChild(el);
      ok ? passed++ : failed++;
    }

    // ====================================================
    // Test cases (derived from existing zelftest-zenuwstelsel.html)
    // ====================================================

    // 4+ C → gereguleerd (regardless of remaining)
    test('six Cs → gereguleerd',          ['C','C','C','C','C','C'], 'gereguleerd');
    test('4 Cs + 2 As → gereguleerd',     ['C','C','C','C','A','A'], 'gereguleerd');
    test('4 Cs + 2 Bs → gereguleerd',     ['C','C','C','C','B','B'], 'gereguleerd');

    // 4+ A → activatie
    test('six As → activatie',            ['A','A','A','A','A','A'], 'activatie');
    test('4 As + 2 Bs → activatie',       ['A','A','A','A','B','B'], 'activatie');
    test('4 As + 2 Cs → activatie',       ['A','A','A','A','C','C'], 'activatie');

    // 4+ B → uitschakeling
    test('six Bs → uitschakeling',        ['B','B','B','B','B','B'], 'uitschakeling');
    test('4 Bs + 2 As → uitschakeling',   ['B','B','B','B','A','A'], 'uitschakeling');
    test('4 Bs + 2 Cs → uitschakeling',   ['B','B','B','B','C','C'], 'uitschakeling');

    // 2+ A AND 2+ B (no C dominance) → wisselend
    test('3A + 3B → wisselend',           ['A','A','A','B','B','B'], 'wisselend');
    test('2A + 2B + 2C (no C ≥ 4) → wisselend', ['A','A','B','B','C','C'], 'wisselend');
    test('3A + 2B + 1C → wisselend',      ['A','A','A','B','B','C'], 'wisselend');

    // A > B with no 4+ dominance → activatie
    test('3A + 1B + 2C → activatie',      ['A','A','A','B','C','C'], 'activatie');
    test('2A + 1B + 3C (2As edge: no wisselend) → activatie', ['A','A','B','C','C','C'], 'activatie');

    // B > A with no 4+ dominance → uitschakeling
    test('3B + 1A + 2C → uitschakeling',  ['B','B','B','A','C','C'], 'uitschakeling');
    test('2B + 1A + 3C → uitschakeling',  ['B','B','A','C','C','C'], 'uitschakeling');

    // Tied A == B, no dominance → wisselend (fallback)
    test('2A + 2B + 2C tied → wisselend', ['A','A','B','B','C','C'], 'wisselend');

    // ====================================================
    // Summary
    // ====================================================
    summary.className = 'summary ' + (failed === 0 ? 'pass' : 'fail');
    summary.textContent = `${passed} passed · ${failed} failed`;
  </script>
</body>
</html>
```

- [ ] **Step 2: Open `tests/scoring.test.html` in a browser and verify all tests FAIL**

Run: open the file directly.
Expected: red "✗" next to every assertion, summary shows "0 passed · 17 failed".

- [ ] **Step 3: Replace the placeholder with the real scoring function**

In `tests/scoring.test.html`, replace the PLACEHOLDER comment block and `bepaalStand` function with this implementation:

```javascript
function bepaalStand(answers) {
  const counts = { A: 0, B: 0, C: 0 };
  for (const a of answers) counts[a]++;

  if (counts.C >= 4) return 'gereguleerd';
  if (counts.A >= 4) return 'activatie';
  if (counts.B >= 4) return 'uitschakeling';
  if (counts.A >= 2 && counts.B >= 2) return 'wisselend';
  if (counts.A > counts.B) return 'activatie';
  if (counts.B > counts.A) return 'uitschakeling';
  return 'wisselend';
}
```

- [ ] **Step 4: Reload the test harness and verify all tests PASS**

Expected: every row green "✓", summary "17 passed · 0 failed".

- [ ] **Step 5: Commit**

```bash
git add tests/scoring.test.html
git commit -m "test: scoring function with 17 assertions covering all stand outcomes"
```

---

## Task 6: Test interaction — click handlers, question flow, result render, reset

**Files:**
- Modify: `index.html` — replace the empty `<script>` block.

- [ ] **Step 1: Replace the `<script>` block at the bottom of `<body>` with the full interaction code**

```html
<script>
(() => {
  const testEl     = document.querySelector('.test');
  if (!testEl) return;

  const vragen     = testEl.querySelectorAll('.vraag');
  const resultaten = testEl.querySelectorAll('.resultaat');
  const dots       = testEl.querySelectorAll('.test-dot');
  const counter    = testEl.querySelector('.test-count');
  const opnieuwBtn = testEl.querySelector('.opnieuw');
  const testFoot   = testEl.querySelector('.test-foot');
  const totaal     = vragen.length;

  const answers = [];
  let currentQ  = 0;

  // ----- Scoring (duplicate of tests/scoring.test.html) -----
  function bepaalStand(list) {
    const counts = { A: 0, B: 0, C: 0 };
    for (const a of list) counts[a]++;
    if (counts.C >= 4) return 'gereguleerd';
    if (counts.A >= 4) return 'activatie';
    if (counts.B >= 4) return 'uitschakeling';
    if (counts.A >= 2 && counts.B >= 2) return 'wisselend';
    if (counts.A > counts.B) return 'activatie';
    if (counts.B > counts.A) return 'uitschakeling';
    return 'wisselend';
  }

  // ----- UI update helpers -----
  function updateDots(activeIndex, doneCount) {
    dots.forEach((d, i) => {
      d.classList.remove('is-active', 'is-done');
      if (i < doneCount)          d.classList.add('is-done');
      else if (i === activeIndex) d.classList.add('is-active');
    });
  }

  function updateCounter(n) {
    const pad = v => String(v).padStart(2, '0');
    counter.textContent = `${pad(n)} / ${pad(totaal)}`;
  }

  function showVraag(index) {
    vragen.forEach((v, i) => v.classList.toggle('is-active', i === index));
    resultaten.forEach(r => r.classList.remove('is-active'));
    updateDots(index, index);
    updateCounter(index + 1);
    opnieuwBtn.hidden = true;
    testFoot.hidden = false;
  }

  function showResult() {
    vragen.forEach(v => v.classList.remove('is-active'));
    const stand = bepaalStand(answers);
    const target = testEl.querySelector(`.resultaat[data-resultaat="${stand}"]`);
    if (target) target.classList.add('is-active');
    updateDots(-1, totaal);
    updateCounter(totaal);
    opnieuwBtn.hidden = false;
    testFoot.hidden = true;
    // Auto-scroll added in Task 7
  }

  // ----- Event wiring -----
  vragen.forEach((vraag, index) => {
    vraag.querySelectorAll('button[data-stand]').forEach(btn => {
      btn.addEventListener('click', () => {
        answers[index] = btn.dataset.stand;
        if (index < totaal - 1) {
          currentQ = index + 1;
          showVraag(currentQ);
        } else {
          showResult();
        }
      });
    });
  });

  opnieuwBtn.addEventListener('click', () => {
    answers.length = 0;
    currentQ = 0;
    showVraag(0);
    testEl.scrollIntoView({ behavior: 'smooth', block: 'start' });
  });
})();
</script>
```

- [ ] **Step 2: Manual test — "activatie" path**

Reload. Click option 1 ("Opgejaagd, hart klopt…") on every question (answers A,A,A,A,A,A).
Expected: after the sixth click, question 6 disappears, the "Verhoogde activatie" result appears in the same space, all six dots turn terracotta, counter shows `06 / 06`, "← Test opnieuw doen" appears, the "niks wordt opgeslagen" footnote hides.

- [ ] **Step 3: Manual test — "uitschakeling" path**

Click the reset button, then answer B,B,B,B,B,B.
Expected: "Uitschakeling" badge appears with cool-blue color. Oefeningen include "5-4-3 grondingsoefening".

- [ ] **Step 4: Manual test — "wisselend" path**

Reset, then answer A,A,A,B,B,B.
Expected: "Wisselend patroon" result with warm-terracotta badge.

- [ ] **Step 5: Manual test — "gereguleerd" path**

Reset, then answer C,C,C,C,C,C.
Expected: "Binnen je raam" result with green badge. Softer CTA copy. Button reads "Stel je vraag →".

- [ ] **Step 6: Manual test — reset clears state**

After any completion, click "← Test opnieuw doen".
Expected: question 1 is shown, dots reset, counter shows `01 / 06`. Page smooth-scrolls to the test. Old answers are cleared (verified implicitly — answering differently on run 2 should give a different result).

- [ ] **Step 7: Commit**

```bash
git add index.html
git commit -m "feat: test interaction — question flow, scoring, result render, reset"
```

---

## Task 7: Cinematic auto-scroll to CTA on test completion

**Files:**
- Modify: `index.html` — extend the `<script>` block with a custom scroll helper and call it from `showResult()`.

- [ ] **Step 1: Add the scroll helper inside the IIFE, above `showVraag`**

Insert after the `bepaalStand` function, still inside the IIFE:

```javascript
  // ----- Smooth scroll with custom easing -----
  function easeOutExpo(t) {
    return t === 1 ? 1 : 1 - Math.pow(2, -10 * t);
  }

  function smoothScrollTo(targetY, duration = 1800) {
    const startY = window.pageYOffset;
    const distance = targetY - startY;
    const start = performance.now();

    function step(now) {
      const elapsed = now - start;
      const t = Math.min(elapsed / duration, 1);
      window.scrollTo(0, startY + distance * easeOutExpo(t));
      if (t < 1) requestAnimationFrame(step);
    }
    requestAnimationFrame(step);
  }

  function scrollToCTA() {
    const cta = document.querySelector('#intake');
    if (!cta) return;
    const reduceMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    const targetY = cta.getBoundingClientRect().top + window.pageYOffset - 80;

    if (reduceMotion) {
      window.scrollTo(0, targetY);
    } else {
      smoothScrollTo(targetY, 1800);
    }
  }
```

- [ ] **Step 2: Call `scrollToCTA()` after the result renders**

In `showResult`, replace the `// Auto-scroll added in Task 7` comment with:

```javascript
    // Delay one frame so the result's fadeIn animation starts before we scroll
    requestAnimationFrame(() => scrollToCTA());
```

- [ ] **Step 3: Manual test — scroll behavior**

Reload. Note the CTA block isn't built yet — for this task, temporarily add a placeholder `<section id="intake" style="min-height:300px;background:#1A2F25;color:#fff;padding:80px 32px;margin-top:400px;">CTA PLACEHOLDER</section>` inside `<body>` above the existing `<script>` tag.

Answer 6 questions on any path.
Expected: after the last click, the result appears, then the page scrolls smoothly over ~1.8s with a decelerating ease, coming to rest with the CTA placeholder 80px from the top of the viewport.

- [ ] **Step 4: Test `prefers-reduced-motion`**

In DevTools → Rendering → "Emulate CSS media feature prefers-reduced-motion: reduce". Reset the test, answer 6 questions.
Expected: the result appears and the page jumps directly to the CTA with no animation.

- [ ] **Step 5: Remove the placeholder CTA block**

Delete the temporary `<section id="intake">…CTA PLACEHOLDER…</section>` element. The real CTA comes in Task 9 and will use the same `#intake` id — scroll will work without further JS changes.

- [ ] **Step 6: Commit**

```bash
git add index.html
git commit -m "feat: cinematic auto-scroll to intake CTA after test completion"
```

---

## Task 8: Content sections § 01–05 (Anatomie, Patronen, Evidence, Praktijk, Grenzen)

**Files:**
- Modify: `index.html` — fill the five `<section class="article">` blocks and the `.secondary-intro` div; append CSS.

- [ ] **Step 1: Fill the `.secondary-intro` div**

Replace the `<!-- transition from test to content (Task 8) -->` comment with:

```html
<div class="secondary-intro">
  <div class="chapter-label">Na de test</div>
  <p class="secondary-lead">Wil je weten waar het op gebaseerd is? Hier is de <em>korte, eerlijke versie</em>. Geen TikTok-mythes, wel wat werkt.</p>
</div>
```

- [ ] **Step 2: Fill `<section class="article" id="anatomie">`**

```html
<section class="article" id="anatomie" aria-labelledby="anatomie-title">
  <div class="chapter-label">§ 01 &nbsp; Anatomie</div>
  <h2 id="anatomie-title">Wat is de nervus vagus eigenlijk?</h2>
  <div class="body">
    <p>De tiende hersenzenuw. Hij loopt vanaf je hersenstam omlaag — langs keel, door borstkas, tot diep in je buik. Onderweg raakt hij vrijwel elk belangrijk orgaan: hart, longen, maag, darmen.</p>
    <p>Je kunt de nervus vagus niet 'aanzetten' zoals een lichtknop. Maar hij is wél de kabel waarlangs je kalmte- en herstelsysteem — het parasympathische deel — met je organen communiceert. Als die communicatie verstoord raakt, voel je dat in je hele lichaam.</p>
    <blockquote class="pull">Geen knopje, maar wel de hoofdsnelweg waarlangs je systeem leert wanneer er gevaar is, en wanneer er ruimte is om te herstellen.</blockquote>
  </div>
</section>
```

- [ ] **Step 3: Fill `<section class="article" id="patronen">`**

```html
<section class="article" id="patronen" aria-labelledby="patronen-title">
  <div class="chapter-label">§ 02 &nbsp; Patronen</div>
  <h2 id="patronen-title">Drie standen van je zenuwstelsel</h2>
  <div class="body">
    <p>Een ontregeld zenuwstelsel ziet er niet bij iedereen hetzelfde uit. Ruwweg zijn er drie patronen.</p>

    <div class="standen">
      <div class="stand stand--1">
        <div class="stand-num">01</div>
        <h3>Verhoogde activatie</h3>
        <div class="stand-sub">Vecht · vlucht</div>
        <ul>
          <li>Hartkloppingen zonder aanleiding</li>
          <li>Onrust, opgejaagd gevoel</li>
          <li>Slecht inslapen</li>
          <li>Korte lont</li>
          <li>Spanning in kaak, nek, schouders</li>
        </ul>
      </div>

      <div class="stand stand--2">
        <div class="stand-num">02</div>
        <h3>Uitschakeling</h3>
        <div class="stand-sub">Bevriezing</div>
        <ul>
          <li>Leeg gevoel, afwezigheid</li>
          <li>Zware armen en benen</li>
          <li>Moeite op gang te komen</li>
          <li>Sociale terugtrekking</li>
          <li>Vermoeidheid die slapen niet oplost</li>
        </ul>
      </div>

      <div class="stand stand--3">
        <div class="stand-num">03</div>
        <h3>Binnen je raam</h3>
        <div class="stand-sub">Gereguleerd</div>
        <ul>
          <li>Voelt wat je voelt, wordt niet overspoeld</li>
          <li>Inspanning en rust wisselen af</li>
          <li>Slaap is herstellend</li>
          <li>Emoties komen en gaan</li>
        </ul>
      </div>
    </div>

    <p style="margin-top:32px;">De eerste twee wisselen zich bij veel mensen af. Overdag opgejaagd, 's avonds leeg op de bank. Dat is geen zwakte — een zenuwstelsel dat te lang op scherp heeft gestaan.</p>
  </div>
</section>
```

- [ ] **Step 4: Fill `<section class="article" id="evidence">`**

```html
<section class="article" id="evidence" aria-labelledby="evidence-title">
  <div class="chapter-label">§ 03 &nbsp; Evidence</div>
  <h2 id="evidence-title">Wat werkt echt — en wat is hype?</h2>
  <div class="body">
    <p>Een eerlijke doorloop van wat er online circuleert.</p>

    <div class="verdicts">
      <div class="verdict-row">
        <div class="verdict-stamp verdict-stamp--bewezen">bewezen</div>
        <div>
          <div class="verdict-topic">Verlengde uitademing</div>
          <div class="verdict-body">Het bewijs is hier het stevigst. Langer uitademen dan inademen activeert aantoonbaar het parasympathische systeem. Basis van elke serieuze aanpak — werkt voor bijna iedereen.</div>
        </div>
      </div>

      <div class="verdict-row">
        <div class="verdict-stamp verdict-stamp--gedeeltelijk">gedeeltelijk</div>
        <div>
          <div class="verdict-topic">Neuriën, zingen, gorgelen</div>
          <div class="verdict-body">Trillingen in het strottenhoofd raken delen van het vagus-systeem. Onschadelijk, prettig ritueel — maar vervangt geen serieuze aanpak.</div>
        </div>
      </div>

      <div class="verdict-row">
        <div class="verdict-stamp verdict-stamp--gedeeltelijk">niet eerste stap</div>
        <div>
          <div class="verdict-topic">IJsbaden, koude douches</div>
          <div class="verdict-body">Kunnen alertheid verhogen. Voor een ontregeld zenuwstelsel zónder voorbereiding vaak té activerend.</div>
        </div>
      </div>

      <div class="verdict-row">
        <div class="verdict-stamp verdict-stamp--hype">hype</div>
        <div>
          <div class="verdict-topic">Wim Hof, vagus-apparaten, biohacks</div>
          <div class="verdict-body">Niet per se schadelijk. Maar voor écht ontregelde zenuwstelsels te groot geschut, te vroeg in het proces.</div>
        </div>
      </div>

      <div class="verdict-row">
        <div class="verdict-stamp verdict-stamp--bewezen">ondergewaardeerd</div>
        <div>
          <div class="verdict-topic">Beweging, buiten zijn, rustige mensen</div>
          <div class="verdict-body">Saaier dan een ijsbad. Werkt voor bijna iedereen.</div>
        </div>
      </div>
    </div>
  </div>
</section>
```

- [ ] **Step 5: Fill `<section class="article" id="praktijk">`**

```html
<section class="article" id="praktijk" aria-labelledby="praktijk-title">
  <div class="chapter-label">§ 04 &nbsp; Praktijk</div>
  <h2 id="praktijk-title">Drie oefeningen die je nu kunt doen</h2>
  <div class="body">

    <div class="oefening">
      <div class="oefening-num">01</div>
      <div>
        <h3>Bij verhoogde activatie — de 4-6 ademhaling</h3>
        <p class="oefening-how">Adem 4 seconden in door je neus. Adem 6 seconden uit door je mond, alsof je een kaars laat flakkeren zonder hem uit te blazen. Herhaal 5 minuten.</p>
        <p class="oefening-why">De verlengde uitademing is de actieve component. Niet je telefoon erbij. Geen muziek. Gewoon dit.</p>
      </div>
    </div>

    <div class="oefening">
      <div class="oefening-num">02</div>
      <div>
        <h3>Bij uitschakeling — gronden en bewegen</h3>
        <p class="oefening-how">Beide voeten plat op de grond. Duw je hielen zacht omlaag. Benoem 5 dingen die je ziet, 4 die je hoort, 3 die je voelt. Sta daarna op en beweeg een minuut.</p>
        <p class="oefening-why">Niet om te ontspannen — om je systeem uit de vriesstand te krijgen.</p>
      </div>
    </div>

    <div class="oefening">
      <div class="oefening-num">03</div>
      <div>
        <h3>Voor onderhoud — de dagelijkse reset</h3>
        <p class="oefening-how">Twee keer per dag, 3 minuten. Zit of lig, adem langzaam, geen telefoon, niks erbij.</p>
        <p class="oefening-why">De saaiste oefening en de krachtigste. Je traint je systeem dat 'niks doen' veilig is.</p>
      </div>
    </div>

  </div>
</section>
```

- [ ] **Step 6: Fill `<section class="article" id="grenzen">`**

```html
<section class="article" id="grenzen" aria-labelledby="grenzen-title">
  <div class="chapter-label">§ 05 &nbsp; Grenzen</div>
  <h2 id="grenzen-title">Wanneer zelf-regulatie niet meer lukt</h2>
  <div class="body">
    <p>Zelf oefenen heeft grenzen. Als je meer dan een paar weken in dezelfde patronen vastzit, als slaap niet beter wordt, als klachten werk of relaties in de weg zitten — dan heb je iets anders nodig dan een YouTube-video.</p>
    <p>In de praktijk kijken we samen wat er in jouw zenuwstelsel speelt. We werken met ademhaling, beweging, aandacht voor wat je lichaam vertelt. Geen ijsbad, geen quick fix. Wel een traject dat bij jou past, met meetbare stappen.</p>
  </div>
</section>
```

- [ ] **Step 7: Append section CSS to the `<style>` block**

```css
/* =============================================================
   SECONDARY INTRO + ARTICLE SECTIONS (§ 01-05)
   ============================================================= */
.secondary-intro {
  margin-top: 120px;
  padding-top: 48px;
  border-top: 1px solid var(--line);
  display: grid;
  grid-template-columns: 180px 1fr;
  gap: 48px;
  align-items: start;
}

.chapter-label {
  font-family: 'Inter', sans-serif;
  font-size: 12px;
  letter-spacing: 0.15em;
  text-transform: uppercase;
  color: var(--ink-faint);
}

.secondary-lead {
  font-family: 'Fraunces', serif;
  font-variation-settings: "opsz" 60;
  font-weight: 400;
  font-size: clamp(22px, 2.4vw, 30px);
  line-height: 1.3;
  letter-spacing: -0.01em;
  color: var(--ink);
  max-width: 32ch;
  margin: 0;
}

.secondary-lead em {
  font-style: italic;
  color: var(--accent);
}

section.article {
  padding: 80px 0;
  border-bottom: 1px solid var(--line-fine);
  display: grid;
  grid-template-columns: 180px 1fr;
  gap: 48px;
  align-items: start;
}

section.article h2 {
  font-family: 'Fraunces', serif;
  font-variation-settings: "opsz" 90, "SOFT" 30;
  font-weight: 400;
  font-size: clamp(32px, 4vw, 48px);
  line-height: 1.1;
  letter-spacing: -0.02em;
  color: var(--ink);
  max-width: 18ch;
  grid-column: 2;
  margin: 0 0 24px;
}

section.article .body {
  grid-column: 2;
  max-width: 62ch;
}

section.article .chapter-label {
  grid-column: 1;
  grid-row: 1;
  position: sticky;
  top: 32px;
}

section.article p {
  margin-bottom: 16px;
  font-size: 17px;
  color: var(--ink-soft);
  max-width: 62ch;
}

blockquote.pull {
  margin: 32px 0;
  padding-left: 24px;
  border-left: 2px solid var(--accent);
  font-family: 'Fraunces', serif;
  font-variation-settings: "opsz" 60;
  font-style: italic;
  font-size: 24px;
  line-height: 1.3;
  color: var(--ink);
  max-width: 36ch;
}

/* Drie standen grid */
.standen {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1px;
  background: var(--line-fine);
  margin-top: 32px;
}

.stand {
  background: var(--paper);
  padding: 32px 24px;
}

.stand-num {
  font-family: 'Fraunces', serif;
  font-variation-settings: "opsz" 144;
  font-weight: 300;
  font-size: 48px;
  line-height: 1;
  margin-bottom: 12px;
  letter-spacing: -0.03em;
}

.stand--1 .stand-num { color: var(--accent); }
.stand--2 .stand-num { color: var(--accent-cool); }
.stand--3 .stand-num { color: var(--accent-green); }

.stand h3 {
  font-family: 'Fraunces', serif;
  font-variation-settings: "opsz" 60;
  font-weight: 400;
  font-size: 22px;
  line-height: 1.2;
  margin: 0 0 4px;
  color: var(--ink);
  letter-spacing: -0.01em;
}

.stand-sub {
  font-family: 'Inter', sans-serif;
  font-size: 13px;
  letter-spacing: 0.05em;
  text-transform: uppercase;
  color: var(--ink-faint);
  margin-bottom: 16px;
}

.stand ul { list-style: none; padding: 0; margin: 0; }

.stand li {
  padding: 8px 0;
  border-bottom: 1px solid var(--line-fine);
  font-size: 14px;
  color: var(--ink-soft);
}

.stand li:last-child { border-bottom: none; }

/* Verdict rows */
.verdicts { margin-top: 32px; }

.verdict-row {
  display: grid;
  grid-template-columns: 140px 1fr;
  gap: 32px;
  padding: 28px 0;
  border-top: 1px solid var(--line-fine);
}

.verdict-stamp {
  font-family: 'Fraunces', serif;
  font-variation-settings: "opsz" 60;
  font-style: italic;
  font-weight: 400;
  font-size: 20px;
  color: var(--ink);
  display: flex;
  align-items: baseline;
  gap: 8px;
}

.verdict-stamp::before {
  content: '';
  width: 16px;
  height: 1px;
  background: currentColor;
  display: inline-block;
}

.verdict-stamp--bewezen       { color: var(--accent-green); }
.verdict-stamp--hype          { color: var(--ink-faint); }
.verdict-stamp--gedeeltelijk  { color: var(--accent); }

.verdict-topic {
  font-family: 'Inter', sans-serif;
  font-weight: 600;
  font-size: 18px;
  margin-bottom: 4px;
  color: var(--ink);
}

.verdict-body {
  font-family: 'Inter', sans-serif;
  font-size: 15px;
  color: var(--ink-soft);
  max-width: 62ch;
}

/* Oefeningen */
.oefening {
  padding: 32px 0;
  border-top: 1px solid var(--line-fine);
  display: grid;
  grid-template-columns: 48px 1fr;
  gap: 32px;
}

.oefening-num {
  font-family: 'Fraunces', serif;
  font-variation-settings: "opsz" 144;
  font-weight: 300;
  font-size: 36px;
  color: var(--accent);
  line-height: 1;
}

.oefening h3 {
  font-family: 'Fraunces', serif;
  font-variation-settings: "opsz" 60;
  font-weight: 400;
  font-size: 22px;
  letter-spacing: -0.01em;
  margin: 0 0 12px;
  color: var(--ink);
}

.oefening-how {
  font-size: 16px;
  color: var(--ink-soft);
  margin: 0 0 8px;
  max-width: 56ch;
}

.oefening-why {
  font-size: 14px;
  color: var(--ink-faint);
  font-style: italic;
  font-family: 'Fraunces', serif;
  font-variation-settings: "opsz" 14;
  margin: 0;
}

/* Mobile: collapse grids */
@media (max-width: 720px) {
  .secondary-intro,
  section.article { grid-template-columns: 1fr; gap: 16px; }

  section.article .chapter-label { position: static; grid-column: 1; grid-row: auto; margin-bottom: 8px; }
  section.article h2 { grid-column: 1; }
  section.article .body { grid-column: 1; }

  .standen { grid-template-columns: 1fr; }
  .verdict-row { grid-template-columns: 1fr; gap: 8px; }

  .secondary-intro { margin-top: 80px; }
  section.article { padding: 48px 0; }
}
```

- [ ] **Step 8: Verify visually**

Reload. Scroll down past the test.
Expected:
- Transition block with "Na de test" label on the left, italic-accented lead on the right.
- Five chapter sections, each with a sticky `§ 0X` label on the left while the reader scrolls through the section body.
- Anatomie: prose + left-bordered italic pull quote.
- Patronen: three-column card grid with colored numerals (01 terracotta, 02 blue-gray, 03 green).
- Evidence: five verdict rows with italic lowercase stamps in green / faint-gray / terracotta.
- Praktijk: three numbered oefeningen.
- Grenzen: prose only.
- On narrow viewport (<720px), all grids collapse to single column, chapter labels sit above the H2.

- [ ] **Step 9: Commit**

```bash
git add index.html
git commit -m "feat: content sections §01–§05 with editorial grid layout"
```

---

## Task 9: Full-bleed CTA block

**Files:**
- Modify: `index.html` — fill the `<section class="cta" id="intake">` block; append CSS.

- [ ] **Step 1: Fill `<section class="cta" id="intake">`**

Replace the `<!-- dark CTA block, escapes the .wrap container via margin trick (Task 9) -->` comment with:

```html
<section class="cta" id="intake" aria-labelledby="cta-title">
  <div class="cta-wrap">
    <p class="cta-eyebrow">Vrijblijvende intake · 30 minuten</p>
    <h2 id="cta-title" class="cta-title">Herken je <em>jezelf</em> in dit verhaal?</h2>
    <p class="cta-body">In dertig minuten kijken we samen of deze aanpak bij jou past. Geen verkoop, geen verplichting. Alleen kijken.</p>
    <a href="https://www.psychosomatischefysio.nl/neem-contact-op" target="_blank" rel="noopener" class="btn-primary">
      Plan een intake <span class="arrow" aria-hidden="true">→</span>
    </a>
  </div>
</section>
```

- [ ] **Step 2: Append CTA CSS**

```css
/* =============================================================
   FULL-BLEED CTA
   ============================================================= */
section.cta {
  background: var(--paper-deep);
  color: var(--paper);
  padding: 120px 0;
  position: relative;
  margin-top: 80px;
}

section.cta::before {
  content: '';
  position: absolute;
  inset: 0;
  background-image: url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='200' height='200'><filter id='n'><feTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='2' stitchTiles='stitch'/><feColorMatrix values='0 0 0 0 0.9 0 0 0 0 0.85 0 0 0 0 0.7 0 0 0 0.1 0'/></filter><rect width='100%25' height='100%25' filter='url(%23n)'/></svg>");
  pointer-events: none;
  opacity: 0.6;
}

.cta-wrap {
  max-width: 1280px;
  margin: 0 auto;
  padding: 0 32px;
  position: relative;
  z-index: 1;
}

.cta-eyebrow {
  font-family: 'Inter', sans-serif;
  font-size: 12px;
  letter-spacing: 0.15em;
  text-transform: uppercase;
  color: rgba(238, 231, 214, 0.55);
  margin-bottom: 24px;
}

.cta-title {
  font-family: 'Fraunces', serif;
  font-variation-settings: "opsz" 144, "SOFT" 30;
  font-weight: 300;
  font-size: clamp(40px, 6vw, 76px);
  line-height: 1.05;
  letter-spacing: -0.025em;
  color: var(--paper);
  max-width: 18ch;
  margin: 0 0 32px;
}

.cta-title em {
  font-style: italic;
  color: var(--accent);
  font-weight: 400;
}

.cta-body {
  font-family: 'Inter', sans-serif;
  font-size: 17px;
  color: rgba(238, 231, 214, 0.75);
  max-width: 48ch;
  margin-bottom: 48px;
}

.btn-primary {
  display: inline-flex;
  align-items: center;
  gap: 16px;
  padding: 20px 32px;
  background: var(--paper);
  color: var(--ink);
  font-family: 'Inter', sans-serif;
  font-weight: 500;
  font-size: 17px;
  text-decoration: none;
  transition: all 240ms cubic-bezier(.4, 0, .2, 1);
}

.btn-primary:hover,
.btn-primary:focus-visible {
  background: var(--accent);
  color: var(--paper);
}

.btn-primary .arrow {
  font-family: 'Fraunces', serif;
  font-style: italic;
  font-size: 20px;
}

@media (max-width: 720px) {
  section.cta { padding: 72px 0; margin-top: 48px; }
}
```

- [ ] **Step 3: Verify visually + auto-scroll integration**

Reload. Scroll to the bottom of the content. Expected: dark forest-green block spans the full viewport width (not constrained by 1280px wrap), grain overlay visible at low opacity, uppercase eyebrow, huge serif title with warm-italic "jezelf", supporting paragraph, paper-colored button. Hover button: fills warm terracotta.

Then: scroll to top, complete the 6-question test on any path. Expected: after the last click, the result renders inline, the page smoothly scrolls for ~1.8s and comes to rest with the dark CTA block 80px from the top of the viewport.

- [ ] **Step 4: Commit**

```bash
git add index.html
git commit -m "feat: full-bleed CTA block with grain overlay and primary button"
```

---

## Task 10: FAQ and footer

**Files:**
- Modify: `index.html` — fill `<section class="faq-wrap">` and `<footer class="site-foot">`; append CSS.

- [ ] **Step 1: Fill `<section class="faq-wrap">`**

Replace the `<!-- § 06 Vragen (Task 10) -->` comment with:

```html
<section class="faq-wrap" aria-labelledby="faq-title">
  <div class="chapter-label">§ 06 &nbsp; Vragen</div>
  <div class="faq-list">
    <h2 id="faq-title">Veelgestelde vragen</h2>

    <details class="faq" open>
      <summary>Wat is een ontregeld zenuwstelsel precies?</summary>
      <p>Een autonoom zenuwstelsel dat te vaak en te lang in vecht-vlucht of bevriezing zit, en steeds slechter terugschakelt naar rust. Dat veroorzaakt klachten als hartkloppingen, slapeloosheid, uitputting of een 'leeg' gevoel.</p>
    </details>

    <details class="faq">
      <summary>Kan ik mijn nervus vagus zelf trainen?</summary>
      <p>Tot op zekere hoogte ja — verlengde uitademing en regelmatige ontspanningsmomenten beïnvloeden je kalmtesysteem aantoonbaar. Maar bij langdurige ontregeling is begeleiding meestal effectiever dan zelf-experimenteren.</p>
    </details>

    <details class="faq">
      <summary>Werkt een ijsbad echt voor de nervus vagus?</summary>
      <p>Het effect wordt online overdreven. Voor wie al ontregeld is, kan koude exposure zelfs averechts werken. Begin altijd met ademhaling.</p>
    </details>

    <details class="faq">
      <summary>Wordt de behandeling vergoed?</summary>
      <p>Psychosomatische fysiotherapie wordt vanaf 18 jaar vergoed via de aanvullende verzekering. Onder de 18 via de basisverzekering. Check je polis.</p>
    </details>

    <details class="faq">
      <summary>Hoeveel sessies heb ik gemiddeld nodig?</summary>
      <p>De meeste trajecten duren 8 tot 16 sessies, verspreid over 3 tot 6 maanden. Bij de intake schatten we samen wat passend is.</p>
    </details>
  </div>
</section>
```

- [ ] **Step 2: Fill `<footer class="site-foot">`**

Replace the `<!-- footer (Task 10) -->` comment with:

```html
<footer class="site-foot" role="contentinfo">
  <div>zenuwstelsel.com · een zenuwstelsel-check</div>
  <div>Jaap Leemeijer · BIG: 09925473804 · Psychosomatische fysiotherapie</div>
</footer>
```

- [ ] **Step 3: Append FAQ + footer CSS**

```css
/* =============================================================
   FAQ
   ============================================================= */
section.faq-wrap {
  padding: 80px 0;
  display: grid;
  grid-template-columns: 180px 1fr;
  gap: 48px;
}

section.faq-wrap .chapter-label {
  grid-column: 1;
  position: sticky;
  top: 32px;
}

section.faq-wrap .faq-list { grid-column: 2; }

section.faq-wrap h2 {
  font-family: 'Fraunces', serif;
  font-variation-settings: "opsz" 90, "SOFT" 30;
  font-weight: 400;
  font-size: clamp(32px, 4vw, 48px);
  letter-spacing: -0.02em;
  margin: 0 0 24px;
}

details.faq {
  border-top: 1px solid var(--line-fine);
  padding: 24px 0;
}

details.faq:last-child { border-bottom: 1px solid var(--line-fine); }

details.faq summary {
  font-family: 'Fraunces', serif;
  font-variation-settings: "opsz" 60;
  font-weight: 400;
  font-size: 22px;
  color: var(--ink);
  cursor: pointer;
  list-style: none;
  display: flex;
  justify-content: space-between;
  align-items: baseline;
  gap: 24px;
}

details.faq summary::-webkit-details-marker { display: none; }

details.faq summary::after {
  content: '+';
  font-family: 'Fraunces', serif;
  font-weight: 300;
  font-size: 32px;
  color: var(--accent);
  transition: transform 240ms ease;
  line-height: 1;
  flex-shrink: 0;
}

details.faq[open] summary::after { transform: rotate(45deg); }

details.faq p {
  margin-top: 16px;
  font-size: 16px;
  color: var(--ink-soft);
  max-width: 62ch;
}

/* =============================================================
   FOOTER
   ============================================================= */
footer.site-foot {
  padding: 48px 0 72px;
  border-top: 1px solid var(--line-fine);
  display: flex;
  justify-content: space-between;
  font-family: 'Inter', sans-serif;
  font-size: 13px;
  color: var(--ink-faint);
}

@media (max-width: 720px) {
  section.faq-wrap { grid-template-columns: 1fr; gap: 16px; padding: 48px 0; }
  section.faq-wrap .chapter-label { position: static; grid-column: 1; }
  section.faq-wrap .faq-list { grid-column: 1; }

  footer.site-foot { flex-direction: column; gap: 24px; padding: 32px 0 48px; }
}
```

- [ ] **Step 4: Verify visually**

Reload. Scroll to the bottom.
Expected: FAQ block with sticky `§ 06 Vragen` label on the left, H2, and five `<details>` elements. First one is open. Clicking any summary: body expands, `+` smoothly rotates 45° to `×`. Clicking again: closes.
Footer: thin row with `zenuwstelsel.com · een zenuwstelsel-check` on the left, practitioner attribution on the right.

- [ ] **Step 5: Commit**

```bash
git add index.html
git commit -m "feat: FAQ with plus/x toggle and site footer"
```

---

## Task 11: Accessibility + SEO final pass

**Files:**
- Modify: `index.html` — add JSON-LD schema, verify accessibility attributes.

- [ ] **Step 1: Add JSON-LD schema inside `<head>`**

Insert just before the closing `</head>` tag (after the `<style>` block):

```html
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@graph": [
    {
      "@type": "MedicalWebPage",
      "@id": "https://zenuwstelsel.com/#page",
      "url": "https://zenuwstelsel.com/",
      "name": "In welke stand staat jouw zenuwstelsel?",
      "description": "Zelftest voor een ontregeld zenuwstelsel. Zes vragen, direct antwoord met oefeningen. Plus wat wél en wat níet werkt volgens onderzoek.",
      "inLanguage": "nl-NL",
      "about": {
        "@type": "AnatomicalStructure",
        "name": "Nervus vagus",
        "alternateName": "Vagus nerve"
      },
      "mainEntity": { "@id": "https://zenuwstelsel.com/#faq" },
      "author": { "@id": "https://zenuwstelsel.com/#practitioner" }
    },
    {
      "@type": "Person",
      "@id": "https://zenuwstelsel.com/#practitioner",
      "name": "Jaap Leemeijer",
      "jobTitle": "BIG-geregistreerd Psychosomatisch Fysiotherapeut",
      "hasCredential": {
        "@type": "EducationalOccupationalCredential",
        "name": "BIG: 09925473804"
      }
    },
    {
      "@type": "FAQPage",
      "@id": "https://zenuwstelsel.com/#faq",
      "mainEntity": [
        {
          "@type": "Question",
          "name": "Wat is een ontregeld zenuwstelsel precies?",
          "acceptedAnswer": {
            "@type": "Answer",
            "text": "Een autonoom zenuwstelsel dat te vaak en te lang in vecht-vlucht of bevriezing zit, en steeds slechter terugschakelt naar rust. Dat veroorzaakt klachten als hartkloppingen, slapeloosheid, uitputting of een 'leeg' gevoel."
          }
        },
        {
          "@type": "Question",
          "name": "Kan ik mijn nervus vagus zelf trainen?",
          "acceptedAnswer": {
            "@type": "Answer",
            "text": "Tot op zekere hoogte ja — verlengde uitademing en regelmatige ontspanningsmomenten beïnvloeden je kalmtesysteem aantoonbaar. Maar bij langdurige ontregeling is begeleiding meestal effectiever dan zelf-experimenteren."
          }
        },
        {
          "@type": "Question",
          "name": "Werkt een ijsbad echt voor de nervus vagus?",
          "acceptedAnswer": {
            "@type": "Answer",
            "text": "Het effect wordt online overdreven. Voor wie al ontregeld is, kan koude exposure zelfs averechts werken. Begin altijd met ademhaling."
          }
        },
        {
          "@type": "Question",
          "name": "Wordt de behandeling vergoed?",
          "acceptedAnswer": {
            "@type": "Answer",
            "text": "Psychosomatische fysiotherapie wordt vanaf 18 jaar vergoed via de aanvullende verzekering. Onder de 18 via de basisverzekering. Check je polis."
          }
        },
        {
          "@type": "Question",
          "name": "Hoeveel sessies heb ik gemiddeld nodig?",
          "acceptedAnswer": {
            "@type": "Answer",
            "text": "De meeste trajecten duren 8 tot 16 sessies, verspreid over 3 tot 6 maanden. Bij de intake schatten we samen wat passend is."
          }
        }
      ]
    }
  ]
}
</script>
```

- [ ] **Step 2: Validate the JSON-LD**

Copy the `<script type="application/ld+json">` content (just the JSON) and paste into https://validator.schema.org/ → "Validate".
Expected: "0 errors, 0 warnings". The MedicalWebPage, Person, and FAQPage entities all recognized.

- [ ] **Step 3: Accessibility audit — keyboard**

Reload the page. Press Tab repeatedly from the address bar.
Expected tab order:
1. Skip link (visually appears at top-left when focused)
2. First option button in question 1
3. Second option button
4. Third option button
5. Reset button (hidden until result, skip)
6. CTA intake link
7. First FAQ summary
8. ... other FAQ summaries ...

Every focused element shows a terracotta focus ring (2px outline, 3px offset).

Press Enter on the skip link.
Expected: focus jumps to `#main`.

- [ ] **Step 4: Accessibility audit — Lighthouse**

In Chrome DevTools → Lighthouse → check "Accessibility" only → Analyze page load.
Expected score: 95+. Any failures flagged should relate to off-page links (none should exist) or color contrast.

If color contrast on `.btn-primary` or `.resultaat-badge--activatie` fails, the badge/button text on the paper background may be too light. Fix by darkening the `--accent` slightly for text contexts (deferred unless Lighthouse flags).

- [ ] **Step 5: Manual screen reader check**

On macOS: enable VoiceOver (Cmd+F5). Refresh the page. VO+Right arrow to navigate.
On Windows: enable Narrator (Ctrl+Win+Enter).

Expected:
- Masthead: wordmark and practitioner attribution both read cleanly.
- Hero: H1 reads as "In welke stand staat jouw zenuwstelsel, heading level 1".
- Test: "Zes vragen…" lead, then progress described as "Voortgang, progressbar, 1 of 6". Question 1 heading announced on arrow-right.
- Clicking an option: counter announces new question number (via `aria-live="polite"`).
- Result: title announced as "Verhoogde activatie, heading level 2" (etc.).

- [ ] **Step 6: Commit**

```bash
git add index.html
git commit -m "feat: JSON-LD schema (MedicalWebPage, Person, FAQPage) + a11y verification"
```

---

## Task 12: Favicon, README, final cleanup

**Files:**
- Create: `favicon.svg`
- Create: `README.md`
- Modify: `index.html` (link favicon)
- Delete: `zelftest-zenuwstelsel.html`, `nervus-vagus-content.md` (no longer needed — spec and plan supersede)

- [ ] **Step 1: Create `favicon.svg`**

```xml
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64">
  <rect width="64" height="64" fill="#EEE7D6"/>
  <circle cx="32" cy="32" r="10" fill="#C66B5D"/>
</svg>
```

This is the breath-dot mark, scaled up. The brand wordmark is too small at 16px to read; the dot alone carries identity.

- [ ] **Step 2: Link the favicon in `index.html`**

Replace the `<!-- Favicon (added in later task) -->` comment in `<head>` with:

```html
<link rel="icon" type="image/svg+xml" href="/favicon.svg">
```

- [ ] **Step 3: Create `README.md`**

```markdown
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
```

- [ ] **Step 4: Delete legacy draft files**

Run:

```bash
rm "zelftest-zenuwstelsel.html" "nervus-vagus-content.md"
```

Expected: files removed. `git status` shows them as deleted.

- [ ] **Step 5: Final verification checklist**

Open `index.html` in a browser and walk through this checklist. Every item must pass.

- [ ] Page loads without console errors or 404s in the Network tab (other than favicon if served via `file://`).
- [ ] Fonts load (Fraunces + Inter). Fallback sans is not visible after fonts load.
- [ ] Above-fold: masthead, hero eyebrow, italic H1, lead, test component. No scroll needed to see the test.
- [ ] Breath-dot pulses continuously.
- [ ] Clicking through A,A,A,A,A,A reaches "Verhoogde activatie" result.
- [ ] Clicking through B,B,B,B,B,B reaches "Uitschakeling".
- [ ] Clicking through C,C,C,C,C,C reaches "Binnen je raam" with "Stel je vraag" button.
- [ ] Clicking through A,A,A,B,B,B reaches "Wisselend patroon".
- [ ] After completing the test, page auto-scrolls smoothly (~1.8s) to the CTA block.
- [ ] "← Test opnieuw doen" resets state and scrolls back to the test.
- [ ] Every result's intake button opens `psychosomatischefysio.nl/neem-contact-op` in a new tab.
- [ ] Content sections scroll normally, sticky chapter labels stay pinned while scrolling within a section.
- [ ] FAQ items open/close with animated `+` → `×` rotator.
- [ ] Footer renders cleanly.
- [ ] Mobile viewport (≤720px): all grids collapse to single column, the practitioner attribution in the masthead hides, test remains fully usable.
- [ ] `prefers-reduced-motion` emulated: no animations, auto-scroll becomes instant jump, breath-dot static.
- [ ] `tests/scoring.test.html` shows "17 passed · 0 failed".

- [ ] **Step 6: Commit**

```bash
git add favicon.svg README.md index.html
git rm zelftest-zenuwstelsel.html nervus-vagus-content.md
git commit -m "feat: favicon, README, remove legacy drafts"
```

---

## Self-Review

Before handoff, this plan has been checked against the spec:

**Spec coverage:**
- §1 Purpose → Task 1 (canonical meta), Task 11 (schema)
- §2.1 Masthead → Task 3
- §2.2 Hero → Tasks 3, 4
- §2.3 Test component → Tasks 4, 5, 6
- §2.4 Content sections → Task 8
- §2.5 CTA → Task 9
- §2.6 FAQ → Task 10
- §2.7 Footer → Task 10
- §3.1–3.3 Test logic + auto-scroll → Tasks 5, 6, 7
- §3.4 Result content per stand → Task 4
- §4 Visual system → Task 2 (tokens, base), spread across later tasks (per-component)
- §5 Component inventory → covered across Tasks 3–10
- §6.1–6.3 Architecture → Task 1 (single file), Task 12 (README)
- §6.4 Accessibility → Tasks 1 (skip link), 2 (focus), 4 (aria-live), 7 (reduced motion), 11 (audit)
- §6.5 SEO → Tasks 1 (meta), 11 (JSON-LD)
- §7 Out of scope → not implemented (correctly)

**Known implementation decisions worth flagging:**
- The scoring function is duplicated in `index.html` and `tests/scoring.test.html`. This is intentional: avoids a build step or ES module for a 10-line function. If scoring logic changes, update both and rerun the test harness.
- The `#intake` id is used by both the CTA block and the auto-scroll. The scroll target offset is 80px to leave breathing room at the top of the block.
- Color contrast is verified by Lighthouse in Task 11; if any contrast failures appear, the fix is scoped to adjusting `--accent` or related tokens.

---

## Execution Handoff

Plan complete and saved to `docs/superpowers/plans/2026-04-24-zenuwstelsel-implementation.md`. Two execution options:

**1. Subagent-Driven (recommended)** — I dispatch a fresh subagent per task, review between tasks, fast iteration.

**2. Inline Execution** — Execute tasks in this session using executing-plans, batch execution with checkpoints.

Which approach?
