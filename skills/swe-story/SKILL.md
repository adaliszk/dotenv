---
disable-model-invocation: true
description: Write or Refine a Software Ticket about a Feature and User-Story.
name: swe-story
---

USER provides short description of software feature: LOAD into CONTEXT.
MAY include a reference to an existing ticket: LOAD reference into CONTEXT as SUPPLEMENTARY.
TASK is to write the full-featured ticket description: SAVE after CONFIRMATION ONLY.

RUN `/caveman ultra` for CONVERSATION ONLY.
RUN `/ponytail ultra` for IMPLEMENTATION ONLY.
LOAD `./wiki/ARCHITECTURE.md` for TECHNICAL OVERVIEW.
LOAD `./wiki/decisions/*.md` for TECHNICAL CONSTRAINTS.

USE professional business language WITH agile terminology and flow.
AVOID complex sentences, em-dash, repeated needs and wants.

# Rendering

Jira Cloud descriptions render wiki markup, NOT Confluence macros or HTML tags.
USE ONLY the native-safe set:

- `{panel:title=Title}...{panel}` for callouts (note, error, success, decision, card).
- `{code}...{code}` for code or config blocks.
- `{quote}...{quote}` for cited context or documentation excerpts.

Colored macros (`{info}`, `{note}`, `{tip}`, `{warning}`, `{success}`, `{error}`) are
NOT native: they need a marketplace app. DO NOT use unless CONFIRMED. Map intent to a
titled `{panel}` instead. Mermaid does NOT render natively: OMIT unless CONFIRMED.

# Placeholders

Template placeholders use `[Variable]` square brackets. NEVER use `{Variable}`: the
curly braces collide with Jira macro syntax and risk being parsed on push. Reserve `{}`
strictly for actual Jira macros.

# Ticket Format

Combines multiple header separated segments, with `---` lines for visual separation.
Each segment is for a different audience and different stakeholder:

- Use-Case: the "description" without header to lead the feature request.
- Viability: for giving limitations, context, and architecture details.
- Open Questions: unresolved points that need an answer before or during work.
- Solutions: Ideas or directions to choose from.
- Decision: for locking in the Solution with concrete plans.
- Implementation: step-by-step instruction list for agents.
- Scenarios: to explain the intended testing methodology.
- Requirements: both technical and business goals to meet.

Apply only the segments relevant to the ticket. Omit a segment rather than padding it.
Open Questions and Decision are often empty early: include Open Questions when unknowns
exist, leave Decision as a placeholder until a direction is locked.

# Ticket Content

The final result should look something like:

```markdown
As [Actor], I want [Outcome] when [Trigger] so that [Goal] achieved for [Reward].
For this, the [Component] should use [Detail] during [Process].

---

### Viability

{panel:title=Context}[Behaviour or architecture detail]{panel}

{panel:title=Limitation}Limited by [Reason]{panel}

{panel:title=Reference}[Documentation]{panel}

---

### Solutions

**Option A: [Direction: Least Effort]**
- [Result]
- [TechnicalDebt]
- [Estimation]
- [Cost]

**Option B: [Direction: Quality Effort]**
- [Result]
- [Estimation]
- [Cost]

**Option C: [Direction: Compromise]**
- [Result]
- [Consequence]
- [TechnicalDebt]
- [Estimation]
- [Cost]

---

### Decision

{panel:title=Decision}Option X chosen by [Stakeholder]{panel}

{panel:title=Benefit}[Benefit]{panel}

{panel:title=Drawback}[Drawback]{panel}

---

### Implementation

1. [Action] on [Component] by [introducing / modifying] [Feature].
2. [implement / refactor] [Dependency].
3. [implement / refactor] [Dependency].
4. [implement / refactor] [Dependency].
5. [verify / test] [Scenarios] that the solution works as expected.

---

### Scenarios

Scenario: [short intent]

- Given [precondition / starting state]
- When [trigger occurs in system]
- Then [observable outcome in system]
- And [reward / secondary outcome]

Scenario: [short intent]

- Given [precondition / starting state]
- When [trigger occurs in system]
- Then [observable outcome in system]
- And [reward / secondary outcome]

---

### Requirements

1. The [Feature] MUST BE fully implemented OR technical debt RAISED and AGREED.
2. [Consequence] SHOULD BE taken into account by [Solution].
3. [Consequence] SHOULD BE taken into account by [Solution].
4. [Dependency] MUST BE [implemented / changed] AND verified by its OWNER: [Owner].
5. All scenarios MUST pass on STAGING and verified by [Stakeholder].
6. The [engineering standards|https://...] are applied OR challenged.
7. Documentation on the [Component] MUST BE updated with [Feature].
```

# Variables

CAN BE inferred BUT ALWAYS ASK when NOT CERTAIN! Owners and Stakeholders are
frequently NOT inferable: ASK rather than invent a name.

- **Actor**: the role whose goal drives the work (e.g. procurement, developers).
- **Beneficiary**: who gains downstream (may differ from Actor).
- **Goal / Reward**: the business value when done.
- **Trigger**: the event or condition that starts it.
- **Outcome**: the observable end state.
- **Component**: the architecture component or pipeline involved.
- **Behaviour**: current operation flow as documented or observed.
- **Owner / Stakeholder**: the person accountable for a dependency or sign-off.
- **Detail**: the technical key detail the component uses (field, API, mechanism).
- **Process**: the process or flow stage where the change occurs.
- **Feature**: the capability being added or changed, named consistently throughout.
- **Dependency**: a component or integration the work relies on or must change.
- **Result**: the concrete outcome a solution option delivers.
- **TechnicalDebt**: shortcuts or follow-up work an option leaves behind.
- **Estimation**: rough effort size for an option (e.g. small, medium, large).
- **Cost**: relative cost or trade-off of an option.
- **Consequence**: a downstream effect a solution must account for.
- **Benefit / Drawback**: the upside and downside of the chosen decision.
- **Reason**: the cause of a limitation in Viability.
