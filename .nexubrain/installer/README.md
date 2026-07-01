# Installer Prototype

The canonical installer prototype lives inside `.nexubrain/` so the framework can eventually ship as a hidden source folder plus a single GitHub-facing `README.md`.

The current installer prototype is:

```bash
.nexubrain/installer/nexubrain-init.sh guide <target-directory>
.nexubrain/installer/nexubrain-init.sh interview <target-directory>
.nexubrain/installer/nexubrain-init.sh start <target-directory> --language <language> --interview-confirmed
.nexubrain/installer/nexubrain-init.sh integrate <target-directory> --language <language> --interview-confirmed --hub-edit-policy proposal-only
```

Older development checkouts may contain `scripts/nexubrain-init.sh` as a compatibility wrapper. It is not required for the target public release layout.

Default behavior:

- uses `.nexubrain/templates/` for start mode;
- supports `guide` for agent-facing inspection, interview gate output, and mode recommendation;
- supports `interview` as a write-free alias for the required configuration interview;
- supports `start` for a clean root-level connection layer after interview confirmation;
- supports `integrate` for a hidden `.nexubrain/integration/` review/proposal layer in an existing knowledge base after interview confirmation, including an `AGENTS.md` patch proposal;
- records `--language` when provided as a free-form user preference;
- leaves translation and local explanation to the user's active agent;
- skips existing generated files unless `--force` is used;
- never deletes, moves, renames, overwrites, rewrites, edits existing knowledge files, or modifies `AGENTS.md` in integrate mode without explicit human approval;

Examples:

```bash
.nexubrain/installer/nexubrain-init.sh interview /path/to/vault-or-project
.nexubrain/installer/nexubrain-init.sh guide /path/to/vault-or-project
.nexubrain/installer/nexubrain-init.sh start /path/to/new-vault --language zh-cn --interview-confirmed
.nexubrain/installer/nexubrain-init.sh integrate /path/to/existing-vault --profile obsidian-vault --language zh-cn --interview-confirmed --hub-edit-policy proposal-only
.nexubrain/installer/nexubrain-init.sh integrate /path/to/existing-vault --language zh-cn --interview-confirmed --hub-edit-policy proposal-only --force
```

Future installer work:

- interactive profile selection;
- profile-specific template transforms;
- Obsidian exclusion guidance;
- dry-run mode;
- richer generated installation report;
- approved native top-layer index generation;
- approved append-only `AGENTS.md` patch application.
