---
disable-model-invocation: true
description: Write or Refine a Software Task with clear instructions and consequences.
name: swe-task
---

# Execution

1. LOAD `caveman` SKILL in `ultra` MODE (RUN `/caveman ultra`), AND
   LOAD `ponytail` SKILL in `ultra` MODE (RUN `/ponytail ultra`)
2. LOAD `./wiki/ARCHITECTURE.md` for TECHNICAL OVERVIEW, AND
   LOAD `./AGENTS.md` for INSTRUCTIONS
3. LOAD `./wiki/decisions/*.md` for TECHNICAL CONSTRAINTS, AND
   LOOKUP `./wiki/patterns/*.md` to FIND APPLICABLE EXAMPLE
4. PARSE OR ASK for USER input about the short description what the ticket should
   contain with the direction provided.
5. LOAD any reference links provided for additional context.
6. ASK for the details WITHOUT assuming or choosing for the USER.
7. WRITE the full-featured ticket description and SHOW to the USER,
   AVOID complex sentences, em-dash, repeated needs and wants.
8. REPEAT 4-8 until USER APPROVES.
9. PRINT tokens used in the current Context.

# Rendering

Use `skill-macros` MCP with `format-to-<target>` tool to convert the custom DSL generated into the various target systems such as Jira, Confluence, GitHub, or AFFiNE. Use `supported-targets` tool to get which systems are available.

# Placeholders

Template placeholders use `[Variable]` square brackets. NEVER use `{Variable}`: the
curly braces collide with skill macro syntax and risk being parsed on push. Reserve `{}`
strictly for actual skill macros.

# Ticket Outline

Combines multiple header separated segments:

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
