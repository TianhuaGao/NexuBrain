# Code Repository Profile

Use this profile when NexuBrain is configured for a code repository.

## Goal

Help agents resume engineering context through current state, knowledge, tasks, workspaces, evidence, logs, and rules.

## Start Mode Visible Files

Visible files should follow the confirmed language and repository docs location. For `zh-cn` under `docs/ai/`:

```text
docs/ai/中枢.md
docs/ai/状态/当前快照.md
docs/ai/状态/状态.md
docs/ai/知识/知识.md
docs/ai/任务/任务.md
docs/ai/工作区/工作区.md
docs/ai/证据链/证据链.md
docs/ai/日志/日志.md
AGENTS.md
```

## Integrate Mode Default Files

```text
.nexubrain/integration/
```

In integrate mode, preserve the repository's existing docs, source tree, README, and agent rules. Write proposals first; edit native docs only after explicit human approval.

## Notes

- Workspace records should include repository path, branch, latest checked commit, key commands, and test entry points.
- Knowledge records should capture durable architecture concepts and domain understanding.
- Evidence records should link to source files, tests, issues, PRs, logs, and official documentation.
- Logs should be append-only by default.
