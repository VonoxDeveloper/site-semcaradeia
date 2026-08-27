# site-semcaradeia

Config portátil de **design/UI para Claude Code**: um conjunto de skills de taste +
um orquestrador (`ship-ui`) que as chama na ordem certa. Clona, roda `install.sh`,
usa em qualquer projeto/computador.

## O que tem

```
skills/                    27 skills (vendored — não precisa de rede pra instalar)
  ship-ui/                 orquestrador: chama as outras na ordem direção→ref→impl→redesign
  design-taste-frontend/   anti-slop pra landing/portfólio/redesign
  high-end-visual-design/  fontes, espaçamento, sombras, cards "caros"
  impeccable/              auditoria de UX/hierarquia/a11y + detector via hook
  gpt-taste/ animate/ apple-design/ minimalist-ui/ industrial-brutalist-ui/
  imagegen-frontend-web/ imagegen-frontend-mobile/ brandkit/ image-to-code/
  redesign-existing-projects/ improve-animations/ review-animations/ ...
CLAUDE.snippet.md         bloco "Construção de UI" que aponta pro /ship-ui
hooks/impeccable.hooks.json  hooks PostToolUse/Stop do detector do impeccable
install.sh                instalador (global ou por projeto)
install/merge-settings.mjs merge não-destrutivo dos hooks no settings.json
```

## Instalar

```bash
git clone https://github.com/VonoxDeveloper/site-semcaradeia.git
cd site-semcaradeia

# global — vale em todos os projetos deste computador
./install.sh

# ou só num projeto
./install.sh --project /caminho/do/projeto
```

O instalador:
1. copia `skills/*` → `~/.claude/skills/` (ou `<proj>/.claude/skills/`)
2. adiciona o bloco `ship-ui` no `CLAUDE.md` do alvo (idempotente, marcador `ship-ui:start`)
3. **modo projeto**: mescla os hooks do impeccable no `settings.json` (detector automático de UI)
   **modo global**: não aplica hooks — rode `npx impeccable install` por projeto se quiser

Reinicie o Claude Code depois.

## Usar

- `/ship-ui` — dispara o pipeline
- ou só peça: "construir a landing", "redesenhar essa página", "polir esse dashboard"
  → o bloco no CLAUDE.md faz o Claude chamar `ship-ui` sozinho

Pipeline do `ship-ui`:
| Fase | Skills |
|------|--------|
| 1. Direção | `design-taste-frontend`, `high-end-visual-design`, `impeccable` + 1 linguagem visual |
| 2. Referência (imagem, opcional) | `imagegen-frontend-web/-mobile`, `brandkit`, `image-to-code` |
| 3. Implementação | `gpt-taste`, `animate`, `apple-design`, `ask-sonner`, `full-output-enforcement` |
| 4. Redesign | `redesign-existing-projects`, `improve/review/find-animation*` |

## Atualizar as skills upstream

As skills são vendored. Pra puxar versão nova dos autores:

```bash
npx skills@latest add emilkowalski/skills Leonxlnx/taste-skill --global
npx impeccable install
# depois re-vendor: copie de ~/.agents/skills/ de volta pra ./skills/ e commite
```

## Replicar em outro computador

```bash
git clone https://github.com/VonoxDeveloper/site-semcaradeia.git && cd site-semcaradeia && ./install.sh
```

Só isso. Tudo é self-contained no repo.

## Créditos

- `emilkowalski/skills` — Emil Kowalski
- `Leonxlnx/taste-skill` — Leon
- `impeccable` — instalado via `npx impeccable`

Skills rodam com permissão total do agente. Revise antes de usar.
