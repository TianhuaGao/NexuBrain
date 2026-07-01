# Agent Onboarding Protocol

This protocol is for agents that have been asked to configure NexuBrain for a user.

## Minimal Interview And Backup Gate

When the user says they want to configure NexuBrain, do not immediately run `start` or `integrate`. First say:

```text
NexuBrain configuration needs a short interview before I write files. I will confirm language, target, mode, and backup status, then run a read-only guide before applying the selected setup.
```

The goal is not to ask for permission at every small step. The goal is to establish one clear setup contract before writing files.

## Required Interview Questions

Ask only these setup questions unless the answer is ambiguous:

1. Configuration language: which language should NexuBrain use for guidance and generated notes?
2. Target location: which vault, repository, or workspace should NexuBrain configure?
3. Mode confirmation: should this be `integrate` for an existing knowledge base, or `start` for a clean workspace?
4. Backup status: is this target backed up, disposable, or a copied test vault so visible additive changes can be applied in one pass?

If the target is not backed up, recommend creating a backup before visible integrate changes. Without backup confirmation, use conservative proposal-first integrate mode and ask before native visible edits.

## One-Pass Rule After Backup Confirmation

If the user confirms language, target, mode, and backup status, the agent should not repeatedly ask for approval between routine NexuBrain setup steps.

For `integrate`, backup-confirmed one-pass setup may include:

1. Run the write-free guide.
2. Run integrate with `--backup-confirmed --hub-edit-policy one-pass-after-backup`.
3. Generate `.nexubrain/integration/` reports and proposals.
4. Read the native hub or inventory and semantically classify existing material.
5. Create visible native top-layer nodes using the configured language. For `zh-cn`, use paths such as `状态/状态.md`, `任务/任务.md`, `知识/知识.md`, `工作区/工作区.md`, `证据链/证据链.md`, and `资源/资源.md`.
6. Clean the native hub so first-level routes point only to approved top-layer categories. Do not merely append a NexuBrain section while leaving classified native links directly mounted.
7. Append a NexuBrain Entry Flow to `AGENTS.md`, preserving existing rules.
8. Hide the local NexuBrain source `README.md` as `.README.md` so Obsidian does not treat it as a graph node.
9. Update `State/Current-Snapshot.md`, decision logs, and integration worksheets with what was done.

For `start`, backup confirmation is less important because the workspace is clean, but the same single setup approval may cover generated connection-layer files and hiding the local NexuBrain source `README.md` as `.README.md`.

## Hard Boundary

Backup confirmation reduces approval friction; it does not authorize destructive migration.

Even in one-pass mode, do not delete, move, rename, overwrite, or rewrite existing knowledge files. Do not move native folders into `Tasks/`, `Knowledge/`, or other generated directories. Treat destructive migration, bulk reorganization, content rewriting, or replacement of existing agent rules as a separate task that requires explicit human approval.

## Read-Only Inspection

Use this before writing setup files:

```bash
.nexubrain/installer/nexubrain-init.sh guide <target-directory>
```

The guide command writes nothing. It may inspect for existing Markdown, text, PDF, document, or project files. It should look for hub-like files in multiple languages, such as `Nexus.md`, `Hub.md`, `Home.md`, `Index.md`, `主页.md`, `首页.md`, `入口.md`, `导航.md`, `总览.md`, `目录.md`, `中枢.md`, or similar navigation files. In an Obsidian-vault profile, do not treat `README.md` as a hub candidate by default. Ignore hidden and tool paths such as `.git`, `.obsidian`, `.agents`, `.codex`, and `.nexubrain`. If no hub-like file is found, integrate mode may still proceed from the top-level inventory and Markdown inventory.

## Writing Commands

Conservative proposal-first integrate:

```bash
.nexubrain/installer/nexubrain-init.sh integrate <target-directory> --language zh-cn --interview-confirmed --hub-edit-policy proposal-only
```

Backup-confirmed one-pass integrate:

```bash
.nexubrain/installer/nexubrain-init.sh integrate <target-directory> --language zh-cn --interview-confirmed --backup-confirmed --hub-edit-policy one-pass-after-backup
```

Clean start:

```bash
.nexubrain/installer/nexubrain-init.sh start <target-directory> --language zh-cn --interview-confirmed
```

Allowed integrate hub policies:

- `no-edit`: do not edit the native hub; hidden records only.
- `proposal-only`: generate hub and top-layer proposals; no visible hub edits.
- `approved-after-review`: the user has approved a later native hub/index edit after reviewing the proposal.
- `one-pass-after-backup`: the user confirmed backup/disposable status, so the agent may perform routine additive integrate steps without repeated approval.

## Language Policy

NexuBrain does not maintain a separate translated framework for every supported language. It records the user's language preference and expects the active agent to translate and adapt canonical English guidance into that language.

Agents should preserve hidden framework source paths, safety boundaries, mode names, and evidence terminology. Generated visible filenames and wiki-link targets should follow the confirmed language; do not rely on aliases alone for Obsidian graph readability.

## Integrate Intelligence

Integrate mode may deeply classify an existing knowledge base, but it must create hidden proposal records first:

- `.nexubrain/integration/Integration-Report.md`
- `.nexubrain/integration/Agent-Deep-Review-Protocol.md`
- `.nexubrain/integration/Agent-Review-Worksheet.md`
- `.nexubrain/integration/Native-Top-Layer-Proposal.md`
- `.nexubrain/integration/AGENTS-Patch-Proposal.md`
- `.nexubrain/integration/templates/Task-Template.md`
- `.nexubrain/integration/templates/Workspace-Template.md`
- `.nexubrain/integration/templates/Evidence-Template.md`
- `.nexubrain/integration/templates/Knowledge-Note-Template.md`

The agent should classify existing material by reading, summarizing, and linking. The installer itself does not semantically classify notes; it prepares the reports and worksheets the agent uses. The agent should mark uncertain classifications as hypotheses. It should identify roles such as native hub, State, Tasks, Knowledge, Workspaces, EvidenceChain, Resources, Agent Rules, archive, and unknown. It must not classify every note as Knowledge by default.

## Agent Entry Boundary

In proposal-first integrate mode, `.nexubrain/integration/AGENTS-Patch-Proposal.md` is a proposal that waits for approval. In backup-confirmed one-pass mode, the agent may append the proposed NexuBrain Entry Flow to `AGENTS.md` during the same setup pass. Existing local agent rules remain authoritative and must not be removed, reordered, or rewritten.

## Native Top-Layer Boundary

In proposal-first integrate mode, native top-layer indexes wait for approval. In backup-confirmed one-pass mode, the agent may create the indexes during the same setup pass. These indexes should link to existing notes through double links. They should not own, move, or replace the existing notes.

## Hub Cleanup Boundary

If an existing hub-like file is detected, the agent must inventory its outgoing wiki links, preserve classified links through category nodes, and clean first-level hub routes in backup-confirmed one-pass mode. The hub edit should be minimal and reversible, but it is incomplete if classified native links still remain directly mounted on the hub.

If no hub exists, backup-confirmed one-pass mode may create a native hub after classification. Without backup confirmation, hub creation remains proposal-only.

## Refusal Boundary

If asked to skip backup status, delete, rewrite, migrate existing knowledge, hide user-owned notes, or replace `AGENTS.md` rules without explicit approval, pause and ask for confirmation. The only routine hide step is renaming the local NexuBrain source `README.md` to `.README.md` after setup. Integrate mode is additive setup, not destructive migration.
