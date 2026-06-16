# Cursor에서의 하네스 엔지니어링 (Karpathy 의도 정렬)

This document explains how to **harness** LLM coding assistants inside **Cursor**. Behavioral rules live in [`CLAUDE.md`](./CLAUDE.md); this file covers **tooling, rules, and workflow** that keep those rules enforced in practice.

**Background:** [Andrej Karpathy](https://x.com/karpathy/status/2015883857489522876) observed that models push ahead on wrong assumptions, over-engineer, and touch unrelated code. Counter that with **harness engineering** — design environment, inputs, and verification — not prompts alone. The four principles in [`CLAUDE.md`](./CLAUDE.md) are the shared backbone.

---

## Agent language & scope

| Topic | Rule |
|-------|------|
| **Response language** | Always respond in **Korean**, unless the user explicitly requests another language. |
| **Behavioral rules** | [`CLAUDE.md`](./CLAUDE.md) §1–4 — do not duplicate here. |
| **Project rules** | [`CLAUDE.md`](./CLAUDE.md) §5–6, `docs/AIOPS/`, `.cursor/rules/` |
| **Tradeoff** | Caution over speed; skip mechanical application on trivial edits. |

When instructions conflict, prefer **project-specific docs** (`docs/AIOPS/`, backend architecture in `CLAUDE.md`) over generic habits.

---

## 하네스가 하는 일

| 역할 | 한 줄 설명 |
|------|------------|
| **경계** | 무엇을 건드려도 되는지, 어떤 스타일·스택인지 고정한다. |
| **입력** | 프롬프트에 성공 기준·검증 방법을 넣기 쉽게 만든다. |
| **검증** | 테스트·린트·CI로 “목표 중심 실행”을 기계적으로 닫는다. |

카파시가 강조한 대로, 모델은 **구체적인 목표와 검증 루프**가 있을 때 반복 작업에 강하다. 하네스는 그 목표와 루프가 **대화 밖에서도** 유지되도록 돕는다.

---

## Cursor 쪽 레이어 (권장 배치)

아래는 **이 프로젝트** 기준 권장이다. 팀 정책에 맞게 줄이거나 늘린다.

1. **`CLAUDE.md` (또는 `AGENTS.md`)**  
   에이전트의 **행동 규범**: 가정 명시, 단순성, 수술적 수정, 성공 기준. Cursor에서도 프로젝트 컨텍스트로 자주 읽히므로 **단일 소스**로 두는 것이 좋다.

2. **프로젝트 규칙 (`.cursor/rules/`)**  
   경로·언어·금지 사항·PR 관례 등 **프로젝트 고정 사실**을 짧고 명시적으로 적는다. “추측으로 스택을 바꾸지 마라” 같은 것도 여기에 두면 **정밀한 수정** 하네스가 된다.

3. **User Rules (Cursor 설정)**  
   모든 저장소에 공통으로 쓰는 취향(예: 한국어 응답, 인용 형식)만 둔다. **저장소별 진실**은 `.cursor/rules`와 `CLAUDE.md`에 두는 편이 충돌이 적다.

4. **Skills (`SKILL.md`)**  
   반복되는 절차(예: PR 병합 준비, 특정 MCP 사용법)를 문서화한다. 매번 긴 프롬프트를 쓰지 않고 **목표 중심** 절차를 재사용한다.

5. **Hooks (선택)**  
   커밋 전·에이전트 이벤트에 린트/테스트를 걸어 **검증**을 대화와 분리한다. 부담이 크면 CI만으로도 충분하다.

---

## Karpathy 네 원칙과 하네스의 대응

| 원칙 | 하네스에서의 실천 |
|------|-------------------|
| **구현 전 사고** | 규칙에 “불명확하면 구현 전 질문”을 명시; 이슈·PR 템플릿에 가정·트레이드오프 칸을 둔다. |
| **단순성 우선** | “요청 범위 밖 리팩터링 금지”를 규칙에 적는다; 코드리뷰에서 diff 크기·추상화 증가를 본다. |
| **정밀한 수정** | `.cursorignore`, 규칙의 `globs`로 건드리면 안 되는 경로를 줄인다; 포맷만 바꾼 변경은 거절 기준으로 둔다. |
| **목표 중심 실행** | PR 정의에 “재현 테스트 → 통과” 등 **검증 가능한 완료 조건**을 넣는다; CI가 그 조건을 실행한다. |

---

## 사용자(사람)가 하네스를 쓰는 법

- Attach a **definition of done** in one sentence when assigning work. (e.g. “all `npm test` pass”, “add a unit test for that endpoint”)  
- When requirements are ambiguous, **let the agent ask first** — early questions mean the harness is working.  
- On review, check for **lines unrelated to the request**. Use the “Signs the guidelines are working” section in [`CLAUDE.md`](./CLAUDE.md) as a checklist.

### Prompt patterns that reduce mistakes

| Weak prompt | Stronger prompt |
|-------------|-----------------|
| “Add validation” | “Add validation; write tests for invalid inputs, then make them pass.” |
| “Fix the bug” | “Reproduce the bug in a test, then fix until it passes.” |
| “Refactor X” | “Refactor X; existing tests must pass before and after.” |
| “Make it work” | “Done when: [command] succeeds and [behavior] is verified.” |

For multi-step work, ask the agent to state a short plan: `Step → verify: [check]` per step.

---

## 참고 링크

- 카파시 원 트윗: [X / Karpathy](https://x.com/karpathy/status/2015883857489522876)  
- 네 원칙을 `CLAUDE.md` 형태로 정리한 예시: [forrestchang/andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills)  
- 이 저장소의 행동 지침: [`CLAUDE.md`](./CLAUDE.md)
