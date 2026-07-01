# Deployment Modes

NexuBrain supports an agent-led onboarding flow and two deployment modes: integrate and start.

## Agent-Led Onboarding

The user should not need to know the correct mode before starting. After the user installs or opens NexuBrain and asks an agent to configure it, the agent should guide setup in this order:

1. State that NexuBrain configuration requires a short interview before writing files.
2. Ask for language, target, mode intent, and backup status.
3. Run only the write-free guide command to inspect the target workspace.
4. Recommend integrate mode if existing knowledge is detected.
5. If backup/disposable/test-copy status is confirmed, proceed in one pass for routine additive setup.
6. If backup is not confirmed, use proposal-first integrate and ask before visible native edits.

The inspection command is:

```bash
.nexubrain/installer/nexubrain-init.sh guide /path/to/vault-or-project
```

`guide` writes nothing. It reports file counts, hub candidates, backup-gated setup guidance, and the command options that may be run after the interview.

## Mode 1: Integrate Existing Knowledge Base

Use integrate mode when the user already has a knowledge base, Obsidian vault, repository, research folder, or project workspace.

Conservative proposal-first integrate:

```bash
.nexubrain/installer/nexubrain-init.sh integrate /path/to/existing-vault-or-project --profile obsidian-vault --language zh-cn --interview-confirmed --hub-edit-policy proposal-only
```

Backup-confirmed one-pass integrate:

```bash
.nexubrain/installer/nexubrain-init.sh integrate /path/to/existing-vault-or-project --profile obsidian-vault --language zh-cn --interview-confirmed --backup-confirmed --hub-edit-policy one-pass-after-backup
```

Integrate mode begins by writing hidden review and proposal files:

```text
.nexubrain/integration/Integration-Report.md
.nexubrain/integration/Agent-Deep-Review-Protocol.md
.nexubrain/integration/Agent-Review-Worksheet.md
.nexubrain/integration/Native-Top-Layer-Proposal.md
.nexubrain/integration/AGENTS-Patch-Proposal.md
.nexubrain/integration/templates/
.nexubrain/integration/Configuration.md
```

With backup-confirmed one-pass setup, the active agent should continue without repeated approval through semantic classification, visible top-layer nodes, top-layer-only native hub cleanup, and an append-only NexuBrain Entry Flow in `AGENTS.md`.

The agent must preserve existing folders, note contents, lower-level double links, and existing `AGENTS.md` rules. It adds new double links from category nodes to existing notes. It must not move existing notes into the new directories or rewrite lower-level content. After classification, native folders or notes must be preserved through category nodes rather than kept as first-level hub entries.

## Intelligent Integration

Integrate mode should be more intelligent than a folder copy. The installer creates inventories and proposal surfaces; the active agent performs semantic classification. If a native hub exists, the agent should read it first, follow existing links, inspect representative notes, and classify material by observed role. If no hub exists, the agent should start from the top-level directory inventory and Markdown inventory.

Allowed outputs after backup confirmation include:

- integration reports;
- deep-review protocols;
- review worksheets;
- native top-layer proposals;
- AGENTS patch proposals;
- category indexes;
- top-layer-only hub cleanup;
- append-only AGENTS entry flow;
- current snapshot, decision log, and risk updates.

Knowledge items should become tasks only when there is a concrete action to perform. A note may be linked from multiple categories when that reflects its role.

## Existing Hub Cleanup

If a hub-like file already exists, possibly in another language, NexuBrain should detect it as a hub candidate. Examples include `Nexus.md`, `Hub.md`, `Home.md`, `Index.md`, `主页.md`, `首页.md`, `入口.md`, `导航.md`, `总览.md`, `目录.md`, and `中枢.md`. In an Obsidian-vault profile, `README.md` should not be treated as a hub candidate by default.

Default behavior without backup confirmation is native-preserving:

```text
Existing hub-like file -> native outgoing links -> .nexubrain/integration proposals
```

With backup-confirmed one-pass setup, an agent must clean the current hub so first-level routes point only to NexuBrain categories such as Tasks, Knowledge, Workspaces, EvidenceChain, Resources, State, and Agent Rules. Original links must be preserved through category nodes after classification, not kept as permanent first-level hub mounts. If no hub-like file exists, the agent may create a native hub after classification.

## Mode 2: Start A Clean Knowledge Base

Use start mode when the user wants a clean NexuBrain structure for a new vault, repository, project, or workspace.

```bash
.nexubrain/installer/nexubrain-init.sh start /path/to/new-vault-or-project --profile obsidian-vault --language zh-cn --interview-confirmed
```

For backward compatibility, omitting the mode still means start:

```bash
.nexubrain/installer/nexubrain-init.sh /path/to/new-vault-or-project
```

Start mode generates the connection layer at the target root.

## Safety Difference

- `guide` writes nothing and helps the agent ask better questions.
- Integrate mode is additive and double-link based.
- `one-pass-after-backup` is for targets with confirmed backups, copied test vaults, or disposable workspaces.
- Start mode creates a clean root-level connection layer for a new workspace.
- `--force` should be used only when intentionally regenerating NexuBrain-generated files.
- Any deletion, move, rename, content rewrite, destructive native edit, or bulk migration of existing knowledge must be treated as a separate human-approved migration task.
