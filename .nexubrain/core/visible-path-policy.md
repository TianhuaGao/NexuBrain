# Visible Path Policy

NexuBrain has two path layers:

- Hidden framework source paths live under `.nexubrain/` and may keep canonical English template names such as `Tasks/Task-Index.md`.
- Generated visible paths live in the user's vault or workspace and should follow the confirmed configuration language.

Obsidian graph view displays real note basenames, not only wiki-link aliases. For that reason, a localized setup must localize the visible file path and wiki-link target, not just the display alias.

For `zh-cn`, generated visible nodes should use paths like:

```text
中枢.md
状态/当前快照.md
状态/状态.md
任务/任务.md
知识/知识.md
工作区/工作区.md
证据链/证据链.md
资源/资源.md
日志/日志.md
```

Do not generate visible Chinese graph nodes such as `Task-Index`, `Knowledge-Index`, or `Workspace-Index` when the user selected Chinese.

Templates such as `_Template-Task.md` and `_Template-Knowledge-Note.md` should remain hidden in `.nexubrain/` or `.nexubrain/integration/templates/` unless the user explicitly asks to materialize a template as a working note.

`AGENTS.md` is an agent startup and rule surface. It can mention NexuBrain entry paths, but it should not be treated as a primary graph navigation route from the hub.
