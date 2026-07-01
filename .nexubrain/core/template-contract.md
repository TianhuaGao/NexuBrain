# Template Contract

This document defines how NexuBrain connection-layer templates should behave.

## Default Template

`templates/` contains the default complete connection-layer template. It mirrors the NexuBrain framework structure and includes core modules such as Nexus entry, current snapshot, knowledge, tasks, workspaces, evidence chains, logs, brain regions, skills, resources, and responsible-use text.

## Stability Rules

- Templates must not include private paths, personal data, credentials, tokens, or workspace-specific facts.
- Templates should be safe to copy into an empty vault, repository, research project, or content project.
- Default generation must not overwrite existing user files.
- Overwrites require an explicit `--force` flag.
- Template files should remain readable as plain Markdown even without Obsidian.
- Templates must keep durable knowledge separate from actionable tasks.

## Link Rules

Templates may use plain Markdown paths by default. Profile-specific templates may use Obsidian wiki links when the profile is explicitly Obsidian-oriented.

## Generated Connection Layer Rules

Generated files belong to the user's project. The `.nexubrain/` framework source remains the hidden cognitive connectome layer and should not be treated as the user's visible knowledge graph.
