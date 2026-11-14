# Notice & Attribution

This document outlines the copyright, licensing, and attribution notices for components included in or referenced by **Agent Foundry**.

---

## 1. Scope of the Agent Foundry MIT License

The [MIT License](LICENSE) included in this repository applies **solely and strictly** to the original contributions created specifically for Agent Foundry by `nlong05013456-oss`. 

It **does not** supersede, alter, or re-license any third-party works, adapted components, or upstream code. Each third-party component remains subject to its respective upstream license or copyright terms as detailed below.

---

## 2. Upstream Attribution & Origin Chains

### A. Skill: `brainstorming`
- **Origin Chain**:
  1. **Root Source**: [`obra/superpowers`](https://github.com/obra/superpowers) (`skills/brainstorming/SKILL.md`)
     - **Author / Copyright**: Jesse Vincent (`obra`)
     - **License**: **MIT License**
  2. **Intermediate Collection**: [`benjaminasterA/antigravity-awesome-skills`](https://github.com/benjaminasterA/antigravity-awesome-skills) (`skills/brainstorming/`)
     - **License**: **MIT License** (Copyright 2026 benjaminasterA)
  3. **Translation / Adaptation**: [`quang26071999/demo_landing_page`](https://github.com/quang26071999/demo_landing_page) (`.agent/skills/brainstorming/SKILL.md`)
     - **License**: **No license file** (See Section 3)
  4. **Agent Foundry Version**: Refactored into `.agents/skills/brainstorming/SKILL.md`.

---

### B. Skill: `find-bugs`
- **Origin Chain**:
  1. **Root Source**: [`getsentry/skills`](https://github.com/getsentry/skills) (`plugins/sentry-skills/skills/find-bugs/`)
     - **Author / Copyright**: Functional Software, Inc. d/b/a Sentry
     - **License**: **Apache License 2.0**
     - **Compliance Notice**: Distributed under Apache-2.0 terms. State changes: adapted and translated into Vietnamese instructions for Antigravity local branch inspection.
  2. **Intermediate Collection**: [`benjaminasterA/antigravity-awesome-skills`](https://github.com/benjaminasterA/antigravity-awesome-skills) (`skills/find-bugs/`)
     - **License**: **MIT License** (Metadata specifies upstream `getsentry/skills`)
  3. **Translation / Adaptation**: [`quang26071999/demo_landing_page`](https://github.com/quang26071999/demo_landing_page) (`.agent/skills/find-bugs/SKILL.md`)
     - **License**: **No license file** (See Section 3)
  4. **Agent Foundry Version**: Refactored into `.agents/skills/find-bugs/SKILL.md`.

---

### C. Skill: `code-reviewer`
- **Origin Chain**:
  1. **Root / Community Source**: [`benjaminasterA/antigravity-awesome-skills`](https://github.com/benjaminasterA/antigravity-awesome-skills) & [`sickn33/agentic-awesome-skills`](https://github.com/sickn33/agentic-awesome-skills) (`skills/code-reviewer/`)
     - **License**: **MIT License**
  2. **Translation / Adaptation**: [`quang26071999/demo_landing_page`](https://github.com/quang26071999/demo_landing_page) (`.agent/skills/code-reviewer/SKILL.md` & `resources/implementation-playbook.md`)
     - **License**: **No license file** (See Section 3)
  3. **Agent Foundry Version**: Refactored into `.agents/skills/code-reviewer/SKILL.md`.

---

### D. Skills Inspired by `anthropics/skills` (Apache License 2.0)
- **Source**: [`anthropics/skills`](https://github.com/anthropics/skills) (Copyright Anthropic, PBC)
- **License**: **Apache License 2.0**
- **Affected Skills**:
  - `frontend-design`: The concept of avoiding generic templated aesthetics and striving for bold, distinctive visual design is inspired by `anthropics/skills/skills/frontend-design`. The specific implementation (CSS design tokens system, 4px/8px spacing, typography scale, responsive checkpoints, and Vietnamese instructions) was authored independently for Agent Foundry.
  - `webapp-testing`: The naming and testing philosophy are inspired by `anthropics/skills/skills/webapp-testing`. However, the implementation in Agent Foundry focuses on TypeScript / Playwright test templates, Vitest unit testing, and accessibility assertions (unlike Anthropic's Python test harness).

---

### E. Original Work in Agent Foundry (Covered by MIT License)
The following components are original creations authored by `nlong05013456-oss` for Agent Foundry:
- **Skill**: `organize-project` (`.agents/skills/organize-project/SKILL.md`): Clean Root Directory rules, naming conventions, import path integrity, and 4-step audit workflow.
- **Setup Automation**: `setup.ps1` (PowerShell) and `setup.sh` (Bash) with modular preset support, conflict detection, and dependency resolution.
- **Project Guidance**: `templates/AGENTS.md` (4 core ground rules and agent intent mapping).
- **Documentation**: `CATALOG.md` (natural language intent mapping) and `README.md`.

---

## 3. Upstream Components Without Formal License

The repository [`quang26071999/demo_landing_page`](https://github.com/quang26071999/demo_landing_page) does not contain a license file (`LICENSE` or `COPYING`). 

The following files in Agent Foundry originated from or were adapted through that repository:
1. `.agents/rules/web-design-backbone.md`
2. `.agents/rules/load-learnings.md`
3. `.agents/skills/plan/SKILL.md` (Converted from `.agent/workflows/plan.md`)
4. `.agents/skills/ai-learning/SKILL.md` (Converted from `.agent/workflows/ai-learning.md`)
5. `.agents/skills/human-learning/SKILL.md` (Converted from `.agent/workflows/human-learning.md`)
6. Vietnamese translations of `brainstorming`, `code-reviewer`, and `find-bugs`.

> ⚠️ **Status**: **Unverified upstream license status**. These files are currently documented for community transparency. The repository maintainer should decide whether to contact the author for formal permission or rewrite these instructions from scratch.
