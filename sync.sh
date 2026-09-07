#!/bin/sh
# Spiegel de bronbestanden naar build/ — de map die Hostinger serveert.
#
# build/ is een handmatige kopie, geen build-output. Vergeten te spiegelen
# betekent: commit gepusht, site onveranderd, en niemand die het merkt.
# Draai dit vóór elke commit.
#
#   ./sync.sh          spiegelt en meldt wat er veranderde
#   ./sync.sh --check  spiegelt niets, faalt als build/ achterloopt (voor CI)

set -e
cd "$(dirname "$0")"

FILES="index.html favicon.svg robots.txt sitemap.xml"

if [ "$1" = "--check" ]; then
  status=0
  for f in $FILES; do
    if ! cmp -s "$f" "build/$f"; then
      echo "ACHTERSTAND: build/$f wijkt af van $f"
      status=1
    fi
  done
  [ $status -eq 0 ] && echo "build/ is in sync."
  exit $status
fi

for f in $FILES; do
  if cmp -s "$f" "build/$f"; then
    echo "  ongewijzigd  $f"
  else
    cp "$f" "build/$f"
    echo "  gespiegeld   $f"
  fi
done
echo "build/ is bijgewerkt."
