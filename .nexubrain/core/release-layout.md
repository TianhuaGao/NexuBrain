# Release Layout

NexuBrain's target public repository layout is intentionally small:

```text
.
├── .nexubrain/
└── README.md
```

## Root README

`README.md` is the only intentionally visible GitHub-facing document. It should explain what NexuBrain is, when to use `guide`, `start`, and `integrate`, and how an agent should begin setup.

The README may link into `.nexubrain/` for agent-readable protocol details, but it should not require root-level `docs/`, visible connection-layer folders, or installer scripts outside `.nexubrain/`.

## Hidden Framework Source

`.nexubrain/` must contain everything required for standalone framework operation:

- `manifest.json` for machine-readable package metadata;
- `core/` for protocol, onboarding, mode, template, and release-layout guidance;
- `installer/` for the canonical setup script;
- `profiles/` for deployment profiles;
- `templates/` for generated connection-layer files;
- `assets/` for README or framework assets that should not appear as user knowledge;
- `LICENSE` for framework license text if the release chooses not to keep a root-level license file.

## Development Compatibility

During development, the repository may temporarily keep legacy visible connection-layer files, `docs/`, and a root `scripts/` wrapper. These are migration aids, not the final user-facing shape.

Before public release, confirm that `.nexubrain/installer/nexubrain-init.sh` can run `guide`, `start`, and `integrate` without depending on root-level legacy files. Then remove or archive the visible legacy material in a deliberate cleanup pass.
