# NexuBrain Framework Source

This hidden folder is the framework source for NexuBrain's cognitive connectome model.

It is intended for agents, maintainers, and installer tooling. It should not be treated as the user's visible knowledge graph.

## Contents

- `core/`: protocol, onboarding, mode, release-layout, design, and architecture guidance.
- `templates/`: reusable start-mode connection-layer templates.
- `profiles/`: deployment profiles for different user contexts.
- `installer/`: canonical initialization script and installer notes.
- `assets/`: README and framework assets that should stay hidden from the user graph.
- `LICENSE`: framework license text for the hidden-layout release target.
- `manifest.json`: machine-readable framework package metadata.

## Start-Mode Connection Layer

A clean generated connection layer contains localized visible nodes for the confirmed language. For `zh-cn`, it may contain:

```text
中枢.md
状态/当前快照.md
状态/状态.md
知识/知识.md
任务/任务.md
工作区/工作区.md
证据链/证据链.md
资源/资源.md
日志/日志.md
AGENTS.md
```

Keep this hidden source separate from the human-facing connection layer whenever possible. Canonical English template names may remain inside `.nexubrain/`, but generated visible paths should be localized instead of merely aliased.

## Integrate-Mode Native Top Layer

For an existing vault or workspace, integrate mode first writes hidden review and proposal material:

```text
.nexubrain/integration/Integration-Report.md
.nexubrain/integration/Agent-Deep-Review-Protocol.md
.nexubrain/integration/Agent-Review-Worksheet.md
.nexubrain/integration/Native-Top-Layer-Proposal.md
.nexubrain/integration/AGENTS-Patch-Proposal.md
.nexubrain/integration/templates/
.nexubrain/integration/Configuration.md
```

It preserves existing folders, note contents, lower-level double links, and existing `AGENTS.md` rules. After approval or backup-confirmed one-pass setup, the agent may create localized native top-layer pages such as `任务/任务.md`, `知识/知识.md`, `工作区/工作区.md`, `证据链/证据链.md`, and `资源/资源.md` in a Chinese vault, then clean or create the native hub so first-level routes point only to those categories and approved agent entry points. Classified native links should be preserved through category nodes, not kept as permanent first-level hub mounts. It may append a NexuBrain Entry Flow to `AGENTS.md` only after approval or backup-confirmed one-pass setup. It must not create a visible parallel `NexuBrain/` namespace, `Nexus/NexuBrain-Entry.md`, or `Hub/NexuBrain-Entry.md`.

## Templates

`templates/` contains the default complete start-mode connection-layer template, including `Knowledge/` as the long-term semantic memory node. Integrate-mode templates and top-layer proposals live under `.nexubrain/integration/` after setup so the agent can propose native placement before editing existing notes or the native hub.

## Agent-Led Deployment

- `guide`: inspection mode for agents. It writes nothing, asks for language first, detects existing knowledge files and hub candidates, and recommends a setup mode.
- `start`: clean mode for a new vault, repository, project, or workspace. It generates the connection layer at the target root.
- `integrate`: non-destructive mode for an existing knowledge base. It writes hidden review/proposal files under `.nexubrain/integration/`, including an `AGENTS.md` patch proposal, then allows approved native top-layer indexes, hub cleanup through double links, and append-only agent entry flow updates.

See `core/onboarding.md`, `core/modes.md`, and `core/release-layout.md` for setup, mode boundaries, and the target public repository shape.
