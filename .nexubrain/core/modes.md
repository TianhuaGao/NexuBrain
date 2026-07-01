# NexuBrain Modes

NexuBrain has four setup commands and two deployment modes.

## Guide And Interview Commands

`interview` prints the required configuration interview and writes nothing. `guide` is an agent-facing inspection command. It writes nothing. It prints the setup gate and helps the agent inspect a workspace before any writing command.

The setup interview is intentionally short:

1. What configuration language should NexuBrain use?
2. Which target should be configured?
3. Should this workspace use integrate mode or start mode?
4. Is the target backed up, disposable, or a copied test vault so additive visible setup can be applied in one pass?

If existing knowledge files are detected, the agent should recommend integrate mode. If backup is confirmed, the agent may use `--hub-edit-policy one-pass-after-backup` and should not repeatedly ask for approval between routine setup steps. If backup is not confirmed, use `proposal-only` and ask before visible native edits.

## Integrate Mode

Integrate mode is for existing knowledge bases. It is non-destructive, additive, and built around existing links and folder meanings.

Default hidden writes:

```text
.nexubrain/integration/
```

Backup-confirmed one-pass integrate may also create or update a small native top-layer frame whose visible paths follow the confirmed language. For `zh-cn`:

```text
状态/状态.md
任务/任务.md
知识/知识.md
工作区/工作区.md
证据链/证据链.md
资源/资源.md
<native hub candidate, lightweight NexuBrain section>
AGENTS.md append-only NexuBrain Entry Flow
```

The native top-layer frame is not a parallel `NexuBrain/` vault. It is a set of localized category nodes that link to existing notes. Existing folders, notes, and lower-level double links stay where they are. Once a native folder or note has been classified, it should be preserved through the category node rather than kept as a first-level hub entry.

Required boundary:

- Preserve existing folders, note contents, and lower-level double links.
- Do not create a visible parallel `NexuBrain/` namespace by default.
- Do not create `Nexus/NexuBrain-Entry.md` or `Hub/NexuBrain-Entry.md` by default.
- Do not move existing folders into `Tasks/`, `Knowledge/`, or other top-layer directories.
- Do not delete, rename, overwrite, or rewrite existing knowledge files.
- Do not keep classified native folders or notes mounted as first-level hub entries after hub cleanup.
- Do not remove, reorder, or rewrite existing `AGENTS.md` rules.
- Write reports, maps, review worksheets, native top-layer proposals, and AGENTS patch proposals inside `.nexubrain/integration/` first.
- Without backup confirmation, ask for explicit human approval before creating visible native category nodes, cleaning the native hub, or appending to `AGENTS.md`.

## One-Pass After Backup

`one-pass-after-backup` is the preferred integrate policy for copied test vaults, disposable workspaces, or targets with a confirmed backup.

Under this policy, one user confirmation covers:

1. hidden integration reports;
2. agent semantic classification;
3. localized visible top-layer node creation;
4. top-layer-only native hub cleanup;
5. append-only `AGENTS.md` entry-flow application;
6. local NexuBrain source `README.md` hiding as `.README.md`;
7. current snapshot, decision log, and worksheet updates.

The agent should report what it changed when finished instead of asking after each substep. Hiding the local NexuBrain source `README.md` as `.README.md` is part of routine setup, because it keeps Obsidian from treating the GitHub/Finder entry page as a graph node. If the agent encounters destructive migration, unclear overwrite risk, credentials, private data exposure, or a conflict with existing local rules, it must stop and ask.

## Intelligent Classification

Integrate mode should be intelligent. The installer does not perform semantic classification by itself; it creates reports, inventories, worksheets, and proposals so the active agent can read, sample, and classify. If a hub exists, the agent reads the hub and follows outgoing links. If no hub exists, the agent starts from the top-level inventory and Markdown inventory in the integration report. In both cases, it maps material into top-layer roles: State, Tasks, Knowledge, Workspaces, EvidenceChain, Resources, Agent Rules, archive, or unknown.

The agent must not classify every note as Knowledge by default. A note may belong to multiple categories through double links. For example, a research plan can be both a Task and a Workspace; a method note can be Knowledge and Evidence; a code reading index can be Resource and Workspace context.

## Existing Hub Cleanup

A hub-like file may have many names and languages, including `Nexus.md`, `Hub.md`, `Home.md`, `Index.md`, `主页.md`, `首页.md`, `入口.md`, `导航.md`, `总览.md`, `目录.md`, and `中枢.md`. In an Obsidian-vault profile, `README.md` should not be treated as a hub candidate by default.

Default behavior without backup confirmation is native-preserving:

```text
Existing hub-like file -> native outgoing links -> .nexubrain/integration proposals
```

With backup-confirmed one-pass integrate, the agent must clean the native hub after preserving classified links through localized category nodes or review worksheets. Do not merely append a NexuBrain section while leaving classified native links directly mounted. Original note files remain in place. Uncertain links should stay in a review worksheet or temporary review file until classified.

If no hub-like file is detected, integrate mode still works. The agent should classify from the top-level directory inventory and Markdown inventory. In backup-confirmed one-pass mode it may create a native hub after classification; otherwise it should only propose the native hub path and language.

## Agent Entry Flow

In integrate mode, NexuBrain generates `.nexubrain/integration/AGENTS-Patch-Proposal.md`. Without backup confirmation, this is only a proposal. With backup-confirmed one-pass integrate, the agent may append the proposed NexuBrain Entry Flow to `AGENTS.md` during the same setup pass. Existing `AGENTS.md` rules remain authoritative.

## Start Mode

Start mode is for new knowledge bases, repositories, and workspaces. It generates the connection layer at the target root.

Expected root-level output follows the confirmed language. For `zh-cn`:

```text
AGENTS.md
中枢.md
状态/
知识/
任务/
工作区/
证据链/
日志/
脑区/
内部技能/
外部技能/
资源/
负责任使用.md
```

## Human Approval Boundary

Durable knowledge belongs in `Knowledge/`; actionable work belongs in `Tasks/`. Backup-confirmed one-pass setup removes repeated approvals for routine additive setup, but it does not authorize deletion, moves, renames, overwrites, content rewrites, credential exposure, or replacement of existing agent rules. Treat those as separate human-approved migration tasks.
