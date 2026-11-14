#!/usr/bin/env bash
set -e
export PATH="/usr/bin:/bin:$PATH"

PROJECT_PATH="."
PRESET=""
SKILLS=()
RULES=()
OVERWRITE=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        -p|--project) PROJECT_PATH="$2"; shift 2 ;;
        -P|--preset) PRESET="$2"; shift 2 ;;
        -s|--skills) IFS=',' read -r -a arr <<< "$2"; for item in "${arr[@]}"; do for s in $item; do SKILLS+=("$s"); done; done; shift 2 ;;
        -r|--rules) IFS=',' read -r -a arr <<< "$2"; for item in "${arr[@]}"; do for r in $item; do RULES+=("${r%.md}"); done; done; shift 2 ;;
        -o|--overwrite) OVERWRITE=true; shift ;;
        *) PROJECT_PATH="$1"; shift ;;
    esac
done

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE="${SCRIPT_DIR}/.agents"
[ ! -d "$SOURCE" ] && { echo "Lỗi: Không tìm thấy .agents nguồn."; exit 1; }

mkdir -p "$PROJECT_PATH"
DEST="$(cd "$PROJECT_PATH" && pwd)/.agents"

ALL_SKILLS=($(find "${SOURCE}/skills" -mindepth 1 -maxdepth 1 -type d -exec basename {} \;))
ALL_RULES=($(find "${SOURCE}/rules" -mindepth 1 -maxdepth 1 -name "*.md" -exec basename {} .md \;))

if [ ${#SKILLS[@]} -gt 0 ] || [ ${#RULES[@]} -gt 0 ]; then
    SEL_SKILLS=()
    for s in "${SKILLS[@]}"; do [[ " ${ALL_SKILLS[*]} " =~ " ${s} " ]] && SEL_SKILLS+=("$s"); done
    SEL_RULES=()
    for r in "${RULES[@]}"; do [[ " ${ALL_RULES[*]} " =~ " ${r} " ]] && SEL_RULES+=("$r"); done
else
    SEL_SKILLS=("${ALL_SKILLS[@]}")
    SEL_RULES=("${ALL_RULES[@]}")
fi

copy_item() {
    local src="$1" dst="$2" rel="$3"
    mkdir -p "$(dirname "$dst")"
    if [ -f "$dst" ] && [ "$OVERWRITE" = false ]; then
        echo "  [Đã có, bỏ qua] $rel"
    else
        cp "$src" "$dst"
        echo "  [Đã chép] $rel"
    fi
}

echo -e "\nĐang cài cấu hình vào: ${DEST}"

for s in "${SEL_SKILLS[@]}"; do
    s_dir="${SOURCE}/skills/${s}"
    if [ -d "$s_dir" ]; then
        while IFS= read -r f; do
            rel=".agents/${f#"${SOURCE}/"}"
            copy_item "$f" "${DEST}/${f#"${SOURCE}/"}" "$rel"
        done < <(find "$s_dir" -type f)
    fi
done

for r in "${SEL_RULES[@]}"; do
    r_file="${SOURCE}/rules/${r}.md"
    [ -f "$r_file" ] && copy_item "$r_file" "${DEST}/rules/${r}.md" ".agents/rules/${r}.md"
done

need_learnings=false
for item in "${SEL_SKILLS[@]}"; do [[ "$item" =~ ai-learning|human-learning ]] && need_learnings=true; done
for item in "${SEL_RULES[@]}"; do [ "$item" = "load-learnings" ] && need_learnings=true; done
[ ${#SKILLS[@]} -eq 0 ] && [ ${#RULES[@]} -eq 0 ] && need_learnings=true

if [ "$need_learnings" = true ]; then
    mkdir -p "${DEST}/learnings"
    [ ! -f "${DEST}/learnings/.gitkeep" ] && touch "${DEST}/learnings/.gitkeep"
fi

echo -e "Hoàn tất.\n"
