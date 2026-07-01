# Local Deployment Guide

This page is written for humans. It explains how to fork or clone NexuBrain and use it as a local framework source for generating a human-agent collaboration connection layer.

## Who This Is For

- People who already have or want a clean long-term knowledge system.
- People who want Codex, Claude Code, Cursor Agent, or other agents to resume context reliably.
- People who want tasks, workspaces, evidence chains, logs, and agent rules without flooding their visible Obsidian graph with framework maintenance files.

## What You Get

After deployment, you get a local folder that is:

- a Git repository;
- a framework source for generating collaboration connection layers;
- a hidden `.nexubrain/` layer with protocol, templates, and profiles;
- an optional Obsidian-compatible visible connection layer.

## Option A: Fork On GitHub And Clone

Use this if you want your own remote repository.

1. Open the NexuBrain repository on GitHub.
2. Click `Fork` to create your own copy.
3. Choose a local save location.
4. On your fork page, click `Code`, copy the HTTPS clone URL shown by GitHub, and clone the repository. The command below clones the current private development framework source directly:

```bash
git clone https://github.com/TianhuaGao/NexuBrain-dev.git
cd NexuBrain-dev
```

If you have forked NexuBrain, use the clone URL from your own fork page so the local remote points to your repository.

5. Check status:

```bash
git status
```

Expected result: you can see the current branch and there are no unexpected untracked files.

## Option B: Download ZIP

Use this if you only want to try NexuBrain without Git.

1. Click `Code` on GitHub.
2. Choose `Download ZIP`.
3. Extract the archive locally.
4. Open the extracted folder in Obsidian.

Note: ZIP downloads do not include Git history. For long-term use, Option A is recommended.

## Use With Obsidian

Do not treat the whole NexuBrain repository as the user's main vault unless you intentionally want to inspect framework internals.

Recommended path:

1. Keep NexuBrain as a framework source.
2. Generate or copy the connection layer into your real Obsidian vault.
3. Keep `.nexubrain/` hidden or excluded from graph views when possible.
4. Open the generated `Nexus.md`, not the framework source docs.

For first use, read:

- `.nexubrain/core/quick-start.md`
- `.nexubrain/core/protocol.md`
- `AGENTS.md`
- `RESPONSIBLE_USE.md`

## Connect An Agent

In Codex, Claude Code, Cursor Agent, or another agent-capable tool, use the target project or vault as the working directory after the connection layer has been generated.

Recommended setup prompt:

```text
Please read .nexubrain/core/onboarding.md, .nexubrain/core/modes.md, .nexubrain/core/protocol.md, and .nexubrain/manifest.json. First state that NexuBrain configuration requires a short interview, then ask only for language, target, mode, and backup status. Inspect the target workspace with the write-free guide and recommend integrate mode if existing knowledge files are detected. If I confirm this target is backed up or disposable, continue in one pass through hidden review, classification, localized visible nodes, top-layer-only hub cleanup, and append-only AGENTS entry flow. Do not delete, move, rename, overwrite, or rewrite existing files unless I explicitly approve a separate migration.
```

If the agent does not understand Obsidian wiki links, ask it to read these files directly:

```text
AGENTS.md
中枢.md
状态/当前快照.md
知识/知识.md
任务/任务.md
工作区/工作区.md
```

## First Personalization

Recommended order:

1. Let the agent ask for the configuration language as a free-form preference.
2. Confirm the target and whether this is integrate or start mode.
3. Confirm whether the target is backed up, disposable, or a copied test vault.
4. Run or ask the agent to run the guide command.
5. Choose a profile such as Obsidian vault, code repository, research project, content project, or general workspace.
6. For start mode, generate the visible connection layer from `.nexubrain/templates/`. For integrate mode with backup confirmed, generate the hidden review layer, classify existing material, create native top-layer nodes, clean the native hub to top-layer-only first-level routes, and append the AGENTS entry flow in one pass.
7. In start mode, write your current focus in `State/Current-Snapshot.md`. In integrate mode, update `.nexubrain/integration/Agent-Review-Worksheet.md`, `State/Current-Snapshot.md`, and the native top-layer indexes as work proceeds.
8. Create your first task in the generated task index.
9. Register a real workspace in the generated workspace index.
10. Keep framework maintenance material inside `.nexubrain/`.

Prototype commands:

```bash
.nexubrain/installer/nexubrain-init.sh guide /path/to/vault-or-project
.nexubrain/installer/nexubrain-init.sh start /path/to/new-vault-or-project --language zh-cn --interview-confirmed
.nexubrain/installer/nexubrain-init.sh integrate /path/to/existing-vault-or-project --language zh-cn --interview-confirmed --backup-confirmed --hub-edit-policy one-pass-after-backup
```

Use `--force` only when you intentionally want to overwrite NexuBrain-generated files. In integrate mode without backup confirmation, default generated files stay inside `.nexubrain/integration/`; visible native changes require approval. With backup confirmation, routine additive setup may proceed in one pass.

## Recommended Git Workflow

After a coherent structural update:

```bash
git status
git add .
git commit -m "Update brain structure"
```

If your remote is configured:

```bash
git push
```

## Do Not Record

Do not write these into NexuBrain:

- passwords;
- tokens;
- API keys;
- verification codes;
- private keys;
- raw private data;
- commercial or research-sensitive material that has not been sanitized.

## Responsible Use

NexuBrain is intended for research and developer workflows. Do not use it for dangerous, illegal, abusive, or unethical behavior.

Read [.nexubrain/templates/RESPONSIBLE_USE.md](.nexubrain/templates/RESPONSIBLE_USE.md) before deployment and keep those boundaries in your fork.

## FAQ

### Can I fork and use it directly?

Yes, but the preferred path is to use the repository as a framework source, then generate a smaller connection layer for the user's real vault or project.

### Do I have to use Obsidian?

No. NexuBrain is a set of Markdown files, templates, and Git-friendly conventions. Obsidian is optional.

### Can I put code repositories inside NexuBrain?

It is not recommended to put large code repositories directly inside NexuBrain. Prefer recording repository paths, GitHub links, branches, commits, and key entry points in the generated Workspace node, such as `工作区/工作区.md` for `zh-cn`.

### Why hide `.nexubrain/`?

The hidden framework layer prevents installer docs, quick starts, templates, release checklists, logs, and agent-maintenance records from overwhelming the user's human-readable Obsidian graph.

### Can I copy external skills directly into the connection layer?

Not recommended. Register them in [[ExternalSkills/External-Skill-Index]] and evaluate source, permissions, dependencies, output, and risk first.

### Does this replace project management software?

Not completely. NexuBrain is a shared context layer for human-agent collaboration. Project management tools handle team scheduling and status reporting; NexuBrain preserves long-term knowledge, evidence, decisions, and agent continuity.
