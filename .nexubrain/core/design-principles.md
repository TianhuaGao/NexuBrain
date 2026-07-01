# Design Principles

## 1. Framework Source Is Not The User Brain

NexuBrain should be treated as a framework source that can generate and grow a user's own human-agent collaboration connection layer. The framework itself should not automatically become the user's visible knowledge graph.

## 2. Hidden Framework Layer, Visible Human Connection Layer

The preferred deployment shape is a hidden `.nexubrain/` layer plus a small generated connection layer. Framework maintenance files, installer notes, quick starts, templates, and profiles belong in `.nexubrain/`. Human-facing navigation belongs in generated visible files whose paths follow the confirmed configuration language. For example, a Chinese Obsidian vault should see paths such as `中枢.md`, `状态/当前快照.md`, `知识/知识.md`, `任务/任务.md`, and `工作区/工作区.md`.

## 3. Visible Paths Preserve Graph Readability

Keep canonical English template names inside the hidden `.nexubrain/` framework source. Do not expose those internal names as the user's visible graph when a localized setup is requested. Obsidian graph view displays real file basenames, not only wiki-link aliases, so generated visible filenames and wiki-link targets should be localized rather than merely aliased. See `visible-path-policy.md`.

## 4. Nexus First

Every long-term knowledge system needs a central entry point. [[Nexus|Nexus]] is the generated hub for NexuBrain start mode: it does not store everything; it helps the human and the agent find current state, knowledge, tasks, workspaces, and rules. In integrate mode, an existing native hub may keep its original name.

## 5. The State Layer Stores Current Context

The state layer does not try to absorb everything. It stores the current cognitive state, working context, decisions, risks, and routes into tasks, knowledge, and workspaces.

## 6. Brain Regions Stay Independent

External vaults, code repositories, resource libraries, and project folders can be connected through the Brain Regions layer, but they should not be merged into the generated connection layer without intent. Their durable concepts and topic notes can be indexed through the Knowledge layer.

## 7. Current Snapshot And Historical Logs Are Separate

The current snapshot answers "what is true now." Logs answer "how did we get here."

## Knowledge Is Not Task

`Knowledge/` is the long-term semantic memory layer. It stores durable concepts, facts, theories, topic notes, and domain understanding. `Tasks/` stores actionable intentions. A knowledge item should become a task only when the human wants to organize, verify, write, produce, migrate, publish, or otherwise act on it.

## 8. Evidence Chains Come First

Important claims should connect to source code, experiments, literature, official documentation, logs, or explicit human confirmation. Agent explanations may be interpretations, but they are not Verified evidence by themselves.

## 9. External Skills Are Isolated First

External skills are valuable, but they should not automatically become main-brain rules. Register, evaluate, adapt, and then use them.

## 10. Human Keeps Authority

Agents may act proactively, but direction, boundaries, final judgment, and irreversible actions remain human responsibilities.
