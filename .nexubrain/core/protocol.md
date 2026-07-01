# NexuBrain Protocol

NexuBrain is a protocol for maintaining recoverable human-agent collaboration context.

## Required Concepts

- Nexus: the generated human-readable entry point in start mode. Hub remains the generic function name for an existing native entry point in integrate mode.
- Current snapshot: latest state, verified facts, limitations, and next action.
- Task index: actionable units of work with status and continuation points.
- Knowledge index: long-term semantic memory for durable concepts, facts, theories, topic notes, and domain understanding.
- Workspace index: real places where work happens.
- Evidence chain: support for claims, interpretations, experiments, sources, and decisions.
- Logs: append-only process history.
- Agent rules: boundaries for safety, integrity, credentials, and human authority.

## Separation Rules

- Keep current facts separate from historical logs.
- Keep human-facing knowledge separate from framework maintenance material.
- Keep generated connection-layer files separate from the hidden `.nexubrain/` framework source.
- Keep durable knowledge separate from tasks: knowledge becomes a task only when there is a concrete action.
- Do not record secrets, credentials, private keys, tokens, verification codes, or unsafe operational details.

## Agent Entry Flow

1. Read `AGENTS.md`.
2. Read `.nexubrain/core/protocol.md` when present.
3. Read the generated `Nexus.md` in start mode, or the detected native hub in integrate mode.
4. Read the generated visible current-snapshot path for the configured language, such as `状态/当前快照.md` in `zh-cn` or `State/Current-Snapshot.md` in an English setup.
5. Check the generated visible task path, such as `任务/任务.md` in `zh-cn`.
6. Check the generated visible knowledge path when the task depends on durable knowledge, such as `知识/知识.md` in `zh-cn`.
7. Check the generated visible workspace path, such as `工作区/工作区.md` in `zh-cn`.
8. Use evidence and logs only where relevant to the task.

## AGENTS Integration

In start mode, `AGENTS.md` is generated as part of the connection layer. In integrate mode, existing `AGENTS.md` rules remain authoritative. NexuBrain should first generate `.nexubrain/integration/AGENTS-Patch-Proposal.md`. In backup-confirmed one-pass setup, the initial setup approval covers applying this append-only entry flow; in proposal-first mode, the native `AGENTS.md` update waits for later approval. Existing rules must not be removed, reordered, or rewritten.

## Link Policy

Generated connection layers may use Obsidian wiki links or plain Markdown paths. The protocol must remain understandable to agents and tools that do not support Obsidian links.

Canonical English template paths may stay stable inside the hidden `.nexubrain/` source. Generated visible paths in the user's vault should follow the confirmed language. In Obsidian, localize the visible filename and wiki-link target, not just the alias, because graph nodes are based on real note names. For `zh-cn`, use paths such as `任务/任务.md`, `知识/知识.md`, and `工作区/工作区.md` instead of visible `*-Index.md` nodes. For languages without built-in path mappings, the active agent should translate visible filenames and link targets while preserving the hidden framework source.
