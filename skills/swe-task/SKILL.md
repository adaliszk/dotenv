---
disable-model-invocation: true
description: Write or Refine a Software Task with clear instructions and consequences.
name: swe-task
---

USER provides short description of software task: LOAD into CONTEXT.
MAY include a reference to an existing ticket: LOAD reference into CONTEXT as SUPPLEMENTARY.
TASK is to write the full-featured task description: SAVE after CONFIRMATION ONLY.

RUN `/caveman ultra` for CONVERSATION ONLY.
RUN `/ponytail ultra` for IMPLEMENTATION ONLY.
LOAD `./wiki/ARCHITECTURE.md` for TECHNICAL OVERVIEW.
LOAD `./wiki/decisions/*.md` for TECHNICAL CONSTRAINTS.

USE professional business language WITH agile terminology and flow.
AVOID complex sentences, em-dash, repeated needs and wants.

# Rendering

Jira Cloud descriptions render wiki markup, NOT Confluence macros or HTML tags.
USE ONLY the native-safe set:

- `{panel:title=Title}...{panel}` for callouts.
- `{code}...{code}` for code or config blocks.
- `{quote}...{quote}` for cited context or documentation excerpts.

Colored macros (`{info}`, `{note}`, `{tip}`, `{warning}`, `{success}`, `{error}`) are
NOT native: they need a marketplace app. DO NOT use unless CONFIRMED. Map intent to a
titled `{panel}` instead. Mermaid does NOT render natively: OMIT unless CONFIRMED.

# Placeholders

Template placeholders use `[Variable]` square brackets. NEVER use `{Variable}`: the
curly braces collide with Jira macro syntax. Reserve `{}` strictly for actual macros.

# Ticket Format

Combines multiple header separated segments, with `---` lines for visual separation.

- Use-Case: the "description" without header to lead the task.
- Open Questions: unresolved points that need an answer before or during work.
- Implementation: step-by-step instruction list for agents, each with its consequence.
- Requirements: both technical and business goals to meet.

Apply only the segments relevant to the task. Omit a segment rather than padding it.
Include Open Questions only when unknowns exist.

# Ticket Content

The final result should look something like this:

```markdown
As [Actor], I want [Outcome] when [Trigger] so that [Goal] achieved for [Reward].
For this, the [Component] should use [Detail] during [Process].

---

### Implementation

1. [Action] on [Component] by [introducing / modifying] [Feature].
2. [implement / refactor] [Dependency].
3. [implement / refactor] [Dependency].
4. [verify / test] that the solution works as expected.

---

### Requirements

1. The [Feature] MUST BE fully implemented OR technical debt RAISED and AGREED.
2. [Consequence] SHOULD BE taken into account by [Action].
3. [Dependency] MUST BE [implemented / changed] AND verified by its OWNER: [Owner].
4. All changes MUST be verified on STAGING by [Stakeholder].
5. The [engineering standards|https://...] are applied OR challenged.
6. Documentation on the [Component] MUST BE updated with [Feature].
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
- **Detail**: the technical key detail the component uses (field, API, mechanism).
- **Process**: the process or flow stage where the change occurs.
- **Feature**: the capability being added or changed, named consistently throughout.
- **Dependency**: a component or integration the work relies on or must change.
- **Action**: the concrete step performed on a component.
- **Consequence**: what changes, breaks, or follows as a result of an action.
- **Owner / Stakeholder**: the person accountable for a dependency or sign-off.
