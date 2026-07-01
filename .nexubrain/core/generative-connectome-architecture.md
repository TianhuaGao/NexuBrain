# Generative Connectome Architecture

NexuBrain should be understood as a hidden framework layer that generates and grows a user's own human-agent collaboration connection layer.

## Product Definition

NexuBrain is not the user's brain itself. It is a framework source installed beside a knowledge base, project, repository, or workspace.

The framework source provides:

- protocol rules for human-agent collaboration;
- reusable templates;
- deployment profiles;
- agent entry guidance;
- responsible-use and integrity boundaries.

The generated connection layer provides:

- a human-readable Nexus entry;
- current state recovery;
- knowledge organization;
- task tracking;
- workspace registration;
- evidence-aware claims;
- process logs.

## Agent-Led Deployment

NexuBrain setup should be guided by an agent when possible.

- Guide: inspect the target, ask for configuration language, detect existing knowledge files, detect hub-like files, confirm backup status, and recommend a mode.
- Integrate existing knowledge base: generate a hidden `.nexubrain/integration/` review/proposal layer, including an `AGENTS.md` patch proposal. With backup-confirmed one-pass setup, continue directly into native top-layer indexes, top-layer-only hub cleanup, and append-only `AGENTS.md` entry flow while preserving existing folders, notes, lower-level links, and existing agent rules.
- Start clean knowledge base: generate the connection layer at the target root for a new vault, repository, project, or workspace.

Integrate mode can support intelligent classification. The agent may create classifications, workspace proposals, evidence proposals, resource maps, native top-layer nodes, `AGENTS.md` patch proposals, and hub-clean plans. If backup is confirmed, these routine additive steps may be completed in one pass without repeated approval; destructive migration still requires separate human approval.

## Layer Model

```text
User knowledge or project
├── Nexus.md
├── State/
├── Knowledge/
├── Tasks/
├── Workspaces/
├── EvidenceChain/
├── Logs/
└── .nexubrain/
    ├── core/
    ├── templates/
    └── profiles/
```

In start mode, the visible files are the user's working connection layer. In integrate mode, NexuBrain first writes review material under `.nexubrain/integration/`; with backup-confirmed one-pass setup, it may then add a native top-layer made of category nodes, top-layer-only hub links, and an append-only agent entry flow in `AGENTS.md` without stopping for repeated approvals. The existing double-link graph remains valid, and hub candidates in any language should be treated as existing user knowledge by default. The hidden `.nexubrain/` folder is the framework source.

## Why This Matters

Opening the whole framework source as an Obsidian vault makes framework maintenance content visible in the user's graph. That can reduce readability because quick starts, release checklists, templates, skill records, logs, and internal docs appear beside human knowledge.

The generative connectome model keeps the human-facing graph small while preserving the full agent-readable structure.

## Connection Layer Contract

A generated connection layer should include localized visible nodes for the confirmed language. For `zh-cn`:

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
负责任使用.md
```

## Initial Profiles

- Obsidian vault: keep the visible connection layer small and exclude `.nexubrain/` from graph views when possible.
- Code repository: place the generated connection layer near project docs and keep workspaces linked to repository paths, branches, commits, and commands.
- Research project: emphasize knowledge indexes, evidence chains, papers, experiments, assumptions, and limitations.
- Content project: emphasize knowledge background, script state, source claims, production logs, publication metadata, and review boundaries.
- General workspace: emphasize current snapshot, knowledge organization, task state, and workspace registration.

## Target Release Layout

The intended public release should expose only the GitHub-facing README and the hidden framework source:

```text
.
├── .nexubrain/
└── README.md
```

All runnable framework material must therefore live under `.nexubrain/`: installer, manifest, core protocols, profiles, templates, and README assets. Root-level visible connection-layer files belong to generated user workspaces, not to the final framework source repository.

## Development Phases

1. Document the generative connectome architecture.
2. Add `.nexubrain/` as the hidden framework source.
3. Mirror the current visible connection layer into `.nexubrain/templates/`.
4. Add profile-specific generation guidance.
5. Add an installer command inside `.nexubrain/installer/` after the template contract stabilizes.
6. Keep the root `scripts/` entry only as a development compatibility wrapper.
7. Confirm `.nexubrain/` can run independently.
8. Remove or archive legacy visible connection-layer files from the framework repository before public release.

## Compatibility

The generated connection layer may use Obsidian wiki links, plain Markdown paths, or structured metadata. NexuBrain should not depend on Obsidian wiki links for correctness. Wiki links are a UI convenience, not the core protocol.

For mode details, see [.nexubrain/core/deployment-modes.md](.nexubrain/core/deployment-modes.md).
