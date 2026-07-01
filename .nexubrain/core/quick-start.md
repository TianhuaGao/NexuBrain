# Quick Start

If you have not deployed NexuBrain locally yet, read [.nexubrain/core/local-deployment-guide.md](.nexubrain/core/local-deployment-guide.md) first.

## 1. Understand The Two Layers

NexuBrain should be used as a hidden framework source plus a small generated connection layer.

- `.nexubrain/`: framework protocol, templates, profiles, and installer guidance for agents and maintainers.
- Generated connection layer: the user's visible `Nexus`, current snapshot, task, workspace, evidence, resource, and log nodes, named in the confirmed language.
- Human knowledge system: the user's real vault, repository, paper project, content project, or workspace.

## 2. Let The Agent Guide Mode Selection

First ask the agent to read:

```text
.nexubrain/core/onboarding.md
.nexubrain/core/modes.md
.nexubrain/manifest.json
```

The agent should first state that NexuBrain configuration requires a short interview before writing files. Then it should ask only for language, target, mode, and backup status. Only after that should it inspect the target workspace with a write-free guide command:

```bash
.nexubrain/installer/nexubrain-init.sh guide /path/to/vault-or-project
```

If existing knowledge files are detected, the agent should recommend integrate mode:

```bash
.nexubrain/installer/nexubrain-init.sh integrate /path/to/existing-vault-or-project --profile obsidian-vault --language zh-cn --interview-confirmed --backup-confirmed --hub-edit-policy one-pass-after-backup
```

Integrate mode first creates a hidden review/proposal layer under `.nexubrain/integration/`: an integration report, a deep-review protocol, a worksheet, a native top-layer proposal, an `AGENTS.md` patch proposal, and native-placement templates. The installer does not semantically classify notes by itself; the active agent uses these records to read and classify. With backup-confirmed one-pass setup, the agent should continue directly to visible category nodes named in the confirmed language. For `zh-cn`, use paths such as `任务/任务.md`, `知识/知识.md`, `工作区/工作区.md`, `证据链/证据链.md`, and `资源/资源.md`. Then clean or create the native hub so first-level links route only through those categories and approved agent entry points, and append the NexuBrain Entry Flow to `AGENTS.md`. Do not merely append a NexuBrain section while leaving classified native links directly mounted on the hub. Existing notes, folders, lower-level double links, and existing `AGENTS.md` rules are preserved.

For a clean new knowledge base, use start mode:

```bash
.nexubrain/installer/nexubrain-init.sh start /path/to/new-vault-or-project --profile obsidian-vault --language zh-cn --interview-confirmed
```

Start mode generates the connection layer at the target root. For backward compatibility, omitting the mode still means start.

Use `--force` only when you intentionally want to overwrite NexuBrain-generated files.

For `zh-cn`, the generated visible connection layer includes:

```text
AGENTS.md
中枢.md
状态/当前快照.md
状态/状态.md
知识/知识.md
任务/任务.md
工作区/工作区.md
证据链/证据链.md
日志/日志.md
脑区/脑区连接.md
内部技能/内部技能.md
外部技能/外部技能.md
资源/资源.md
```

In an Obsidian vault, keep `.nexubrain/` hidden or excluded from file explorer and graph views when possible. Generated visible paths should be localized for the chosen language. Do not rely on wiki-link aliases alone, because Obsidian graph nodes use real note names.

## 3. Start From The Generated Nexus

For start mode, open `Nexus.md`. For integrate mode, open `.nexubrain/integration/Agent-Deep-Review-Protocol.md`, `.nexubrain/integration/Native-Top-Layer-Proposal.md`, and `.nexubrain/integration/AGENTS-Patch-Proposal.md`, then inspect the native hub candidates reported by the guide command.

## 4. Write The Current Snapshot

In the generated current snapshot page, such as `状态/当前快照.md` for `zh-cn`, record:

- current focus;
- active task;
- active workspace;
- active knowledge focus;
- verified facts;
- next action.

## 5. Build The Knowledge Layer

Use the generated Knowledge node, such as `知识/知识.md` for `zh-cn`, for durable concepts, theories, facts, topic notes, and domain understanding. Do not classify a knowledge note as a task unless the human wants to act on it.

## 6. Create A Task

Use the hidden task template only when creating a concrete task page, then register that page in the generated Task node, such as `任务/任务.md` for `zh-cn`.

## 7. Register A Workspace

Use the hidden workspace template only when creating a concrete workspace page, then register its real path or link in the generated Workspace node, such as `工作区/工作区.md` for `zh-cn`.

## 8. Build The Evidence Chain

Any claim that affects a paper, project, product, or long-term judgment should enter the generated Evidence Chain node, such as `证据链/证据链.md` for `zh-cn`.

## 9. Use External Skills Carefully

External skills should be evaluated for source, scope, permissions, dependencies, output quality, and risk before they become trusted workflow guidance.

## 10. Let An Agent Resume Work

Recommended opening prompt before setup:

```text
Please read .nexubrain/core/onboarding.md, .nexubrain/core/modes.md, .nexubrain/core/protocol.md, and .nexubrain/manifest.json. First tell me NexuBrain configuration requires a short interview before writing files, then ask only for language, target, mode, and backup status. Run the write-free guide before start or integrate. If I confirm the target is backed up or disposable, continue through routine additive setup in one pass without repeatedly asking for approval. Do not delete, move, rename, overwrite, or rewrite existing files unless I explicitly approve a separate migration.
```

Recommended opening prompt after start mode:

```text
Please read AGENTS.md, .nexubrain/core/protocol.md, and the generated visible Nexus, current snapshot, Knowledge node, and Task node first. For zh-cn these are usually 中枢.md, 状态/当前快照.md, 知识/知识.md, and 任务/任务.md. Do not modify unrequested structure, do not record credentials, and do not turn inference into fact.
```

Recommended opening prompt after integrate mode:

```text
Please read .nexubrain/integration/Agent-Deep-Review-Protocol.md, .nexubrain/integration/Integration-Report.md, .nexubrain/integration/Agent-Review-Worksheet.md, .nexubrain/integration/Native-Top-Layer-Proposal.md, and .nexubrain/integration/AGENTS-Patch-Proposal.md. Then inspect native hub candidates and existing links; if no hub exists, inspect the top-level and Markdown inventories. If backup-confirmed one-pass mode is recorded, create localized native top-layer nodes, clean the hub to top-layer-only first-level routes, and append the AGENTS entry flow without asking again. Classified native links should not remain as first-level hub entries. Do not create a visible parallel NexuBrain namespace, and do not rewrite existing note contents.
```
