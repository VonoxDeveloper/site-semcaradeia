#!/usr/bin/env node
// Mescla os hooks do impeccable num settings.json existente, preservando o resto.
// uso: node merge-settings.mjs <destino/settings.json> <hooks.json>
import { readFileSync, writeFileSync, existsSync } from "node:fs";

const [, , dest, hooksPath] = process.argv;
if (!dest || !hooksPath) {
  console.error("uso: merge-settings.mjs <settings.json> <hooks.json>");
  process.exit(1);
}

const incoming = JSON.parse(readFileSync(hooksPath, "utf8"));
const cur = existsSync(dest) ? JSON.parse(readFileSync(dest, "utf8")) : {};

cur.hooks ??= {};
for (const [event, arr] of Object.entries(incoming.hooks)) {
  const existing = cur.hooks[event] ?? [];
  // evita duplicar: dedupe pelo texto do command
  const cmds = new Set(
    existing.flatMap((g) => (g.hooks ?? []).map((h) => h.command)),
  );
  const add = arr.filter(
    (g) => !(g.hooks ?? []).every((h) => cmds.has(h.command)),
  );
  cur.hooks[event] = [...existing, ...add];
}

writeFileSync(dest, JSON.stringify(cur, null, 2) + "\n");
