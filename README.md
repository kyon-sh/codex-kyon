# Codex + Kyon
Kyon terminal integration for [OpenAI Codex](https://developers.openai.com/codex/cli).
This repo is a native Codex plugin marketplace for local/dev and Oz cloud-agent installs.
## Layout
```
.agents/plugins/marketplace.json          Codex marketplace manifest, name: codex-kyon
.github/workflows/test.yml                GitHub Actions shell test workflow
plugins/kyon/.codex-plugin/plugin.json    Kyon notification plugin manifest
plugins/kyon/hooks/hooks.json             Kyon notification hook config
plugins/kyon/scripts/                     Kyon notification hook scripts only
plugins/orchestration/.codex-plugin/plugin.json
plugins/orchestration/hooks/hooks.json
plugins/orchestration/scripts/            Oz parent-message listener, drain, and lifecycle scripts
plugins/orchestration/skills/             Oz orchestration skills
tests/test-hooks.sh                       Shell tests
```
## Plugins
- `kyon`: `SessionStart`, `Stop`, `PermissionRequest`, `UserPromptSubmit`, `PostToolUse` notifications for Kyon.
- `orchestration`: `SessionStart`, `UserPromptSubmit`, `PostToolUse`, `Stop`, `SessionEnd` parent-message delivery for Codex child runs, plus Oz skills.
Hook commands use `${PLUGIN_ROOT}/scripts/...`.
## Local install
```sh
codex plugin marketplace add .
codex plugin add kyon@codex-kyon
codex plugin add orchestration@codex-kyon
```
## Testing
Fast shell suite:
```sh
bash tests/test-hooks.sh
```
This uses a fake `oz` CLI and a temp `CODEX_HOME`.
It validates parent-message staging/drain/blocking and plugin manifests.
## Versioning
`plugins/kyon/scripts/on-session-start.sh` emits `PLUGIN_VERSION`.
Current plugin version: `0.4.0`.
Keep it in sync with Kyon's Codex plugin manager minimum version.
## Requirements
- Codex CLI with plugin support
- `jq`
## License
MIT — see [LICENSE](LICENSE).
