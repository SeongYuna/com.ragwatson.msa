# LLM 코딩 행동 지침 (Karpathy 스타일)

[Andrej Karpathy의 관찰](https://x.com/karpathy/status/2015883857489522876)과 이를 정리한 [Karpathy 스타일 CLAUDE.md 가이드](https://github.com/forrestchang/andrej-karpathy-skills)에 맞춘 프로젝트용 지침이다. 저장소·팀별 규칙이 있으면 **본 문서와 병합**해 사용한다.

---

## 트레이드오프

이 지침은 **속도보다 신중함**에 무게를 둔다. 사소한 작업(오타 수정, 한 줄로 명백한 수정 등)은 상황에 맞게 판단해 전부를 기계적으로 적용하지 않아도 된다.

---

## 다루는 문제 (카파시가 지적한 패턴)

> 모델이 잘못된 가정을 대신 하고, 확인 없이 그대로 밀고 나간다. 혼란을 관리하지 않고, 명확히 하지 않으며, 불일치를 드러내지 않고, 트레이드오프를 제시하지 않고, 말려야 할 때 밀어붙이지 않는다.

> 코드와 API를 과하게 복잡하게 만들고, 추상을 비대하게 쌓고, 데드 코드를 정리하지 않는다… 100줄이면 될 일을 1000줄짜리 덩어리로 만든다.

> 때로는 과제와 직교인 코드·주석까지 이해 없이 바꾸거나 지운다.

아래 네 가지 원칙이 위 실패 모드를 직접 겨냥한다.

| 원칙 | 겨냥하는 문제 |
|------|----------------|
| **구현 전 사고** | 잘못된 가정, 숨겨진 혼란, 트레이드오프 부재 |
| **단순성 우선** | 과설계, 비대한 추상 |
| **정밀한 수정** | 직교인 편집, 건드리면 안 되는 코드 손대기 |
| **목표 중심 실행** | 테스트·검증 가능한 성공 기준, 독립적 루프 |

---

## 1. 구현 전 사고 (Think Before Coding)

**가정하지 않는다. 혼란을 숨기지 않는다. 트레이드오프와 불일치를 드러낸다.**

해석을 조용히 하나로 골라 밀고 나가는 경향을 막기 위해, 구현 전에 다음을 따른다.

- **가정은 명시**한다. 불확실하면 추측하지 말고 **질문**한다.
- **해석이 여럿이면** 임의로 고르지 말고 **대안을 나열**한다.
- **더 단순한 방법**이 있으면 말한다. 정당한 이유가 있으면 사용자 요청에 **반대 의견**을 제시해도 된다.
- **혼란스러우면 멈춘다.** 무엇이 불명확한지 구체적으로 짚고 질문한다.
- 요구사항·코드·문서 사이의 **불일치가 있으면 표면화**한다(숨기지 않는다).

---

## 2. 단순성 우선 (Simplicity First)

**문제를 푸는 데 필요한 최소한의 코드만. 추측성 작업은 하지 않는다.**

- 요청받지 않은 **기능**을 넣지 않는다.
- **일회성** 코드를 위해 **추상화 층**을 만들지 않는다.
- 요청받지 않은 **유연성·설정 가능성**을 넣지 않는다.
- **발생 불가능한** 시나리오를 위한 예외 처리를 과하게 넣지 않는다.
- 200줄을 50줄로 줄일 수 있으면 **다시 쓴다**.

**검문:** 시니어 엔지니어가 “과하게 복잡하다”고 할까? 그렇다면 단순화한다.

---

## 3. 정밀한 수정 (Surgical Changes)

**꼭 필요한 것만 건드린다. 본인이 만든 잔여만 정리한다.**

기존 코드를 편집할 때:

- **인접한** 코드·주석·포맷을 “개선”한다며 임의로 바꾸지 않는다.
- **망가지지 않은** 부분을 리팩터링하지 않는다.
- 스타일이 마음에 안 들어도 **기존 스타일**을 따른다.
- 과제와 **무관한** 데드 코드를 발견하면 **언급만** 하고, 요청 없이 삭제하지 않는다.

**본인 수정으로** 쓰이지 않게 된 것만:

- 불필요해진 import·변수·함수는 **제거**한다.
- **원래부터 있던** 데드 코드는 요청이 없으면 **그대로** 둔다.

**검문:** 변경한 **모든 줄**이 사용자 요청과 **직접적으로** 연결되는가?

---

## 4. 목표 중심 실행 (Goal-Driven Execution)

**성공 기준을 정의하고, 검증될 때까지 루프한다.**

> LLM은 **구체적인 목표**를 만족할 때까지 루프하는 데 매우 강하다. 무엇을 하라고만 나열하기보다 **성공 기준**을 주면 스스로 돈다.

명령형 작업을 **검증 가능한 목표**로 바꾼다.

| 대신 이렇게 말하기 | 이렇게 바꾼다 |
|--------------------|----------------|
| 유효성 검사 추가 | 잘못된 입력에 대한 **테스트 작성 → 통과** |
| 버그 수정 | 버그를 **재현하는 테스트 작성 → 통과** |
| X 리팩터링 | 리팩터링 **전후 테스트 통과** 확인 |

다단계 작업이면 짧은 계획을 쓴다.

```text
1. [단계] → 검증: [확인 사항]
2. [단계] → 검증: [확인 사항]
3. [단계] → 검증: [확인 사항]
```

성공 기준이 명확해야 에이전트가 **독립적으로** 반복할 수 있다. “작동하게만” 같은 모호한 기준은 재질의를 늘린다.

---

## 지침이 먹고 있는지 확인

다음이 보이면 의도에 가깝다.

- **Diff에 불필요한 변경이 줄었다** — 요청된 변경만 보인다.
- **과한 복잡성으로 다시 짜는 일이 줄었다** — 처음부터 단순하다.
- **구현 전에** 명확히 하는 질문이 늘었다 — 실수 **뒤**가 아니다.
- **PR이 작고 깔끔하다** — 드라이브바이 리팩터링이나 “개선”이 없다.

---

## 5. 하네스 엔지니어링 — Wiki + LLM PKS

카파시식 하네스는 **프롬프트만**이 아니라 **지식·경계·검증**을 환경에 고정하는 것이다. 이 저장소는 **Wiki + LLM PKS(Project Knowledge System)** 로 그 지식 계층을 구현한다.

| 계층 | 역할 | 예시 |
|------|------|------|
| **Wiki** | 사람이 읽고 갱신하는 규범·도메인 설명 | `docs/`, `docs/AIOPS/`, `CLAUDE.md`, `CURSOR.md` |
| **LLM 규칙** | 에이전트에 항상 또는 조건부로 실리는 **짧은 고삐** | `.cursorrules`, `.cursor/rules/` |
| **PKS (코드 계약)** | Wiki와 1:1로 맞춘 **실행 가능한 진실** | 포트·DTO·스키마·provider·테스트·CI |

**PKS 원칙**

1. Wiki에 없는 관례를 **추측으로 도입하지 않는다.** 새 패턴이 필요하면 Wiki(`docs/AIOPS/`)에 먼저 적거나 추가를 제안한다.
2. 코드·문서·규칙이 어긋나면 **구현을 멈추고** 불일치를 표면화한다.
3. 완료 조건은 **검증 가능**해야 한다. (테스트·린트·타입·CI)
4. 경로·레이어·네이밍은 아래 **백엔드 아키텍처** 절을 따른다.

---

## 6. 백엔드 아키텍처 (SOLID · 헥사고날 · 클린 · DDD)

백엔드 Python/FastAPI 코드는 **반드시 SOLID**를 준수하고, **헥사고날 + 클린 + DDD**를 함께 적용한다.

### 경로 표기 (문서·규칙·에이전트 응답)

| 영역 | 표기 규칙 | 예 |
|------|-----------|-----|
| **앱 바운디드 컨텍스트** | `backend/`·`apps/` **생략**, 모듈명부터 | `titanic_m_learning/app/use_cases/james_cmd_interactor.py` |
| **공유 core** | `backend.core`로 시작 | `backend.core.database`, `backend.core.matrix_API_key.app.keymaker_api` |

> 실제 Python import는 `core.database` 등 런타임 `sys.path`에 맞출 수 있다. **문서·리뷰·에이전트 설명**에서는 위 표기를 쓴다.

### 레이어와 의존 방향

```text
adapter/inbound   →  app (ports · use_cases · dtos · mappers)
                        ↓ ports/output
adapter/outbound  →  ORM · PG · outbound mappers

domain            ←  app만 참조 (entity · value object). adapter는 domain을 직접 노출하지 않는다.
dependencies/*_provider.py  ←  유일한 조립 지점 (DIP)
```

| 레이어 | DDD · 클린 · 헥사고날 대응 | 책임 |
|--------|---------------------------|------|
| `adapter/inbound` | Primary adapter | Router, API schema, inbound mapper, HTTP 예외 |
| `app/ports/input` | Use case port | Input port (ABC) |
| `app/use_cases` | Application service | Interactor — 비즈니스 흐름, DTO만 사용 |
| `app/dtos` | Application model | Command / Query / Result (앱 경계 데이터) |
| `app/mappers` | Application mapper | Request ↔ Command 등 **앱 내부** 변환 |
| `app/ports/output` | Repository port | Output port (ABC) |
| `adapter/outbound/pg` | Secondary adapter | Repository 구현, SQLAlchemy 세션 |
| `adapter/outbound/orm` | Persistence model | 테이블·FK·relationship (DB 전용) |
| `adapter/outbound/mappers` | Anti-corruption | DTO ↔ ORM 변환 (앱이 SQLAlchemy를 모름) |
| `domain/entities` · `domain/value_objects` | Domain | 엔티티·VO (필요한 경로만) |
| `dependencies/*_provider.py` | Composition root | `get_*_use_case` — 포트 타입 반환, 구현체 조립 |

**읽기/쓰기 분리:** Command 경로(James)는 INSERT만, Query 경로(Walter)는 SELECT만. 공유 mapper 파일로 경로를 섞지 않는다.

### SOLID — 백엔드 적용 기준

| 원칙 | 이 프로젝트에서의 검문 |
|------|------------------------|
| **S** Single Responsibility | Router는 HTTP만, Interactor는 유스케이스만, ORM mapper는 변환만 |
| **O** Open/Closed | 새 유스케이스·어댑터는 **포트 추가 + provider 조립**으로 확장; 기존 interactor 난독화 금지 |
| **L** Liskov Substitution | `JamesCmdUseCase` 등 포트 타입에 구현체를 바꿔 끼워도 호출부 변경 없음 |
| **I** Interface Segregation | Use case port와 repository port 분리; fat interface 금지 |
| **D** Dependency Inversion | Router → port; Interactor → output port; **구현체는 `*_provider.py`에서만** |

### 금지 · 허용

- **금지:** Router가 `*PgRepository`·ORM을 직접 import
- **금지:** Use case / output port가 SQLAlchemy·FastAPI schema에 의존 (레거시는 점진 제거)
- **금지:** ORM을 API response로 직접 반환
- **허용:** Inbound mapper에서 VO(`Gender` 등)로 API 형식 변환
- **허용:** Provider에서 `Depends(get_db)`로 세션 주입

### 참고 구현

- Write: `titanic_m_learning/adapter/inbound/api/v1/james_cmd_router.py` → `dependencies/james_provider.py` → `app/use_cases/james_cmd_interactor.py` → `adapter/outbound/pg/james_cmd_pg_repository.py`
- Read: `titanic_m_learning/adapter/inbound/api/v1/walter_query_router.py` → `dependencies/walter_provider.py` → `app/use_cases/walter_query_interactor.py` → `adapter/outbound/pg/walter_pg_repository.py`

세부 DB 규칙(PK `id` 정수 등)은 `docs/AIOPS/backend/entity_rules.md`를 따른다.
