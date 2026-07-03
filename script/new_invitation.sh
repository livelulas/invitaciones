#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 2 ]; then
  echo "Usage: $0 <slug> <title>"
  echo "Example: $0 maria-y-juan \"María & Juan\""
  exit 1
fi

SLUG="$1"
TITLE="$2"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

cp "$ROOT/src/_data/invitations/elena-armando.yml" "$ROOT/src/_data/invitations/${SLUG}.yml"
cp "$ROOT/frontend/styles/themes/elena-armando.css" "$ROOT/frontend/styles/themes/${SLUG}.css"
mkdir -p "$ROOT/src/images/invitations/${SLUG}"

cat > "$ROOT/src/_invitations/${SLUG}.md" <<EOF
---
layout: invitation
slug: ${SLUG}
title: ${TITLE}
---
EOF

ruby -i -pe "s/^slug: elena-armando\$/slug: ${SLUG}/; s/^title: Elena & Armando\$/title: ${TITLE}/" "$ROOT/src/_data/invitations/${SLUG}.yml"

if ! grep -q "themes/${SLUG}.css" "$ROOT/frontend/styles/index.css"; then
  echo "@import \"./themes/${SLUG}.css\";" >> "$ROOT/frontend/styles/index.css"
fi

echo "Created invitation scaffold: ${SLUG}"
echo "Next: edit src/_data/invitations/${SLUG}.yml and frontend/styles/themes/${SLUG}.css"
