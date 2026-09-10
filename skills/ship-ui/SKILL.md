---
name: ship-ui
description: Orquestra todas as skills de design instaladas (design-taste-frontend, high-end-visual-design, impeccable, gpt-taste, animate, animate-expo, apple-design, gsap-*, redesign-existing-projects, imagegen-*, brandkit, etc.) numa ordem única para construir ou redesenhar interfaces de alto nível, com trilhas separadas para web e mobile. Use quando o pedido for construir/redesenhar/polir um site, landing page, portfólio, dashboard, app shell, tela ou fluxo de app Expo/React Native, componente ou fluxo de UI — em qualquer projeto. Não use para tarefas de backend ou não-UI.
---

# ship-ui — orquestrador de skills de design

Pipeline fixo. Rode as fases em ordem. Cada bullet = invocar a skill via ferramenta Skill.
Se uma skill não estiver instalada no projeto, siga sem ela — não bloqueie.

## Passo 0 — Plataforma (antes de tudo)
Descobrir onde a UI roda. Isso decide a skill de motion, a de referência visual e quais
linguagens visuais estão disponíveis — errar aqui contamina todas as fases.

| Plataforma | Como identificar |
|-----------|------------------|
| Web | `next`, `react-dom`, `vue`, `nuxt`, `svelte` no package.json; HTML/CSS |
| Mobile | `expo`, `react-native`, `expo-router` no package.json; `app.json` / `app.config.ts` |
| iOS nativo | `.xcodeproj` / `.xcworkspace`, SwiftUI ou UIKit |

Ler o package.json antes de perguntar. Projeto que ainda não existe → perguntar ao usuário.

## Fase 1 — Direção de design (SEMPRE, antes de escrever qualquer componente)
1. `design-taste-frontend` — ler o brief, inferir direção, rejeitar layout templatado
2. `high-end-visual-design` — travar fontes, escala de espaçamento, sombras, estrutura de card, animações "caras"
3. `impeccable` — hierarquia visual, arquitetura de informação, carga cognitiva, acessibilidade, tokens

Escolher UMA linguagem visual pro projeto (nunca misturar):
- `minimalist-ui` — editorial, monocromático quente, bento flat, zero gradiente
- `industrial-brutalist-ui` — grid rígido, terminal militar, estética blueprint
- `gpt-taste` — tipografia editorial larga, bento sem gaps, AIDA, scroll cinematográfico
  (GSAP pin/stack/scrub) — **web apenas**, depende de GSAP
- senão, seguir a direção que a `design-taste-frontend` inferiu do brief

Essas três são linguagens visuais completas e mutuamente exclusivas — a escolha é aqui,
na fase 1, não na hora de implementar. Em mobile, `gpt-taste` sai da mesa: sobram
`minimalist-ui`, `industrial-brutalist-ui` ou a direção inferida do brief.

Saída da fase 1: um resumo curto da direção (paleta, tipografia, escala, motion, linguagem visual) antes de codar.

## Fase 2 — Referência visual (opcional; essas skills só geram imagem, não código)
- `imagegen-frontend-web` — web: 1 imagem horizontal POR seção da landing (8 seções = 8 imagens)
- `imagegen-frontend-mobile` — mobile: telas de app dentro de mockup de phone
- `brandkit` — boards de identidade / sistema de logo / guidelines (agnóstico)
- `image-to-code` — quando o usuário fornecer screenshot pra reproduzir (agnóstico)

## Fase 3 — Implementação
Rodar 3A **ou** 3B conforme o passo 0. Nunca os dois.

Vale nas duas plataformas:
- `apple-design` — gestos, spring, materiais translúcidos, momentum, reduced-motion
- `full-output-enforcement` — código completo, sem placeholder, sem "// resto igual"

### 3A — Web
- `gpt-taste` — SÓ se foi a linguagem visual escolhida na fase 1; senão pular (colide com as outras duas)
- `animate` — decidir se anima, qual propriedade, curva, duração, interrupção, saída
- `ask-sonner` — toasts (Sonner é React DOM; não existe em React Native)
- GSAP → tabela abaixo, quando o projeto usa GSAP

### 3B — Mobile (Expo / React Native)
- `animate-expo` — decidir se anima, em qual thread roda, quais propriedades, spring ou
  timing, como o gesto faz handoff, como degrada. Escreve com Reanimated, Gesture Handler,
  Expo Router e expo-haptics. Substitui `animate` e as `gsap-*` — não é complemento delas.
- `write-swift` — só quando cair em Swift de verdade: módulo nativo, widget, App Intent,
  extension. App Expo comum não precisa.

Motion que trava no device é problema de thread (JS vs UI), não de curva — `animate-expo`
cobre isso. Não existe equivalente de `gsap-performance` aqui.

### GSAP (só em 3A, projeto web que usa GSAP)
`animate` decide o motion — se anima, qual propriedade, curva, duração. As skills abaixo
são a referência de API pra escrever esse motion em GSAP. Consultar sob demanda, não
enfileirar todas.

Se a linguagem visual escolhida foi `gpt-taste`, `gsap-core` + `gsap-scrolltrigger` são
obrigatórias — ela exige ScrollTrigger com pin/stack/scrub.

| Skill | Quando |
|-------|--------|
| `gsap-core` | base sempre: `to/from/fromTo`, easing, stagger, `matchMedia` (responsivo + reduced-motion) |
| `gsap-timeline` | sequenciar mais de uma animação — position parameter, nesting, playback |
| `gsap-scrolltrigger` | scroll-linked, parallax, pin, scrub |
| `gsap-plugins` | Flip, Draggable, SplitText, ScrollSmoother, Observer, CustomEase, SVG |
| `gsap-react` | projeto React/Next — `useGSAP`, refs, `gsap.context()`, cleanup no unmount |
| `gsap-frameworks` | projeto Vue/Nuxt/Svelte — lifecycle, escopo de seletor, cleanup |
| `gsap-utils` | `clamp`, `mapRange`, `random`, `snap`, `toArray`, `wrap` |
| `gsap-performance` | animação com jank, travando, abaixo de 60fps |

React ou Next → puxar `gsap-react` junto com `gsap-core` desde o começo: cleanup no unmount
é onde a maior parte dos bugs de GSAP em React aparece, e refazer depois custa mais.

Nenhuma dessas oito existe em React Native — em mobile, ir pra 3B.

## Fase 4 — Redesign de projeto existente (só quando for redesign)
- `redesign-existing-projects` — auditar o design atual, achar padrões genéricos de IA, elevar sem quebrar funcionalidade

Motion em projeto existente — as três skills abaixo são READ-ONLY: produzem lista ou plano,
nenhuma delas aplica o código. Escolher pelo escopo:

| Skill | Quando | Entrega |
|-------|--------|---------|
| `find-animation-opportunities` | nada anima ainda, quer saber o que vale animar | lista de oportunidades com valores exatos |
| `improve-animations` | já tem motion espalhado, quer roadmap do codebase inteiro | auditoria priorizada + planos de implementação |
| `review-animations` | quer crítica de um diff ou componente específico | review apontando o que está errado |

Sempre voltar à fase 3 pra implementar o que elas apontaram — a fase 4 termina em plano, não em código.

## Apoio (fora do pipeline — consultar sob demanda, não é fase)
- `animation-vocabulary` — o usuário descreveu um efeito sem saber o nome ("aquele treco que
  quica quando abre") e você precisa do termo exato antes de escolher a skill de motion certa

## Regras
- Passo 0 antes da fase 1: sem saber a plataforma, o resto do pipeline escolhe errado.
- Fase 1 é obrigatória antes de criar componentes.
- Em projeto novo, rodar `/impeccable init` uma vez pra configurar contexto de design.
- Skills de imagem (`imagegen-*`, `brandkit`) não escrevem código — só referência.
- Nunca misturar `minimalist-ui`, `industrial-brutalist-ui` e `gpt-taste` no mesmo projeto —
  escolher uma na fase 1 e descartar as outras duas. Em mobile, `gpt-taste` nem entra.
- Nunca cruzar as plataformas: `animate` e `gsap-*` não existem em React Native;
  `animate-expo` não existe na web. Web é 3A, mobile é 3B.
- Fase 4 é read-only: auditoria de motion entrega plano, quem implementa é a fase 3 —
  na trilha da plataforma certa.
- Skill ausente no projeto → seguir sem ela.
