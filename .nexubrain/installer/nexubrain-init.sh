#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  .nexubrain/installer/nexubrain-init.sh guide <target-directory> [--profile name] [--language name]
  .nexubrain/installer/nexubrain-init.sh interview <target-directory> [--profile name] [--language name]
  .nexubrain/installer/nexubrain-init.sh start <target-directory> [--profile name] --language name --interview-confirmed [--force]
  .nexubrain/installer/nexubrain-init.sh integrate <target-directory> [--profile name] --language name --interview-confirmed [--backup-confirmed] --hub-edit-policy policy [--force]
  .nexubrain/installer/nexubrain-init.sh <target-directory> [--profile name] --language name --interview-confirmed [--force]

Generate a NexuBrain connection layer in the target directory from .nexubrain/templates.

Modes:
  guide                 Inspect a target and print an agent-led onboarding recommendation. Writes nothing.
  interview             Print the required configuration interview. Writes nothing.
  start                 Clean start for a new vault, repository, or workspace. Requires interview confirmation before writing.
  integrate             Non-destructive integration for an existing knowledge base. Requires interview confirmation before writing hidden review reports and native top-layer proposals.

Options:
  --profile NAME        Record the intended profile. Current prototype accepts: obsidian-vault, code-repo, research-project, content-project.
  --language NAME       Record the user's preferred configuration language. Required for start and integrate.
  --interview-confirmed Confirm that the agent already asked the minimal configuration interview.
  --backup-confirmed   Confirm the target is backed up, disposable, or a copied test vault. Enables one-pass integrate policy.
  --hub-edit-policy P   Integrate-only. Required values: no-edit, proposal-only, approved-after-review, one-pass-after-backup.
  --force               Overwrite existing NexuBrain-generated files. Use only when intentionally regenerating framework-generated files.
USAGE
}

if [[ $# -lt 1 ]]; then
  usage
  exit 1
fi

mode="start"

case "${1:-}" in
  guide|interview|start|integrate)
    mode="$1"
    shift
    ;;
esac

if [[ $# -lt 1 ]]; then
  usage
  exit 1
fi

target_dir="$1"
force="false"
profile=""
language=""
interview_confirmed="false"
backup_confirmed="false"
hub_edit_policy=""
shift

while [[ $# -gt 0 ]]; do
  case "$1" in
    --force)
      force="true"
      shift
      ;;
    --profile)
      if [[ $# -lt 2 ]]; then
        usage
        exit 1
      fi
      profile="$2"
      shift 2
      ;;
    --language)
      if [[ $# -lt 2 ]]; then
        usage
        exit 1
      fi
      language="$2"
      shift 2
      ;;
    --interview-confirmed)
      interview_confirmed="true"
      shift
      ;;
    --backup-confirmed)
      backup_confirmed="true"
      shift
      ;;
    --hub-edit-policy)
      if [[ $# -lt 2 ]]; then
        usage
        exit 1
      fi
      hub_edit_policy="$2"
      shift 2
      ;;
    *)
      usage
      exit 1
      ;;
  esac
done

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
framework_root="$(cd "$script_dir/.." && pwd)"
source_root="$(cd "$framework_root/.." && pwd)"
template_root="$framework_root/templates"
profile_file=""

if [[ ! -d "$template_root" ]]; then
  echo "Template directory not found: $template_root" >&2
  exit 1
fi

if [[ -n "$profile" ]]; then
  profile_file="$framework_root/profiles/$profile.md"
  if [[ ! -f "$profile_file" ]]; then
    echo "Profile not found: $profile" >&2
    echo "Expected file: $profile_file" >&2
    exit 1
  fi
fi

config_language() {
  if [[ -n "$language" ]]; then
    printf '%s' "$language"
  else
    printf 'unset'
  fi
}

config_profile() {
  if [[ -n "$profile" ]]; then
    printf '%s' "$profile"
  else
    printf 'default'
  fi
}

config_hub_edit_policy() {
  if [[ -n "$hub_edit_policy" ]]; then
    printf '%s' "$hub_edit_policy"
  else
    printf 'unset'
  fi
}

config_backup_confirmed() {
  printf '%s' "$backup_confirmed"
}

language_family() {
  local normalized="${language,,}"

  case "$normalized" in
    zh*|cn|chinese|中文|简体中文|繁體中文|繁体中文)
      printf 'zh'
      ;;
    *)
      printf 'en'
      ;;
  esac
}

display_alias() {
  local key="$1"

  case "$(language_family)" in
    zh)
      case "$key" in
        nexus) printf '中枢' ;;
        current_snapshot) printf '当前快照' ;;
        state) printf '状态' ;;
        decisions) printf '决策记录' ;;
        risks) printf '风险与问题' ;;
        tasks) printf '任务' ;;
        workspaces) printf '工作区' ;;
        knowledge) printf '知识' ;;
        brain_regions) printf '脑区连接' ;;
        internal_skills) printf '内部技能' ;;
        external_skills) printf '外部技能' ;;
        evidence_chain) printf '证据链' ;;
        source_types) printf '来源类型约定' ;;
        logs) printf '日志' ;;
        resources) printf '资源' ;;
        agents) printf 'Agent 规则' ;;
        *) printf '%s' "$key" ;;
      esac
      ;;
    *)
      case "$key" in
        nexus) printf 'Nexus' ;;
        current_snapshot) printf 'Current Snapshot' ;;
        state) printf 'State' ;;
        decisions) printf 'Decisions' ;;
        risks) printf 'Risks And Questions' ;;
        tasks) printf 'Tasks' ;;
        workspaces) printf 'Workspaces' ;;
        knowledge) printf 'Knowledge' ;;
        brain_regions) printf 'Brain Regions' ;;
        internal_skills) printf 'Internal Skills' ;;
        external_skills) printf 'External Skills' ;;
        evidence_chain) printf 'Evidence Chain' ;;
        source_types) printf 'Source Type Conventions' ;;
        logs) printf 'Logs' ;;
        resources) printf 'Resources' ;;
        agents) printf 'Agent Rules' ;;
        *) printf '%s' "$key" ;;
      esac
      ;;
  esac
}

visible_path() {
  local key="$1"

  case "$(language_family)" in
    zh)
      case "$key" in
        nexus) printf '中枢' ;;
        current_snapshot) printf '状态/当前快照' ;;
        state) printf '状态/状态' ;;
        decisions) printf '状态/决策记录' ;;
        risks) printf '状态/风险与问题' ;;
        tasks) printf '任务/任务' ;;
        workspaces) printf '工作区/工作区' ;;
        knowledge) printf '知识/知识' ;;
        brain_regions) printf '脑区/脑区连接' ;;
        internal_skills) printf '内部技能/内部技能' ;;
        external_skills) printf '外部技能/外部技能' ;;
        evidence_chain) printf '证据链/证据链' ;;
        logs) printf '日志/日志' ;;
        resources) printf '资源/资源' ;;
        source_types) printf '证据链/来源类型约定' ;;
        responsible_use) printf '负责任使用' ;;
        agents) printf 'AGENTS' ;;
        *) printf '%s' "$key" ;;
      esac
      ;;
    *)
      case "$key" in
        nexus) printf 'Nexus' ;;
        current_snapshot) printf 'State/Current-Snapshot' ;;
        state) printf 'State/State-Index' ;;
        decisions) printf 'State/Decision-Log' ;;
        risks) printf 'State/Risks-And-Open-Questions' ;;
        tasks) printf 'Tasks/Task-Index' ;;
        workspaces) printf 'Workspaces/Workspace-Index' ;;
        knowledge) printf 'Knowledge/Knowledge-Index' ;;
        brain_regions) printf 'BrainRegions/Brain-Region-Connection-Index' ;;
        internal_skills) printf 'InternalSkills/Internal-Skill-Index' ;;
        external_skills) printf 'ExternalSkills/External-Skill-Index' ;;
        evidence_chain) printf 'EvidenceChain/Evidence-Chain-Index' ;;
        logs) printf 'Logs/Log-Index' ;;
        resources) printf 'Resources/Resource-Index' ;;
        source_types) printf 'EvidenceChain/Source-Type-Conventions' ;;
        responsible_use) printf 'RESPONSIBLE_USE' ;;
        agents) printf 'AGENTS' ;;
        *) printf '%s' "$key" ;;
      esac
      ;;
  esac
}

visible_md_path() {
  printf '%s.md' "$(visible_path "$1")"
}

visible_link() {
  local key="$1"
  printf '[[%s|%s]]' "$(visible_path "$key")" "$(display_alias "$key")"
}

visible_template_path() {
  local rel_path="$1"

  case "$rel_path" in
    Nexus.md) visible_md_path nexus ;;
    State/Current-Snapshot.md) visible_md_path current_snapshot ;;
    State/State-Index.md) visible_md_path state ;;
    State/Decision-Log.md) visible_md_path decisions ;;
    State/Risks-And-Open-Questions.md) visible_md_path risks ;;
    Tasks/Task-Index.md) visible_md_path tasks ;;
    Workspaces/Workspace-Index.md) visible_md_path workspaces ;;
    Knowledge/Knowledge-Index.md) visible_md_path knowledge ;;
    BrainRegions/Brain-Region-Connection-Index.md) visible_md_path brain_regions ;;
    InternalSkills/Internal-Skill-Index.md) visible_md_path internal_skills ;;
    ExternalSkills/External-Skill-Index.md) visible_md_path external_skills ;;
    EvidenceChain/Evidence-Chain-Index.md) visible_md_path evidence_chain ;;
    EvidenceChain/Source-Type-Conventions.md) visible_md_path source_types ;;
    Logs/Log-Index.md) visible_md_path logs ;;
    Resources/Resource-Index.md) visible_md_path resources ;;
    RESPONSIBLE_USE.md) visible_md_path responsible_use ;;
    AGENTS.md) visible_md_path agents ;;
    *) printf '%s' "$rel_path" ;;
  esac
}
should_skip_visible_template_file() {
  local rel_path="$1"

  case "$rel_path" in
    */_Template-*|*/README.md)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

replace_wikilink() {
  local file="$1"
  local old_target="$2"
  local new_target="$3"
  local alias="$4"
  local safe_replacement="${new_target//&/\&}|${alias//&/\&}"

  sed -i -E "s#\[\[$old_target(\|[^]]*)?\]\]#[[$safe_replacement]]#g" "$file"
}

apply_display_aliases() {
  local file="$1"

  case "$file" in
    *.md|*.markdown)
      ;;
    *)
      return
      ;;
  esac

  replace_wikilink "$file" "Nexus" "$(visible_path nexus)" "$(display_alias nexus)"
  replace_wikilink "$file" "State/Current-Snapshot" "$(visible_path current_snapshot)" "$(display_alias current_snapshot)"
  replace_wikilink "$file" "State/State-Index" "$(visible_path state)" "$(display_alias state)"
  replace_wikilink "$file" "State/Decision-Log" "$(visible_path decisions)" "$(display_alias decisions)"
  replace_wikilink "$file" "State/Risks-And-Open-Questions" "$(visible_path risks)" "$(display_alias risks)"
  replace_wikilink "$file" "Tasks/Task-Index" "$(visible_path tasks)" "$(display_alias tasks)"
  replace_wikilink "$file" "Workspaces/Workspace-Index" "$(visible_path workspaces)" "$(display_alias workspaces)"
  replace_wikilink "$file" "Knowledge/Knowledge-Index" "$(visible_path knowledge)" "$(display_alias knowledge)"
  replace_wikilink "$file" "BrainRegions/Brain-Region-Connection-Index" "$(visible_path brain_regions)" "$(display_alias brain_regions)"
  replace_wikilink "$file" "InternalSkills/Internal-Skill-Index" "$(visible_path internal_skills)" "$(display_alias internal_skills)"
  replace_wikilink "$file" "ExternalSkills/External-Skill-Index" "$(visible_path external_skills)" "$(display_alias external_skills)"
  replace_wikilink "$file" "EvidenceChain/Evidence-Chain-Index" "$(visible_path evidence_chain)" "$(display_alias evidence_chain)"
  replace_wikilink "$file" "EvidenceChain/Source-Type-Conventions" "$(visible_path source_types)" "$(display_alias source_types)"
  replace_wikilink "$file" "Logs/Log-Index" "$(visible_path logs)" "$(display_alias logs)"
  replace_wikilink "$file" "Resources/Resource-Index" "$(visible_path resources)" "$(display_alias resources)"
}
print_configuration_interview() {
  echo "# NexuBrain Configuration Interview Required"
  echo
  echo "Before NexuBrain writes any setup files, the agent must tell the user:"
  echo
  echo '```text'
  echo "NexuBrain configuration needs a short interview before I write files. I will confirm language, target, mode, and backup status, then run a read-only guide before applying the selected setup."
  echo '```'
  echo
  echo "## Required Questions"
  echo
  echo "1. Configuration language: which language should I use for guidance and generated notes?"
  echo "2. Target location: which vault, repository, or workspace should NexuBrain configure?"
  echo "3. Mode confirmation: should this be integrate for an existing knowledge base, or start for a clean workspace?"
  echo "4. Backup status: is this target backed up, disposable, or a copied test vault so routine additive setup can proceed in one pass?"
  echo
  echo "## Required Command Gate"
  echo
  echo "Do not run start or integrate until the user has answered the minimal interview. After approval, include --interview-confirmed."
  echo
  echo "Recommended integrate policy when backup is confirmed: --backup-confirmed --hub-edit-policy one-pass-after-backup"
  echo "Recommended integrate policy without backup confirmation: --hub-edit-policy proposal-only"
}

validate_setup_gate() {
  if [[ "$mode" == "guide" || "$mode" == "interview" ]]; then
    return
  fi

  if [[ "$interview_confirmed" != "true" || -z "$language" ]]; then
    print_configuration_interview
    echo
    echo "Refusing to run '$mode' because the configuration interview has not been confirmed or --language is missing." >&2
    exit 2
  fi

  if [[ "$mode" == "integrate" ]]; then
    case "$hub_edit_policy" in
      no-edit|proposal-only|approved-after-review|one-pass-after-backup)
        ;;
      *)
        print_configuration_interview
        echo
        echo "Refusing to run integrate because --hub-edit-policy must be one of: no-edit, proposal-only, approved-after-review, one-pass-after-backup." >&2
        exit 2
        ;;
    esac
    if [[ "$hub_edit_policy" == "one-pass-after-backup" && "$backup_confirmed" != "true" ]]; then
      print_configuration_interview
      echo
      echo "Refusing to run integrate with one-pass-after-backup because --backup-confirmed is missing." >&2
      exit 2
    fi
  fi
}

is_ignored_existing_path() {
  local rel_path="$1"

  case "$rel_path" in
    .*|.*/*|*/.*|*/.*/*|NexuBrain|NexuBrain/*|Hub/NexuBrain-Entry.md|Hub/NexuBrain-Entry|Nexus/NexuBrain-Entry.md|Nexus/NexuBrain-Entry)
      return 0
      ;;
  esac

  return 1
}

knowledge_file_count() {
  if [[ ! -d "$target_dir" ]]; then
    echo 0
    return
  fi

  local count=0
  local file
  local rel_path

  while IFS= read -r -d '' file; do
    rel_path="${file#"$target_dir"/}"
    if is_ignored_existing_path "$rel_path"; then
      continue
    fi
    count=$((count + 1))
  done < <(find "$target_dir" -type f \( -name "*.md" -o -name "*.markdown" -o -name "*.txt" -o -name "*.org" -o -name "*.rst" -o -name "*.pdf" -o -name "*.docx" \) -print0)

  echo "$count"
}

markdown_file_count() {
  if [[ ! -d "$target_dir" ]]; then
    echo 0
    return
  fi

  local count=0
  local file
  local rel_path

  while IFS= read -r -d '' file; do
    rel_path="${file#"$target_dir"/}"
    if is_ignored_existing_path "$rel_path"; then
      continue
    fi
    count=$((count + 1))
  done < <(find "$target_dir" -type f \( -name "*.md" -o -name "*.markdown" \) -print0)

  echo "$count"
}

is_hub_candidate() {
  local path="$1"
  local base="${path##*/}"

  case "$base" in
    README.md|readme.md)
      if [[ "$(config_profile)" == "obsidian-vault" ]]; then
        return 1
      fi
      if [[ "$path" == "$base" ]]; then
        return 0
      fi
      return 1
      ;;
    Nexus.md|nexus.md|Hub.md|hub.md|Home.md|home.md|Index.md|index.md|Start.md|start.md|Dashboard.md|dashboard.md|MOC.md|moc.md|Map-of-Content.md|map-of-content.md|Map\ Of\ Content.md|map\ of\ content.md|主页.md|首頁.md|首页.md|入口.md|导航.md|導航.md|总览.md|總覽.md|索引.md|目录.md|目錄.md|中枢.md|中樞.md|知识库.md|知識庫.md|Accueil.md|accueil.md|Startseite.md|startseite.md|Inicio.md|inicio.md)
      return 0
      ;;
  esac

  return 1
}

list_hub_candidates() {
  if [[ ! -d "$target_dir" ]]; then
    return 1
  fi

  local found="false"
  local file
  local rel_path
  while IFS= read -r -d '' file; do
    rel_path="${file#"$target_dir"/}"
    if is_ignored_existing_path "$rel_path"; then
      continue
    fi
    if is_hub_candidate "$rel_path"; then
      printf '%s\n' "$rel_path"
      found="true"
    fi
  done < <(find "$target_dir" -maxdepth 4 -type f \( -name "*.md" -o -name "*.markdown" \) -print0 | sort -z)

  if [[ "$found" != "true" ]]; then
    return 1
  fi
}

print_hub_candidates_as_list() {
  if ! list_hub_candidates | sed 's/^/- /'; then
    echo "- None detected"
  fi
}

print_hub_outgoing_link_inventory() {
  local found_hub="false"
  local candidate
  local file
  local links

  while IFS= read -r candidate; do
    found_hub="true"
    file="$target_dir/$candidate"
    echo "### $candidate"
    echo

    if [[ ! -f "$file" ]]; then
      echo "- Not a file; inspect manually."
      echo
      continue
    fi

    links="$(grep -oE '\[\[[^]]+\]\]' "$file" 2>/dev/null || true)"
    if [[ -z "$links" ]]; then
      echo "- No outgoing wiki links detected."
      echo
      continue
    fi

    printf '%s\n' "$links" \
      | sed -E 's/^\[\[//; s/\]\]$//; s/\|.*$//' \
      | sort -u \
      | sed 's/^/- [[/; s/$/]]/'
    echo
  done < <(list_hub_candidates || true)

  if [[ "$found_hub" != "true" ]]; then
    echo "- No hub candidate detected."
  fi
}

recommended_mode() {
  local count
  count="$(knowledge_file_count | tr -d ' ')"

  if [[ "${count:-0}" -gt 0 ]]; then
    printf 'integrate'
  else
    printf 'start'
  fi
}

copy_template_file() {
  local rel_path="$1"
  local destination_root="$2"
  local label_prefix="${3:-}"
  local source="$template_root/$rel_path"
  local visible_rel_path
  local destination

  if should_skip_visible_template_file "$rel_path"; then
    echo "skip visible template clutter: ${label_prefix}${rel_path}"
    return
  fi

  visible_rel_path="$(visible_template_path "$rel_path")"
  destination="$destination_root/$visible_rel_path"

  mkdir -p "$(dirname "$destination")"

  if [[ -e "$destination" && "$force" != "true" ]]; then
    echo "skip existing: ${label_prefix}${visible_rel_path}"
    return
  fi

  cp "$source" "$destination"
  apply_display_aliases "$destination"
  echo "generated: ${label_prefix}${visible_rel_path}"
}
write_file_once() {
  local destination="$1"
  local label="$2"

  mkdir -p "$(dirname "$destination")"

  if [[ -e "$destination" && "$force" != "true" ]]; then
    echo "skip existing: $label"
    return 1
  fi

  return 0
}

hide_source_readme_after_setup() {
  local source_readme="$source_root/README.md"
  local hidden_readme="$source_root/.README.md"

  if [[ ! -f "$source_readme" ]]; then
    return
  fi

  if [[ -e "$hidden_readme" ]]; then
    echo "notice: source README.md was not hidden because .README.md already exists."
    return
  fi

  mv "$source_readme" "$hidden_readme"
  echo "hidden: NexuBrain source README.md -> .README.md"
}

generate_configuration_file() {
  local destination="$1"
  local mode_name="$2"
  local label="$3"

  if ! write_file_once "$destination" "$label"; then
    return
  fi

  {
    echo "# NexuBrain Configuration"
    echo
    echo "This file records the initial NexuBrain onboarding configuration."
    echo
    echo "## Configuration"
    echo
    echo "- Language: $(config_language)"
    echo "- Mode: $mode_name"
    echo "- Profile: $(config_profile)"
    echo "- Target: $target_dir"
    echo "- Interview Confirmed: $interview_confirmed"
    echo "- Backup Confirmed: $(config_backup_confirmed)"
    echo "- Hub Edit Policy: $(config_hub_edit_policy)"
    echo
    echo "## Language And Translation Policy"
    echo
    echo "NexuBrain records the user's preferred configuration language, but does not maintain separate built-in translations for every language. The framework source remains canonical in English. The user's agent should translate, summarize, and adapt guidance into the chosen language while preserving paths, filenames, canonical wiki-link targets, and safety boundaries."
    echo
    echo "## Visible Path Policy"
    echo
    echo "Framework source paths remain canonical inside .nexubrain, but generated visible paths should follow the configured language. In Chinese Obsidian vaults, generated graph nodes should use names such as 任务/任务.md and 知识/知识.md instead of English *-Index filenames."
    echo
    echo "## Agent Onboarding Order"
    echo
    echo "1. State that NexuBrain configuration requires a short interview before writing files."
    echo "2. Confirm language, target, mode, and backup status."
    echo "3. Inspect whether existing knowledge files are present with guide mode only."
    echo "4. Recommend integrate mode when existing knowledge files are detected."
    echo "5. If backup is confirmed, proceed through routine additive setup in one pass without repeated approval."
    echo "6. Hide the local NexuBrain source README.md as .README.md after setup so Obsidian does not treat it as a graph node."
    echo "7. Keep deletion, move, rename, overwrite, content rewrite, and destructive migration behind separate explicit approval."
    echo
    echo "## Source README Visibility Policy"
    echo
    echo "The GitHub repository keeps README.md visible. A local configured copy may hide the source README as .README.md after start or integrate setup. This affects the NexuBrain tool folder only; it does not delete user knowledge files and should not be linked from the generated hub."
    if [[ "$mode_name" == "integrate" ]]; then
      echo
      echo "## Native Integration Contract"
      echo
      echo "Integrate mode preserves existing folders, note contents, and lower-level double links as user-owned material. Generated planning files start under .nexubrain/integration/. When backup is confirmed and the policy is one-pass-after-backup, the active agent should continue through semantic classification, visible indexes, lightweight hub connection or cleanup, and append-only AGENTS entry flow without repeated approval."
    fi
  } > "$destination"

  echo "generated: $label"
}

generate_start() {
  while IFS= read -r -d '' source_file; do
    rel_path="${source_file#"$template_root"/}"
    copy_template_file "$rel_path" "$target_dir"
  done < <(find "$template_root" -type f -print0 | sort -z)

  generate_configuration_file "$target_dir/.nexubrain/Configuration.md" "start" ".nexubrain/Configuration.md"

  echo
  hide_source_readme_after_setup
  echo "NexuBrain start connection layer generated in: $target_dir"
  if [[ -n "$profile" ]]; then
    echo "Profile: $profile"
  fi
  if [[ -n "$language" ]]; then
    echo "Language: $language"
  fi
  echo "Next: open $(visible_md_path nexus) and fill $(visible_md_path current_snapshot)."
}

integration_root() {
  printf '%s' "$target_dir/.nexubrain/integration"
}

print_filtered_top_level_items() {
  local found="false"
  local item
  local rel_path

  while IFS= read -r -d '' item; do
    rel_path="${item#"$target_dir"/}"
    if is_ignored_existing_path "$rel_path"; then
      continue
    fi
    printf -- '- %s\n' "$rel_path"
    found="true"
  done < <(find "$target_dir" -mindepth 1 -maxdepth 1 -print0 | sort -z)

  if [[ "$found" != "true" ]]; then
    echo "- None detected"
  fi
}

print_filtered_markdown_inventory() {
  local limit="${1:-200}"
  local emitted=0
  local file
  local rel_path

  while IFS= read -r -d '' file; do
    rel_path="${file#"$target_dir"/}"
    if is_ignored_existing_path "$rel_path"; then
      continue
    fi
    printf -- '- %s\n' "$rel_path"
    emitted=$((emitted + 1))
    if [[ "$emitted" -ge "$limit" ]]; then
      break
    fi
  done < <(find "$target_dir" -type f \( -name "*.md" -o -name "*.markdown" \) -print0 | sort -z)

  if [[ "$emitted" -eq 0 ]]; then
    echo "- None detected"
  fi
}

generate_integration_report() {
  local report_path="$(integration_root)/Integration-Report.md"

  if ! write_file_once "$report_path" ".nexubrain/integration/Integration-Report.md"; then
    return
  fi

  {
    echo "# NexuBrain Integration Report"
    echo
    echo "This hidden report was generated by NexuBrain integrate mode. It is a planning surface for the active agent, not a replacement for the user's native knowledge base."
    echo
    echo "## Mode"
    echo
    echo "- Mode: integrate"
    echo "- Language: $(config_language)"
    echo "- Profile: $(config_profile)"
    echo "- Target: $target_dir"
    echo "- Interview Confirmed: $interview_confirmed"
    echo "- Backup Confirmed: $(config_backup_confirmed)"
    echo "- Hub Edit Policy: $(config_hub_edit_policy)"
    echo
    echo "## Integration Contract"
    echo
    echo "- Keep existing folders, note contents, and lower-level double links as user-owned material."
    echo "- Use NexuBrain as a native top-layer classification frame, not as a parallel vault."
    echo "- Proposed top-layer categories are State, Tasks, Knowledge, Workspaces, EvidenceChain, Resources, and Agent Rules."
    echo "- Existing notes may be linked from one or more top-layer indexes without being moved or rewritten."
    echo "- With backup-confirmed one-pass policy, the native hub first-level navigation must be cleaned during the same setup pass. Otherwise hub edits remain proposal-first."
    echo "- Hub cleanup is not append-only: classified native folders or notes must be demounted from direct first-level hub links after they are preserved through category nodes."
    echo "- If no native hub exists, create one after classification only when backup-confirmed one-pass policy is active; otherwise propose it."
    echo "- Agent startup integration must be proposed in .nexubrain/integration/AGENTS-Patch-Proposal.md before editing AGENTS.md."
    echo "- Existing AGENTS.md rules remain authoritative; with backup-confirmed one-pass policy, NexuBrain may append the entry flow during setup."
    echo "- Do not create a visible parallel NexuBrain/ namespace, Nexus/NexuBrain-Entry.md, or Hub/NexuBrain-Entry.md by default."
    echo "- Write review and proposal material under .nexubrain/integration/ first."
    echo "- Do not delete, move, rename, overwrite, or rewrite existing notes without separate explicit human approval."
    echo
    echo "## Existing Top-Level Items Observed"
    echo
    print_filtered_top_level_items
    echo
    echo "## Hub Candidates Observed"
    echo
    print_hub_candidates_as_list
    echo
    echo "## Existing Markdown Files Observed"
    echo
    print_filtered_markdown_inventory 200
    echo
    echo "If more than 200 Markdown files exist, this preview is intentionally truncated. Hidden, tool, and generated paths are intentionally excluded."
  } > "$report_path"

  echo "generated: .nexubrain/integration/Integration-Report.md"
}

generate_deep_review_protocol() {
  local protocol_path="$(integration_root)/Agent-Deep-Review-Protocol.md"

  if ! write_file_once "$protocol_path" ".nexubrain/integration/Agent-Deep-Review-Protocol.md"; then
    return
  fi

  {
    echo "# Agent Deep Review Protocol"
    echo
    echo "Use this protocol before changing an existing vault or workspace. The goal is to add a native NexuBrain top-layer over the existing double-link graph, not to import notes into a parallel NexuBrain tree."
    echo
    echo "## Required Reading Pass"
    echo
    echo "1. Read the detected hub candidates first when they exist."
    echo "2. If no hub candidate exists, start from Existing Top-Level Items and Existing Markdown Files in Integration-Report.md."
    echo "3. Inventory every existing outgoing wiki link from the native hub before inventing new categories."
    echo "4. Sample important project, source, and task-like notes from the existing graph or folder inventory."
    echo "5. Identify native naming conventions, folder meanings, and language choices."
    echo "6. Map existing notes to NexuBrain top-layer roles without moving or rewriting them."
    echo "7. Record uncertainty as a question in Agent-Review-Worksheet.md instead of guessing."
    echo
    echo "## Classification Roles"
    echo
    echo "Classify existing material into roles such as native hub, State, Tasks, Knowledge, Workspaces, EvidenceChain, Resources, Agent Rules, source or evidence, decision record, archive, or unknown. Do not classify every note as Knowledge by default. A note may belong to multiple roles through double links."
    echo
    echo "## No-Hub Fallback"
    echo
    echo "If no hub candidate is detected, integration still proceeds. Use the top-level directory inventory and Markdown inventory as the initial map, sample representative files, and infer roles with evidence. In backup-confirmed one-pass mode, create a native hub after classification; otherwise propose the hub path for approval."
    echo
    echo "## Allowed Default Writes"
    echo
    echo "- .nexubrain/integration/Integration-Report.md"
    echo "- .nexubrain/integration/Agent-Deep-Review-Protocol.md"
    echo "- .nexubrain/integration/Agent-Review-Worksheet.md"
    echo "- .nexubrain/integration/Native-Top-Layer-Proposal.md"
    echo "- .nexubrain/integration/AGENTS-Patch-Proposal.md"
    echo "- .nexubrain/integration/templates/"
    echo "- .nexubrain/integration/Configuration.md"
    echo
    echo "## Forbidden Defaults"
    echo
    echo "- Do not create NexuBrain/ as a visible parallel namespace."
    echo "- Do not create Nexus/NexuBrain-Entry.md or Hub/NexuBrain-Entry.md as a visible bridge."
    echo "- Do not move native folders into Tasks, Knowledge, or other top-layer directories."
    echo "- Do not rewrite AGENTS.md rules. Generate AGENTS-Patch-Proposal.md first; append it during backup-confirmed one-pass mode or after approval in proposal-first mode."
    echo "- Do not keep classified native folders or notes mounted as first-level hub entries after hub cleanup; if the hub still directly links them, setup is incomplete."
    echo "- Do not treat README files as Obsidian hub candidates."
    echo "- Do not include .git, .obsidian, .agents, .codex, .nexubrain, or other hidden/tool paths in knowledge maps."
    echo "- Do not delete, move, rename, overwrite, or rewrite existing files without separate explicit human approval."
    echo
    echo "## Proposal-First Workflow"
    echo
    echo "1. Fill Agent-Review-Worksheet.md with observed structure and proposed roles."
    echo "2. Propose the native top-layer frame in Native-Top-Layer-Proposal.md."
    echo "3. Propose the agent entry flow in AGENTS-Patch-Proposal.md if future agents should use NexuBrain automatically."
    echo "4. For every outgoing wiki link from the native hub, propose whether it is preserved through Tasks, Knowledge, Workspaces, EvidenceChain, Resources, State, or Agent Rules, then demounted from direct hub exposure."
    echo "5. If no hub exists, propose the new native hub path and language only after classification."
    echo "6. If backup-confirmed one-pass policy is active, continue through additive native setup without repeated approval."
    echo "7. Otherwise ask the human to approve edits outside .nexubrain/integration/."
    echo "8. Make the smallest possible native edits and preserve all original content."
  } > "$protocol_path"

  echo "generated: .nexubrain/integration/Agent-Deep-Review-Protocol.md"
}

generate_agent_review_worksheet() {
  local worksheet_path="$(integration_root)/Agent-Review-Worksheet.md"

  if ! write_file_once "$worksheet_path" ".nexubrain/integration/Agent-Review-Worksheet.md"; then
    return
  fi

  {
    echo "# Agent Review Worksheet"
    echo
    echo "Fill this before editing existing notes. Keep observations separate from proposed actions."
    echo
    echo "## Hub Candidate Review"
    echo
    echo "| Candidate | Existing Role | Evidence | Proposed Treatment | Needs Approval |"
    echo "|---|---|---|---|---|"
    while IFS= read -r candidate; do
      printf '| %s |  |  | inspect native links first | no |\n' "$candidate"
    done < <(list_hub_candidates || true)
    echo
    echo "## Native Hub Outgoing Link Inventory"
    echo
    echo "Every outgoing wiki link below must be classified and preserved through a top-layer node or marked unknown. After cleanup, the hub should directly link only approved top-layer nodes."
    echo
    print_hub_outgoing_link_inventory
    echo
    echo "## Existing Structure Classification"
    echo
    echo "| Existing Item | Native Role Observed | NexuBrain Top-Layer Link | Confidence | Evidence Read | Proposed Next Step |"
    echo "|---|---|---|---|---|---|"
    echo "|  | native hub / project / workspace / durable knowledge / source / resource / task candidate / decision / archive / unknown | State / Tasks / Knowledge / Workspaces / EvidenceChain / Resources / Agent Rules / multiple | low / medium / high |  | propose / ask / no action |"
    echo
    echo "## Hub Demount Plan"
    echo
    echo "Every outgoing wiki link from the native hub must be classified. Classified native links should not remain as first-level hub mounts after cleanup; preserve them through approved category nodes instead."
    echo
    echo "| Existing Hub Or Top-Level Link | Classified As | Preserve Through Node | Keep Directly On Hub? | Reason / Evidence | Approval Status |"
    echo "|---|---|---|---|---|---|"
    echo "|  | Tasks / Knowledge / Workspaces / EvidenceChain / Resources / State / Agent Rules / unknown |  | no; yes only for approved top-layer nodes |  | pending |"
    echo
    echo "## No-Hub Native Entry Proposal"
    echo
    echo "If no hub candidate was detected, propose whether to create a native hub after classification."
    echo
    echo "| Proposed Hub Path | Display Language | First-Level Routes | Approval Status |"
    echo "|---|---|---|---|"
    echo "| $(visible_md_path nexus), or an existing localized native hub if preferred |  | NexuBrain top-layer categories only | pending |"
    echo
    echo "## Native Top-Layer Proposal"
    echo
    echo "| Top-Layer Node | Proposed Native Path | Existing Notes To Link | Hub Treatment | Approval Status |"
    echo "|---|---|---|---|---|"
    echo "| State | $(visible_md_path state) | current focus, snapshots, decisions | visible from hub | pending |"
    echo "| Tasks | $(visible_md_path tasks) | active work, todos, execution records | visible from hub | pending |"
    echo "| Knowledge | $(visible_md_path knowledge) | durable concepts, domain notes | visible from hub | pending |"
    echo "| Workspaces | $(visible_md_path workspaces) | projects, code repos, paper workspaces | visible from hub | pending |"
    echo "| EvidenceChain | $(visible_md_path evidence_chain) | claims, sources, experiments, logs | visible from hub | pending |"
    echo "| Resources | $(visible_md_path resources) | tools, references, environment notes | visible from hub | pending |"
    echo "| Agent Rules | AGENTS.md or Agent-Rules.md; see AGENTS-Patch-Proposal.md | agent instructions and boundaries | visible from hub after approval | pending |"
    echo
    echo "## Template Placement Proposal"
    echo
    echo "| Template Type | Proposed Native Location | Why It Belongs There | Requires Existing File Edit | Approval Status |"
    echo "|---|---|---|---|---|"
    echo "| Task |  |  | yes / no | pending |"
    echo "| Workspace |  |  | yes / no | pending |"
    echo "| Evidence |  |  | yes / no | pending |"
    echo "| Knowledge Note |  |  | yes / no | pending |"
    echo
    echo "## Open Questions For Human"
    echo
    echo "- "
  } > "$worksheet_path"

  echo "generated: .nexubrain/integration/Agent-Review-Worksheet.md"
}

generate_native_top_layer_proposal() {
  local proposal_path="$(integration_root)/Native-Top-Layer-Proposal.md"

  if ! write_file_once "$proposal_path" ".nexubrain/integration/Native-Top-Layer-Proposal.md"; then
    return
  fi

  {
    echo "# Native Top-Layer Proposal"
    echo
    echo "This file describes the visible layer NexuBrain should add. In proposal-first mode it waits for approval. In backup-confirmed one-pass mode it is an execution plan for additive setup. It uses Obsidian-style links to connect existing notes into a higher-level cognitive frame without moving, deleting, or rewriting the existing notes."
    echo
    echo "## Principle"
    echo
    echo "- The existing double-link graph remains valid."
    echo "- Existing files stay where they are."
    echo "- New top-layer category pages classify and link to existing notes."
    echo "- Human-facing hub links should use visible paths in the configured language. Canonical role names stay inside .nexubrain for agent/tool stability."
    echo "- The native hub must be cleaned after approval, or during backup-confirmed one-pass setup, so its first-level routes point only to NexuBrain categories and approved agent entry points."
    echo "- Classified native folders or notes must be demounted from direct hub exposure after they are preserved through category nodes."
    echo "- A note may appear in more than one category when that reflects its real role."
    echo
    echo "## Proposed Top-Layer Nodes"
    echo
    echo "| Category | Visible Native Path | Role |"
    echo "|---|---|---|"
    echo "| State | $(visible_md_path state) | current focus, current snapshot, decisions, open risks |"
    echo "| Tasks | $(visible_md_path tasks) | active work, execution records, todos, delivery state |"
    echo "| Knowledge | $(visible_md_path knowledge) | durable concepts, theories, domain maps, explanations |"
    echo "| Workspaces | $(visible_md_path workspaces) | research projects, code repositories, paper folders, experiments |"
    echo "| EvidenceChain | $(visible_md_path evidence_chain) | claims, sources, citations, experiments, verification trails |"
    echo "| Resources | $(visible_md_path resources) | tools, environment notes, references, external systems |"
    echo "| Agent Rules | AGENTS.md or Agent-Rules.md; proposed through AGENTS-Patch-Proposal.md | agent boundaries, local collaboration rules |"
    echo
    echo "## Required Clean Hub Shape"
    echo
    echo "After explicit approval, or during backup-confirmed one-pass setup, the native hub should be rewritten or cleaned so first-level navigation routes only through the top-layer nodes. Do not merely append this section below the old links. Classified native directories must not remain as first-level hub entries:"
    echo
    echo '```markdown'
    echo "# <Native Hub Title>"
    echo
    echo "## NexuBrain"
    echo
    echo "- $(visible_link state)"
    echo "- $(visible_link tasks)"
    echo "- $(visible_link knowledge)"
    echo "- $(visible_link workspaces)"
    echo "- $(visible_link evidence_chain)"
    echo "- $(visible_link resources)"
    echo "- $(display_alias agents): AGENTS.md (agent startup file; keep as append-only control surface, not a primary graph route)"
    echo
    echo "## Original Link Preservation Outside Hub"
    echo
    echo "Do not keep classified original links here as direct hub routes. Preserve classified links inside the approved category nodes. Keep uncertain links only in Agent-Review-Worksheet.md or an approved temporary review file until they are classified."
    echo '```'
    echo
    echo "## Hub Cleanup Validation"
    echo
    echo "Setup is incomplete if the native hub still directly links classified original folders or notes such as project folders, tool notes, source indexes, or topic pages. Those links must be reachable through Tasks, Knowledge, Workspaces, EvidenceChain, Resources, State, or Agent Rules instead."
    echo
    echo "## No-Hub Case"
    echo
    echo "If no native hub exists, create the hub above after reading the top-level inventory and classifying representative notes only in backup-confirmed one-pass mode. Otherwise propose the hub path for approval."
    echo
    echo "## Mapping Rules"
    echo
    echo "- Current attention and active work, such as research plans or development records, usually link from Tasks and Workspaces."
    echo "- Durable concepts, domain maps, and explanatory notes link from Knowledge."
    echo "- Code repositories, paper folders, experiments, and project folders link from Workspaces."
    echo "- Claims, sources, citations, experiment logs, and verification records link from EvidenceChain."
    echo "- Toolchains, environment setup, software manuals, and external references link from Resources."
    echo "- Agent instructions and safety rules link from Agent Rules."
    echo
    echo "## Approval Boundary"
    echo
    echo "In proposal-first mode, do not create or edit these native paths until the human approves the proposal. In backup-confirmed one-pass mode, the original setup approval covers these additive native paths. Neither mode allows moving or rewriting existing lower-level notes. Classified native links should be removed from first-level hub exposure only by changing hub links, not by moving files."
  } > "$proposal_path"

  echo "generated: .nexubrain/integration/Native-Top-Layer-Proposal.md"
}

generate_agents_patch_proposal() {
  local proposal_path="$(integration_root)/AGENTS-Patch-Proposal.md"

  if ! write_file_once "$proposal_path" ".nexubrain/integration/AGENTS-Patch-Proposal.md"; then
    return
  fi

  {
    echo "# AGENTS Patch Proposal"
    echo
    echo "This proposal connects NexuBrain to agent startup behavior. It is append-only by default and must not overwrite existing AGENTS.md rules."
    echo
    echo "## Why This Matters"
    echo
    echo "Codex and similar agents reliably read AGENTS.md. NexuBrain visible nodes help only after the agent knows they exist."
    echo
    echo "## Existing Agent Rule Files Observed"
    echo
    if [[ -e "$target_dir/AGENTS.md" ]]; then
      echo "- AGENTS.md: present"
    else
      echo "- AGENTS.md: not found"
    fi
    if [[ -e "$target_dir/Agent-Rules.md" ]]; then
      echo "- Agent-Rules.md: present"
    else
      echo "- Agent-Rules.md: not found"
    fi
    echo
    echo "## Detected Hub Candidates"
    echo
    print_hub_candidates_as_list
    echo
    echo "## Proposed Patch"
    echo
    echo '```markdown'
    echo "## NexuBrain Entry Flow"
    echo
    echo "- This workspace uses NexuBrain as a local human-agent coordination layer."
    echo "- Before non-trivial research, writing, coding, or knowledge-management tasks, agents should:"
    echo '  1. Read the local `AGENTS.md` rules first and keep them authoritative.'
    echo '  2. Inspect the native hub, such as `中枢.md`, `Nexus.md`, `Hub.md`, or the hub candidate reported by `.nexubrain/integration/Integration-Report.md`; if no hub exists, inspect the top-level inventory in the integration report.'
    echo "  3. Open \`$(visible_md_path current_snapshot)\`, if present."
    echo "  4. Open \`$(visible_md_path tasks)\`, if present."
    echo "  5. Open \`$(visible_md_path workspaces)\`, if present."
    echo "  6. Open \`$(visible_md_path evidence_chain)\` when claims, experiments, code behavior, or paper writing are involved."
    echo '- NexuBrain does not override this `AGENTS.md`; it provides navigation, state, task, workspace, evidence, and resource nodes.'
    echo "- Keep updates lightweight. Use NexuBrain visible nodes when they help future continuation, and avoid administrative noise for small tasks."
    echo '```'
    echo
    echo "## Apply Policy"
    echo
    echo "- If AGENTS.md exists, append the patch under a new heading during backup-confirmed one-pass setup or after approval in proposal-first mode."
    echo "- If AGENTS.md does not exist, create a minimal AGENTS.md in backup-confirmed one-pass mode or propose one in proposal-first mode."
    echo "- Do not remove, reorder, or rewrite existing AGENTS.md rules."
    echo "- Do not edit Agent-Rules.md unless the human explicitly chooses that file as the native agent-rule surface."
    echo "- Record any applied edit in this proposal or Agent-Review-Worksheet.md."
  } > "$proposal_path"

  echo "generated: .nexubrain/integration/AGENTS-Patch-Proposal.md"
}

generate_integration_templates() {
  local template_dir="$(integration_root)/templates"
  local task_template="$template_dir/Task-Template.md"
  local workspace_template="$template_dir/Workspace-Template.md"
  local evidence_template="$template_dir/Evidence-Template.md"
  local knowledge_template="$template_dir/Knowledge-Note-Template.md"

  if write_file_once "$task_template" ".nexubrain/integration/templates/Task-Template.md"; then
    {
      echo "# Task Template"
      echo
      echo "Use only for concrete actions with an owner, next step, or deadline. Do not convert durable knowledge into a task unless there is a real action."
      echo
      echo "## Task"
      echo
      echo "- Status: proposed"
      echo "- Owner:"
      echo "- Source Link:"
      echo "- Next Step:"
      echo "- Done When:"
    } > "$task_template"
    echo "generated: .nexubrain/integration/templates/Task-Template.md"
  fi

  if write_file_once "$workspace_template" ".nexubrain/integration/templates/Workspace-Template.md"; then
    {
      echo "# Workspace Template"
      echo
      echo "Use for an active project, research thread, writing effort, experiment, or coordinated work area."
      echo
      echo "## Workspace"
      echo
      echo "- Purpose:"
      echo "- Native Hub Link:"
      echo "- Related Notes:"
      echo "- Current State:"
      echo "- Open Questions:"
    } > "$workspace_template"
    echo "generated: .nexubrain/integration/templates/Workspace-Template.md"
  fi

  if write_file_once "$evidence_template" ".nexubrain/integration/templates/Evidence-Template.md"; then
    {
      echo "# Evidence Template"
      echo
      echo "Use for claims, sources, observations, excerpts, logs, and verification trails."
      echo
      echo "## Evidence"
      echo
      echo "- Claim Or Question:"
      echo "- Source Link:"
      echo "- Evidence Type: source / observation / experiment / citation / log"
      echo "- Reliability: low / medium / high"
      echo "- Notes:"
    } > "$evidence_template"
    echo "generated: .nexubrain/integration/templates/Evidence-Template.md"
  fi

  if write_file_once "$knowledge_template" ".nexubrain/integration/templates/Knowledge-Note-Template.md"; then
    {
      echo "# Knowledge Note Template"
      echo
      echo "Use for durable concepts, explanations, definitions, models, and domain understanding."
      echo
      echo "## Knowledge"
      echo
      echo "- Topic:"
      echo "- Summary:"
      echo "- Related Native Notes:"
      echo "- Evidence Links:"
      echo "- Open Questions:"
    } > "$knowledge_template"
    echo "generated: .nexubrain/integration/templates/Knowledge-Note-Template.md"
  fi
}

generate_integrate() {
  mkdir -p "$(integration_root)"

  generate_integration_report
  generate_deep_review_protocol
  generate_agent_review_worksheet
  generate_native_top_layer_proposal
  generate_agents_patch_proposal
  generate_integration_templates
  generate_configuration_file "$(integration_root)/Configuration.md" "integrate" ".nexubrain/integration/Configuration.md"

  echo
  hide_source_readme_after_setup
  echo "NexuBrain integrate planning layer generated in: $(integration_root)"
  if [[ -n "$profile" ]]; then
    echo "Profile: $profile"
  fi
  if [[ -n "$language" ]]; then
    echo "Language: $language"
  fi
  if [[ "$hub_edit_policy" == "one-pass-after-backup" ]]; then
    echo "Next: continue through semantic classification, visible top-layer nodes, top-layer-only hub cleanup, and append-only AGENTS entry flow. Do not delete, move, rename, overwrite, or rewrite existing notes."
  else
    echo "Next: open .nexubrain/integration/Agent-Deep-Review-Protocol.md, .nexubrain/integration/Native-Top-Layer-Proposal.md, and .nexubrain/integration/AGENTS-Patch-Proposal.md, then inspect the native hub before editing any existing note."
  fi
}

generate_guide() {
  local knowledge_count
  local markdown_count
  local recommendation
  local language_arg
  knowledge_count="$(knowledge_file_count | tr -d ' ')"
  markdown_count="$(markdown_file_count | tr -d ' ')"
  recommendation="$(recommended_mode)"
  if [[ -n "$language" ]]; then
    language_arg="--language $language"
  else
    language_arg="--language <language>"
  fi

  echo "# NexuBrain Agent Onboarding Guide"
  echo
  echo "## Interview Gate"
  echo
  echo "Before writing any setup files, tell the user that NexuBrain configuration needs a short interview. Ask for language, target, mode, and backup status, then run this read-only guide. If backup is confirmed, continue in one pass for routine additive setup."
  echo
  print_configuration_interview
  echo
  echo "## Target Inspection"
  echo
  echo "Target: $target_dir"
  if [[ -d "$target_dir" ]]; then
    echo "Target exists: yes"
  else
    echo "Target exists: no"
  fi
  echo "Detected knowledge files: ${knowledge_count:-0}"
  echo "Detected Markdown files: ${markdown_count:-0}"
  echo "Recommended mode: $recommendation"
  echo
  echo "## Step 1: Confirm Language"
  echo
  echo "Ask the user which language NexuBrain should use for configuration and guidance. This is a free-form preference; examples include zh-cn, en, ja, fr, de, es, or any language the user's agent can handle."
  echo
  echo "The framework source remains canonical in English. The user's agent should handle translation and local explanation in the chosen language."
  echo
  echo "## Step 2: Confirm Mode And Backup"
  echo
  if [[ "$recommendation" == "integrate" ]]; then
    echo "Existing knowledge files were detected, so recommend integrate mode. Ask whether the target is backed up, disposable, or a copied test vault. If yes, use one-pass-after-backup and continue through hidden review, classification, visible nodes, top-layer-only hub cleanup, and append-only AGENTS entry flow without repeated approval. If no, use proposal-only and ask before visible native edits."
  else
    echo "No existing knowledge files were detected, so recommend start mode. Explain that start mode creates a clean root-level structure."
  fi
  echo
  echo "## Hub Candidates"
  echo
  print_hub_candidates_as_list
  echo
  echo "## Command After Interview Approval"
  echo
  echo "Do not run a writing command until the user has answered the minimal interview. If backup is confirmed, the single setup approval covers routine additive one-pass integrate."
  echo
  if [[ "$recommendation" == "integrate" ]]; then
    printf 'Backup-confirmed one-pass:
.nexubrain/installer/nexubrain-init.sh integrate "%s" %s --interview-confirmed --backup-confirmed --hub-edit-policy one-pass-after-backup

Proposal-first without backup:
.nexubrain/installer/nexubrain-init.sh integrate "%s" %s --interview-confirmed --hub-edit-policy proposal-only
' "$target_dir" "$language_arg" "$target_dir" "$language_arg"
  else
    printf '.nexubrain/installer/nexubrain-init.sh start "%s" %s --interview-confirmed
' "$target_dir" "$language_arg"
  fi

}

validate_setup_gate
if [[ "$mode" != "guide" && "$mode" != "interview" ]]; then
  mkdir -p "$target_dir"
fi

case "$mode" in
  guide|interview)
    generate_guide
    ;;
  start)
    generate_start
    ;;
  integrate)
    generate_integrate
    ;;
  *)
    usage
    exit 1
    ;;
esac
