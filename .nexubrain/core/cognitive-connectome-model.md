# Cognitive Connectome Model

NexuBrain can be described as a generative cognitive connectome framework for human-agent collaborative work.

This document defines what "connectome" means in the NexuBrain context. The key idea is that NexuBrain is not just a memory layer. It is a connectivity framework that links orientation, attention, intention, evidence, judgment, action, learning, memory, and boundary control.

## Why Connectome

In neuroscience, a connectome usually refers to a map of connections in the nervous system. Depending on the level of analysis, people may discuss structural connectivity, functional connectivity, or effective connectivity.

NexuBrain does not claim to model a biological brain. It borrows the connectome idea as a design metaphor and information architecture:

- concepts need routes into tasks, evidence, and action;
- tasks need to connect to workspaces and next actions;
- claims need to connect to sources and evidence;
- current focus needs to connect to longer process history;
- agent actions need to connect to rules, boundaries, and human judgment;
- learning needs to connect back into reusable skills and future workflows.

In this sense, NexuBrain is a cognitive connectome: a connection framework that organizes how human knowledge, project state, evidence, decisions, actions, skills, and agent behavior relate to each other.

## Generative Growth Model

NexuBrain is generative because it does not stop at copying a fixed folder layout. It starts from a small set of protocols, templates, and profiles, then helps a user's working environment grow a connection layer around real activity.

The growth model has five recurring operations:

- seed: create the initial Nexus entry, snapshot, task index, workspace index, evidence chain, logs, and agent rules;
- connect: link tasks to workspaces, claims to evidence, decisions to logs, and skills to repeatable workflows;
- differentiate: let different profiles emphasize code, research, content, or vault-oriented work without splitting the core model;
- prune: keep framework maintenance material out of the user's visible graph and archive outdated process traces when they stop being useful;
- preserve trace: keep enough history for humans and agents to recover judgment, context, and responsibility.

This makes NexuBrain a growing connection layer rather than a static vault template.

## Connectome Is Not Just Memory

A connectome is not the same thing as a memory system. Memory is one important function inside a broader cognitive network.

For NexuBrain, memory-related files such as snapshots and logs matter, but they are not the whole model. The broader model connects multiple cognitive functions:

- orientation: where to start;
- attention: what matters now;
- intention: what the human wants to do;
- evidence: what supports or weakens a claim;
- judgment: what has been decided or remains uncertain;
- action: what gets executed in real workspaces;
- learning: what becomes reusable skill;
- memory: what preserves state, history, and durable knowledge;
- control: what constrains unsafe, unethical, or low-integrity behavior.

So the answer is: NexuBrain's connectome includes memory, but it is not primarily "a memory layer." It is a functional connectivity model for human-agent work.

## Cognitive Functional Layers

NexuBrain's cognitive connectome can be understood as connected functional layers.

| Cognitive Function | Role In NexuBrain | Typical Files |
|---|---|---|
| Orientation | Gives humans and agents a stable starting point | `Nexus.md`, `AGENTS.md` |
| Attention / Focus | Names what matters now and what should happen next | localized current snapshot, e.g. `状态/当前快照.md` |
| Working State | Records current facts, limitations, and active context | localized current snapshot, e.g. `状态/当前快照.md` |
| Intention / Planning | Turns human goals into actionable units of work | localized Task node, e.g. `任务/任务.md`, task pages |
| Semantic Memory / Knowledge | Preserves durable concepts, theories, facts, topic notes, and domain understanding | localized Knowledge node, e.g. `知识/知识.md` |
| Action Environment | Connects plans to real repositories, folders, projects, services, and experiments | localized Workspace node, e.g. `工作区/工作区.md` |
| Evidence / Perception | Connects claims to sources, experiments, logs, papers, or human confirmation | localized Evidence Chain node, e.g. `证据链/证据链.md` |
| Reasoning / Judgment | Records decisions, risks, open questions, and changes in interpretation | localized state notes, e.g. `状态/决策记录.md`, `状态/风险与问题.md` |
| Execution / Action | Preserves what was done, attempted, observed, and changed | localized Logs node, e.g. `日志/日志.md`, work logs |
| Learning / Skill | Captures reusable workflows and evaluated external capabilities | `InternalSkills/`, `ExternalSkills/` |
| Association / External Context | Links external vaults, repositories, resources, and independent knowledge regions | `BrainRegions/`, `Resources/` |
| Boundary / Control | Preserves safety, integrity, credential, and responsible-use constraints | `AGENTS.md`, `RESPONSIBLE_USE.md` |
| Framework Source | Stores the hidden generator, protocol, templates, and profiles | `.nexubrain/` |

## Component Map

The same file can participate in multiple cognitive functions. For example, `State/Current-Snapshot.md` is both attention and working state. `AGENTS.md` is both orientation and control. `Logs/` preserve history, but they also support future judgment and learning.

This is why the connectome metaphor matters: NexuBrain is not a flat folder taxonomy. It is a network of functional relations. In that network, `Knowledge/` is the long-term semantic memory layer; `Tasks/` is the action layer. Existing knowledge should not be classified as a task unless it requires action.

## What NexuBrain Is Not

NexuBrain is not:

- the user's entire brain;
- a claim about biological neural mechanisms;
- a replacement for human judgment;
- only an Obsidian vault template;
- only a task manager;
- only an agent memory folder.

NexuBrain is the connectivity framework that lets these pieces work together.

## Suggested Positioning

Short form:

> NexuBrain is a generative cognitive connectome framework for human-agent collaborative work.

Expanded form:

> NexuBrain is a hidden generative cognitive connectome layer installed beside a knowledge base, project, or repository. It grows recoverable connections among orientation, attention, intention, evidence, judgment, action, learning, memory, and boundary control for human-agent collaboration.

Chinese positioning:

> NexuBrain 是面向人机知识工作的生成式认知连接体框架。它不是用户的大脑本体，而是安装在知识库、项目或代码仓库旁边的隐藏连接层，用来持续生成并维护定向、注意、意图、证据、判断、行动、学习、记忆与边界控制之间的连接，使人机协作可以被恢复、追踪和延续。

## Naming Notes

Recommended terms:

- NexuBrain
- Generative Cognitive Connectome Framework
- Cognitive Connectome Framework
- generative cognitive connectome layer
- cognitive connectome layer
- cognitive functional connectivity
- connection framework
- collaboration network

Terms to avoid as primary positioning:

- skeleton;
- scaffold;
- starter vault;
- template vault;
- Obsidian plugin, unless NexuBrain later ships a real Obsidian plugin.
