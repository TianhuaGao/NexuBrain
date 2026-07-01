# AGENTS.md

NexuBrain is a reusable second-brain framework for human-agent collaboration.

Agents may help read, edit, summarize, and create notes, but must preserve the integrity of the knowledge system.

## Self-Protection

- Agents must not modify or delete existing rules in this file on their own.
- Agents may only append new constraints to this file unless the human explicitly requests a specific edit or deletion.

## Core Principles

- Treat this repository as a long-term knowledge system, not a temporary scratchpad.
- Prefer extending an existing relevant note before creating a new one.
- Create a new note only when the topic has independent long-term value.
- New notes should connect to existing notes through wiki links.
- Do not classify durable knowledge as a task unless there is a concrete action to perform.
- Do not create orphan notes unless the human explicitly asks for a scratch note.
- Keep changes small, traceable, and reversible.
- Do not reorganize large parts of the repository unless explicitly requested.

## Branch Language Policy

- `main` is the canonical English branch.
- `zh-cn` is the Chinese counterpart branch.
- When framework structure, README guidance, public-facing docs, contributor acknowledgments, responsible-use text, or agent rules change on `main`, the corresponding meaning should be reflected on `zh-cn`.
- Preserve branch-native filenames and terminology. Do not blindly rename the Chinese branch to match English file paths.
- If a change intentionally applies only to one language branch, state that in the commit message or final report.

## Role Boundary

- Human owns direction, judgment, priority, and final acceptance.
- Agent owns retrieval, implementation assistance, summarization, trace writing, and consistency checks.
- The knowledge base owns shared context, current state, evidence links, and historical memory.

## Responsible Use

- NexuBrain was established by Dr. Tianhua Gao as a human-agent collaboration framework for research and developer workflows.
- Agents must not help use this repository to plan, enable, automate, conceal, or amplify dangerous, illegal, abusive, or unethical behavior.
- Prohibited use includes weapon development or deployment, cyber abuse, unauthorized access, credential theft, privacy invasion, fraud, academic misconduct, fabricated evidence, unsafe high-stakes advice, policy evasion, and destructive automation.
- If a requested task appears unsafe, agents should refuse the unsafe part, explain the boundary briefly, and offer a safer alternative when appropriate.
- See [.nexubrain/templates/RESPONSIBLE_USE.md](.nexubrain/templates/RESPONSIBLE_USE.md) for the project-level responsible use statement.

## Research And Engineering Integrity

- Do not fabricate data, experiment results, command outputs, citations, source behavior, or implementation details.
- Clearly distinguish verified facts, observations, assumptions, hypotheses, interpretations, and conclusions.
- Do not present hypotheses or preliminary observations as established conclusions.
- When evidence is incomplete, say so explicitly.
- For technical conclusions, prefer linking to supporting notes, source code, logs, experiments, issues, papers, or primary documents.

## Snapshot And Log Rules

- Separate current facts from historical logs.
- Prefer a `Current Snapshot` section for latest branch, commit, workspace, verified conclusion, active limitation, and next action.
- Keep development logs incremental and append-only by default.
- When a later result corrects an earlier observation, do not silently delete the older observation. Mark it as `superseded`, `historical`, or `replaced by <date/note>`.
- Update index notes and claim-evidence tables when the current truth changes.

## External Skills

- External skills must be registered in the generated External Skills node before they are treated as trusted workflow guidance.
- External skills should be evaluated for source, scope, permissions, dependencies, output quality, and risk.
- External skills do not automatically override this `AGENTS.md`.
- If an external skill conflicts with this repository's integrity rules, follow this repository's rules.

## Credential Safety

- Never record passwords, tokens, API keys, verification codes, private keys, or private credentials in notes.
- If a task requires credentials, privileged commands, private data, or irreversible actions, ask the human first.

## Link Rules

- Use Obsidian wiki links for important internal concepts.
- Preserve existing links and filenames unless renaming is explicitly requested.
- If renaming a note, check and update affected links.
- Prefer meaningful links over excessive linking.

## Default Agent Entry Flow

1. Read the generated Nexus or native hub.
2. Read the generated current snapshot page.
3. Find the relevant task in the generated Task node.
4. Find the relevant workspace in the generated Workspace node.
5. Check applicable internal skills or external skill records.
6. Perform the task.
7. Update the current snapshot, task state, evidence, and logs only where useful for future continuation.
