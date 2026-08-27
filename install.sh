#!/usr/bin/env bash
# Instala a config de design (skills + ship-ui + CLAUDE.md + hooks impeccable)
# num alvo global (~/.claude) ou de projeto (<proj>/.claude).
#
#   ./install.sh                 -> global (~/.claude)
#   ./install.sh --project .     -> projeto no diretório atual
#   ./install.sh --project /path/repo
#
# Idempotente: rodar de novo só atualiza os arquivos.
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODE="global"
PROJ=""

while [ $# -gt 0 ]; do
  case "$1" in
    --global)  MODE="global"; shift ;;
    --project) MODE="project"; PROJ="${2:-.}"; shift 2 ;;
    -h|--help) sed -n '2,12p' "$0"; exit 0 ;;
    *) echo "arg desconhecido: $1" >&2; exit 1 ;;
  esac
done

if [ "$MODE" = "global" ]; then
  DEST="$HOME/.claude"
else
  DEST="$(cd "$PROJ" && pwd)/.claude"
fi
mkdir -p "$DEST/skills"

echo "→ alvo: $DEST"

# 1. skills (copia por cima, remove versões antigas de cada skill que enviamos)
for d in "$HERE"/skills/*/; do
  name="$(basename "$d")"
  rm -rf "$DEST/skills/$name"
  cp -R "$d" "$DEST/skills/$name"
done
echo "→ $(ls "$HERE"/skills | wc -l | tr -d ' ') skills instaladas em $DEST/skills"

# 2. bloco no CLAUDE.md (só adiciona se o marcador não existir)
touch "$DEST/CLAUDE.md"
if grep -q "ship-ui:start" "$DEST/CLAUDE.md"; then
  echo "→ CLAUDE.md já tem o bloco ship-ui (mantido)"
else
  printf '\n' >> "$DEST/CLAUDE.md"
  cat "$HERE/CLAUDE.snippet.md" >> "$DEST/CLAUDE.md"
  echo "→ bloco ship-ui adicionado ao $DEST/CLAUDE.md"
fi

# 3. hooks do impeccable — só no modo projeto (o comando usa CLAUDE_PROJECT_DIR)
if [ "$MODE" = "project" ]; then
  if command -v node >/dev/null 2>&1; then
    node "$HERE/install/merge-settings.mjs" "$DEST/settings.json" "$HERE/hooks/impeccable.hooks.json"
    echo "→ hooks impeccable mesclados em $DEST/settings.json"
  else
    echo "! node não encontrado — pule os hooks ou rode 'npx impeccable install' neste projeto" >&2
  fi
else
  echo "→ modo global: hooks impeccable não aplicados (rode 'npx impeccable install' por projeto se quiser o detector automático)"
fi

echo
echo "OK. Reinicie o Claude Code. Use /ship-ui ou peça pra construir/redesenhar uma UI."
