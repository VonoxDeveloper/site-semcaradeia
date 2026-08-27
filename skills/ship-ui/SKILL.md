---
name: ship-ui
description: Orquestra todas as skills de design instaladas (design-taste-frontend, high-end-visual-design, impeccable, gpt-taste, animate, apple-design, redesign-existing-projects, imagegen-*, brandkit, etc.) numa ordem única para construir ou redesenhar interfaces de alto nível. Use quando o pedido for construir/redesenhar/polir um site, landing page, portfólio, dashboard, app shell, componente ou fluxo de UI — em qualquer projeto. Não use para tarefas de backend ou não-UI.
---

# ship-ui — orquestrador de skills de design

Pipeline fixo. Rode as fases em ordem. Cada bullet = invocar a skill via ferramenta Skill.
Se uma skill não estiver instalada no projeto, siga sem ela — não bloqueie.

## Fase 1 — Direção de design (SEMPRE, antes de escrever qualquer componente)
1. `design-taste-frontend` — ler o brief, inferir direção, rejeitar layout templatado
2. `high-end-visual-design` — travar fontes, escala de espaçamento, sombras, estrutura de card, animações "caras"
3. `impeccable` — hierarquia visual, arquitetura de informação, carga cognitiva, acessibilidade, tokens

Escolher UMA linguagem visual pro projeto (nunca misturar):
- `minimalist-ui` — editorial, monocromático quente, bento flat, zero gradiente
- `industrial-brutalist-ui` — grid rígido, terminal militar, estética blueprint
- senão, seguir a direção que a `design-taste-frontend` inferiu do brief

Saída da fase 1: um resumo curto da direção (paleta, tipografia, escala, motion, linguagem visual) antes de codar.

## Fase 2 — Referência visual (opcional; essas skills só geram imagem, não código)
- `imagegen-frontend-web` — 1 imagem horizontal POR seção da landing (8 seções = 8 imagens)
- `imagegen-frontend-mobile` — telas de app dentro de mockup de phone
- `brandkit` — boards de identidade / sistema de logo / guidelines
- `image-to-code` — quando o usuário fornecer screenshot pra reproduzir

## Fase 3 — Implementação
- `gpt-taste` — tipografia editorial larga, bento sem gaps, GSAP ScrollTrigger (pin/stack/scrub), espaçamento generoso entre seções
- `animate` — decidir se anima, qual propriedade, curva, duração, interrupção, saída
- `apple-design` — gestos, spring, materiais translúcidos, momentum, reduced-motion
- `ask-sonner` — quando/como usar toasts (lib Sonner)
- `full-output-enforcement` — código completo, sem placeholder, sem "// resto igual"

## Fase 4 — Redesign de projeto existente (só quando for redesign)
- `redesign-existing-projects` — auditar o design atual, achar padrões genéricos de IA, elevar sem quebrar funcionalidade
- `improve-animations` / `review-animations` / `find-animation-opportunities` — auditoria de motion

## Regras
- Fase 1 é obrigatória antes de criar componentes.
- Em projeto novo, rodar `/impeccable init` uma vez pra configurar contexto de design.
- Skills de imagem (`imagegen-*`, `brandkit`) não escrevem código — só referência.
- Nunca misturar `minimalist-ui` com `industrial-brutalist-ui` no mesmo projeto.
- Skill ausente no projeto → seguir sem ela.
