#!/bin/sh
# Controleer of de live site draait wat er in deze repo staat.
#
# Waarom dit bestaat: de git-deploy van Hostinger heeft maandenlang stil
# gefaald. Commits landden op main, de site veranderde niet, en niemand
# merkte het — de live build stond vier maanden stil op 25 april 2026.
# Dat is de gevaarlijkste faalmodus van dit experiment: je denkt dat je
# meet wat je gewijzigd hebt, maar je meet de oude versie.
#
# Draai dit na elke deploy.
#
#   ./verify-live.sh

set -e
cd "$(dirname "$0")"
SITE="https://zenuwstelsel.com"
CB="$(date +%s)"
status=0

zeg() { printf '  %-34s %s\n' "$1" "$2"; }

echo "Live-controle $SITE"
echo

# 1. Draait de live homepage wat er op main staat?
#
# Hostinger deployt van main, niet van je huidige branch. Vergelijken met je
# werkmap geeft dus vals alarm zodra je op een feature branch zit. Daarom
# vergelijken we met de versie van build/index.html op origin/main, en zeggen
# we er apart bij of je lokaal vooruitloopt.
tmp="$(mktemp)"
ref="$(mktemp)"
curl -sS --max-time 30 "$SITE/?cb=$CB" -o "$tmp"

if git rev-parse --verify -q origin/main >/dev/null 2>&1 \
   && git show origin/main:build/index.html > "$ref" 2>/dev/null; then
  bron="origin/main"
else
  cp build/index.html "$ref"; bron="werkmap"
fi

if cmp -s "$tmp" "$ref"; then
  zeg "homepage = $bron" "ok"
else
  zeg "homepage = $bron" "AFWIJKING — deploy niet doorgekomen?"
  echo "     live: $(wc -c < "$tmp") bytes   $bron: $(wc -c < "$ref") bytes"
  status=1
fi

# Loopt de werkmap vooruit op main? Dan is dat geen storing maar ongemergd werk.
if [ "$bron" = "origin/main" ] && ! cmp -s build/index.html "$ref"; then
  zeg "werkmap vs origin/main" "wijkt af — ongemergd werk, niet live"
fi
rm -f "$tmp" "$ref"

# 2. Moeten 200 geven
for p in /robots.txt /sitemap.xml; do
  code="$(curl -sS -o /dev/null -w '%{http_code}' --max-time 20 "$SITE$p?cb=$CB")"
  [ "$code" = "200" ] && zeg "$p" "200" || { zeg "$p" "$code — verwacht 200"; status=1; }
done

# 3. Moeten 301 geven (canonicalisatie)
code="$(curl -sS -o /dev/null -w '%{http_code}' --max-time 20 https://www.zenuwstelsel.com/)"
[ "$code" = "301" ] && zeg "www -> apex" "301" || { zeg "www -> apex" "$code — verwacht 301"; status=1; }
code="$(curl -sS -o /dev/null -w '%{http_code}' --max-time 20 "$SITE/index.html")"
[ "$code" = "301" ] && zeg "/index.html -> /" "301" || { zeg "/index.html -> /" "$code — verwacht 301"; status=1; }

# 4. Bronbestanden mogen niet bereikbaar zijn
for p in /CHANGELOG.md /docs/master-prompt.md /data/baseline.md /tests/scoring.test.html /sync.sh; do
  code="$(curl -sS -o /dev/null -w '%{http_code}' --max-time 20 "$SITE$p")"
  [ "$code" = "404" ] && zeg "afgeschermd: $p" "404" || { zeg "afgeschermd: $p" "$code — LEK, verwacht 404"; status=1; }
done

echo
[ $status -eq 0 ] && echo "Alles in orde: de live site draait deze repo." \
                  || echo "Er klopt iets niet. Zie de regels hierboven."
exit $status
