# Obsidian Vault Profile

Use this profile when NexuBrain is configured for an Obsidian vault.

## Goal

Keep the human-readable graph clean while preserving agent-readable knowledge, task, evidence, workspace, and log structure.

## Start Mode Visible Files

Visible files should follow the confirmed language. For `zh-cn`:

```text
中枢.md
状态/当前快照.md
状态/状态.md
知识/知识.md
任务/任务.md
工作区/工作区.md
证据链/证据链.md
日志/日志.md
AGENTS.md
```

## Integrate Mode Default Files

```text
.nexubrain/integration/
```

In integrate mode, preserve native folders, wiki links, note contents, and lower-level graph logic. Do not treat `README.md` as a hub candidate by default. Propose localized native top-layer nodes before editing the hub. Do not create a visible parallel `NexuBrain/` namespace, `Nexus/NexuBrain-Entry.md`, or `Hub/NexuBrain-Entry.md`.

## Hidden Source

Keep `.nexubrain/` in the vault root or beside the vault root. Exclude it from graph views and search when possible.

## Notes

- Use plain Markdown paths when portability matters.
- Use Obsidian wiki links only in the generated visible connection layer if the user wants graph navigation.
- Do not expose framework maintenance docs as human knowledge notes.
- Use `Knowledge/` for durable concepts and topic notes; use `Tasks/` only for concrete actions.
