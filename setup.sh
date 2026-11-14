#!/usr/bin/env bash
#
# AGENT FOUNDRY - BỘ CÀI ĐẶT CẤU HÌNH DỰ ÁN (Bash Script for Linux/macOS)
#

set -e

# ANSI Color codes
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
GRAY='\033[0;90m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

echo -e "\n${CYAN}=======================================================${NC}"
echo -e "${CYAN}       AGENT FOUNDRY - BỘ CÀI ĐẶT CẤU HÌNH DỰ ÁN       ${NC}"
echo -e "${CYAN}=======================================================\n${NC}"

# 1. Đường dẫn gốc repo
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_AGENTS="${SCRIPT_DIR}/.agents"
TEMPLATE_AGENTS_MD="${SCRIPT_DIR}/templates/AGENTS.md"

if [ ! -d "${SOURCE_AGENTS}" ]; then
    echo -e "${RED}[LỖI] Không tìm thấy thư mục nguồn .agents tại: ${SOURCE_AGENTS}${NC}"
    exit 1
fi

# Giá trị mặc định
PROJECT_PATH="."
PRESET=""
SKILLS=()
RULES=()
OVERWRITE=false

usage() {
    cat << EOF
Cách sử dụng:
  ./setup.sh [-p <path>] [-P <base|web|all>] [-s <skill1,skill2>] [-r <rule1,rule2>] [-o]

Các tùy chọn:
  -p, --project <path>    Đường dẫn tới dự án đích (mặc định: ".")
  -P, --preset <name>     Gói cấu hình định sẵn: "base", "web", hoặc "all"
  -s, --skills <list>     Danh sách kỹ năng cần cài (phân tách bởi dấu phẩy hoặc dấu cách)
  -r, --rules <list>      Danh sách quy tắc cần cài (phân tách bởi dấu phẩy hoặc dấu cách)
  -o, --overwrite         Ghi đè file nếu có xung đột nội dung
  -h, --help              Hiển thị trợ giúp này

Ví dụ:
  # Cài đặt nền tảng:
  ./setup.sh -p /path/to/project -P base
  
  # Cài đặt chọn lọc nhiều kỹ năng và quy tắc:
  ./setup.sh -p /path/to/project -s "frontend-design,webapp-testing" -r "web-design-backbone,load-learnings"
  
  # Cài đặt trọn bộ web:
  ./setup.sh -p /path/to/project -P web
EOF
    exit 0
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -p|--project)
            PROJECT_PATH="$2"
            shift 2
            ;;
        -P|--preset)
            PRESET="$2"
            shift 2
            ;;
        -s|--skills)
            IFS=',' read -r -a SKILLS_IN <<< "$2"
            for s in "${SKILLS_IN[@]}"; do
                for item in $s; do
                    s_trimmed=$(echo "$item" | xargs)
                    [ -n "$s_trimmed" ] && SKILLS+=("$s_trimmed")
                done
            done
            shift 2
            ;;
        -r|--rules)
            IFS=',' read -r -a RULES_IN <<< "$2"
            for r in "${RULES_IN[@]}"; do
                for item in $r; do
                    r_trimmed=$(echo "$item" | xargs)
                    r_trimmed="${r_trimmed%.md}"
                    [ -n "$r_trimmed" ] && RULES+=("$r_trimmed")
                done
            done
            shift 2
            ;;
        -o|--overwrite)
            OVERWRITE=true
            shift
            ;;
        -h|--help)
            usage
            ;;
        *)
            if [[ "$1" != -* ]] && [ "$PROJECT_PATH" = "." ]; then
                PROJECT_PATH="$1"
                shift
            else
                echo -e "${RED}[LỖI] Tham số không hợp lệ: $1${NC}"
                usage
            fi
            ;;
    esac
done

# Tạo thư mục đích nếu chưa có
mkdir -p "$PROJECT_PATH"
TARGET_DIR="$(cd "$PROJECT_PATH" && pwd)"
TARGET_AGENTS="${TARGET_DIR}/.agents"
TARGET_AGENTS_MD="${TARGET_DIR}/AGENTS.md"

# Thu thập toàn bộ danh sách skills và rules có sẵn trong kho
ALL_AVAILABLE_SKILLS=()
while IFS= read -r dir; do
    [ -n "$dir" ] && ALL_AVAILABLE_SKILLS+=("$(basename "$dir")")
done < <(find "${SOURCE_AGENTS}/skills" -mindepth 1 -maxdepth 1 -type d)

ALL_AVAILABLE_RULES=()
while IFS= read -r file; do
    fname="$(basename "$file")"
    ALL_AVAILABLE_RULES+=("${fname%.md}")
done < <(find "${SOURCE_AGENTS}/rules" -mindepth 1 -maxdepth 1 -name "*.md")

SELECTED_SKILLS=()
SELECTED_RULES=()
INSTALL_BASE_TEMPLATE=false
MODE_DESC=""

if [ ${#SKILLS[@]} -gt 0 ] || [ ${#RULES[@]} -gt 0 ]; then
    MODE_DESC="Tùy chọn từng mục (Custom Selection)"
    for s in "${SKILLS[@]}"; do
        found=false
        for avail in "${ALL_AVAILABLE_SKILLS[@]}"; do
            if [ "$s" = "$avail" ]; then
                SELECTED_SKILLS+=("$s")
                found=true
                break
            fi
        done
        if [ "$found" = false ]; then
            echo -e "${YELLOW}  [CẢNH BÁO] Không tìm thấy skill '$s' trong kho bộ cài!${NC}"
        fi
    done

    for r in "${RULES[@]}"; do
        found=false
        for avail in "${ALL_AVAILABLE_RULES[@]}"; do
            if [ "$r" = "$avail" ]; then
                SELECTED_RULES+=("$r")
                found=true
                break
            fi
        done
        if [ "$found" = false ]; then
            echo -e "${YELLOW}  [CẢNH BÁO] Không tìm thấy rule '$r' trong kho bộ cài!${NC}"
        fi
    done

    if [ "$PRESET" = "base" ]; then
        INSTALL_BASE_TEMPLATE=true
    fi
elif [ "$PRESET" = "base" ]; then
    MODE_DESC="Preset: 'base' (Khởi tạo AGENTS.md cơ bản tại gốc dự án)"
    INSTALL_BASE_TEMPLATE=true
elif [ "$PRESET" = "web" ]; then
    MODE_DESC="Preset: 'web' (Trọn bộ 9 skills và 2 rules phát triển Web Frontend / Fullstack)"
    SELECTED_SKILLS=("${ALL_AVAILABLE_SKILLS[@]}")
    SELECTED_RULES=("${ALL_AVAILABLE_RULES[@]}")
elif [ "$PRESET" = "all" ]; then
    MODE_DESC="Preset: 'all' (Toàn bộ kho cấu hình bao gồm AGENTS.md và toàn bộ skills/rules)"
    INSTALL_BASE_TEMPLATE=true
    SELECTED_SKILLS=("${ALL_AVAILABLE_SKILLS[@]}")
    SELECTED_RULES=("${ALL_AVAILABLE_RULES[@]}")
else
    # Mặc định: preset web
    MODE_DESC="Preset: 'web' (Mặc định khi không chỉ định preset)"
    SELECTED_SKILLS=("${ALL_AVAILABLE_SKILLS[@]}")
    SELECTED_RULES=("${ALL_AVAILABLE_RULES[@]}")
fi

# Tự động giải quyết phụ thuộc kỹ năng (Skill Dependencies)
has_skill() {
    local target="$1"
    for item in "${SELECTED_SKILLS[@]}"; do
        if [ "$item" = "$target" ]; then return 0; fi
    done
    return 1
}

if has_skill "plan"; then
    if ! has_skill "brainstorming"; then
        SELECTED_SKILLS+=("brainstorming")
        echo -e "${YELLOW}  [TỰ ĐỘNG BỔ SUNG PHỤ THUỘC] Kỹ năng 'plan' cần 'brainstorming' để thực hiện Pha 1 (Brainstorming).${NC}"
    fi
    if ! has_skill "ai-learning"; then
        SELECTED_SKILLS+=("ai-learning")
        echo -e "${YELLOW}  [TỰ ĐỘNG BỔ SUNG PHỤ THUỘC] Kỹ năng 'plan' cần 'ai-learning' để thực hiện Pha 3 (Save Learnings).${NC}"
    fi
fi

echo -e "${GRAY}Chế độ cài đặt        : ${MODE_DESC}${NC}"
echo -e "${GRAY}Thư mục nguồn bộ cài  : ${SOURCE_AGENTS}${NC}"
echo -e "${GRAY}Thư mục dự án đích    : ${TARGET_DIR}${NC}"
echo -e "${GRAY}Cài đặt AGENTS.md     : $([ "$INSTALL_BASE_TEMPLATE" = true ] && echo "Có" || echo "Không")${NC}"
echo -e "${GRAY}Skills đã chọn (${#SELECTED_SKILLS[@]})     : $(IFS=', '; echo "${SELECTED_SKILLS[*]}")${NC}"
echo -e "${GRAY}Rules đã chọn (${#SELECTED_RULES[@]})      : $(IFS=', '; echo "${SELECTED_RULES[*]}")${NC}\n"

STAT_CREATED=0
STAT_IDENTICAL=0
STAT_CONFLICT=0
STAT_OVERWRITTEN=0
CONFLICTED_FILES=()

# Hàm tính SHA256 checksum
calc_hash() {
    local target_file="$1"
    if command -v sha256sum &> /dev/null; then
        sha256sum "$target_file" | awk '{print $1}'
    elif command -v shasum &> /dev/null; then
        shasum -a 256 "$target_file" | awk '{print $1}'
    else
        # Fallback md5
        md5sum "$target_file" | awk '{print $1}'
    fi
}

# Xử lý AGENTS.md
if [ "$INSTALL_BASE_TEMPLATE" = true ]; then
    if [ ! -f "$TEMPLATE_AGENTS_MD" ]; then
        echo -e "${RED}[LỖI] Không tìm thấy file mẫu AGENTS.md tại: ${TEMPLATE_AGENTS_MD}${NC}"
    else
        if [ ! -f "$TARGET_AGENTS_MD" ]; then
            cp "$TEMPLATE_AGENTS_MD" "$TARGET_AGENTS_MD"
            echo -e "${GREEN}  [TẠO MỚI] AGENTS.md (tại gốc dự án)${NC}"
            ((STAT_CREATED++))
        else
            src_hash=$(calc_hash "$TEMPLATE_AGENTS_MD")
            dst_hash=$(calc_hash "$TARGET_AGENTS_MD")

            if [ "$src_hash" = "$dst_hash" ]; then
                echo -e "${GRAY}  [BỎ QUA - GIỐNG HỆT] AGENTS.md${NC}"
                ((STAT_IDENTICAL++))
            else
                if [ "$OVERWRITE" = true ]; then
                    cp "$TEMPLATE_AGENTS_MD" "$TARGET_AGENTS_MD"
                    echo -e "${MAGENTA}  [GHI ĐÈ THEO YÊU CẦU] AGENTS.md${NC}"
                    ((STAT_OVERWRITTEN++))
                else
                    echo -e "${YELLOW}  [GIỮ NGUYÊN DỰ ÁN] AGENTS.md${NC}"
                    echo -e "${YELLOW}     -> File AGENTS.md đã tồn tại trong dự án đích. Đã giữ nguyên file hiện có!${NC}"
                    echo -e "${CYAN}     -> Phần hướng dẫn nên bổ sung vào AGENTS.md hiện có (nếu chưa có):${NC}"
                    echo -e "${CYAN}--------------------------------------------------------------------------------"
                    echo -e "## Bốn Luật Nền Cốt Lõi:"
                    echo -e "1. Đọc cấu trúc & theo quy ước hiện có"
                    echo -e "2. Giữ thay đổi đúng phạm vi"
                    echo -e "3. Chạy kiểm tra phù hợp trước khi báo xong"
                    echo -e "4. Tra CATALOG.md để cài thêm đúng mục khi cần\n"
                    echo -e "## Hướng Dẫn Dành Cho Anti Khi Cần Thêm Cấu Hình:"
                    echo -e "- Tra cứu bảng 'Việc cần làm -> mục cần cài' trong file CATALOG.md"
                    echo -e "- Chạy lệnh setup chọn lọc:"
                    echo -e "  <Đường_dẫn_kho>/setup.sh -p . -s \"<Tên_Skill>\" -r \"<Tên_Rule>\""
                    echo -e "--------------------------------------------------------------------------------${NC}"
                    ((STAT_CONFLICT++))
                    CONFLICTED_FILES+=("AGENTS.md")
                fi
            fi
        fi
    fi
fi

# Đảm bảo thư mục lưu bài học .agents/learnings tồn tại
if [ ${#SELECTED_SKILLS[@]} -gt 0 ] || [ ${#SELECTED_RULES[@]} -gt 0 ]; then
    mkdir -p "${TARGET_AGENTS}/learnings"
    if [ ! -f "${TARGET_AGENTS}/learnings/.gitkeep" ]; then
        touch "${TARGET_AGENTS}/learnings/.gitkeep"
    fi
fi

# Sao chép các Skills đã chọn
for skill in "${SELECTED_SKILLS[@]}"; do
    src_skill_dir="${SOURCE_AGENTS}/skills/${skill}"
    if [ -d "$src_skill_dir" ]; then
        while IFS= read -r file; do
            rel_path="${file#"${SOURCE_AGENTS}/"}"
            dest_file="${TARGET_AGENTS}/${rel_path}"
            dest_dir="$(dirname "$dest_file")"
            mkdir -p "$dest_dir"

            display_path=".agents/${rel_path}"

            if [ ! -f "$dest_file" ]; then
                cp "$file" "$dest_file"
                echo -e "${GREEN}  [TẠO MỚI] ${display_path}${NC}"
                ((STAT_CREATED++))
            else
                src_hash=$(calc_hash "$file")
                dst_hash=$(calc_hash "$dest_file")
                if [ "$src_hash" = "$dst_hash" ]; then
                    echo -e "${GRAY}  [BỎ QUA - GIỐNG HỆT] ${display_path}${NC}"
                    ((STAT_IDENTICAL++))
                else
                    if [ "$OVERWRITE" = true ]; then
                        cp "$file" "$dest_file"
                        echo -e "${MAGENTA}  [GHI ĐÈ THEO YÊU CẦU] ${display_path}${NC}"
                        ((STAT_OVERWRITTEN++))
                    else
                        echo -e "${YELLOW}  [CẢNH BÁO - KHÁC NỘI DUNG] ${display_path}${NC}"
                        echo -e "${YELLOW}     -> File đã tồn tại nhưng nội dung khác với bộ cài! (Đã giữ nguyên file của dự án)${NC}"
                        ((STAT_CONFLICT++))
                        CONFLICTED_FILES+=("${display_path}")
                    fi
                fi
            fi
        done < <(find "$src_skill_dir" -type f)
    fi
done

# Sao chép các Rules đã chọn
for rule in "${SELECTED_RULES[@]}"; do
    src_rule_file="${SOURCE_AGENTS}/rules/${rule}.md"
    if [ -f "$src_rule_file" ]; then
        dest_rule_file="${TARGET_AGENTS}/rules/${rule}.md"
        mkdir -p "${TARGET_AGENTS}/rules"
        display_path=".agents/rules/${rule}.md"

        if [ ! -f "$dest_rule_file" ]; then
            cp "$src_rule_file" "$dest_rule_file"
            echo -e "${GREEN}  [TẠO MỚI] ${display_path}${NC}"
            ((STAT_CREATED++))
        else
            src_hash=$(calc_hash "$src_rule_file")
            dst_hash=$(calc_hash "$dest_rule_file")
            if [ "$src_hash" = "$dst_hash" ]; then
                echo -e "${GRAY}  [BỎ QUA - GIỐNG HỆT] ${display_path}${NC}"
                ((STAT_IDENTICAL++))
            else
                if [ "$OVERWRITE" = true ]; then
                    cp "$src_rule_file" "$dest_rule_file"
                    echo -e "${MAGENTA}  [GHI ĐÈ THEO YÊU CẦU] ${display_path}${NC}"
                    ((STAT_OVERWRITTEN++))
                else
                    echo -e "${YELLOW}  [CẢNH BÁO - KHÁC NỘI DUNG] ${display_path}${NC}"
                    echo -e "${YELLOW}     -> File đã tồn tại nhưng nội dung khác với bộ cài! (Đã giữ nguyên file của dự án)${NC}"
                    ((STAT_CONFLICT++))
                    CONFLICTED_FILES+=("${display_path}")
                fi
            fi
        fi
    fi
done

# Kiểm tra công cụ môi trường
if [ ${#SELECTED_SKILLS[@]} -gt 0 ]; then
    echo -e "\n${CYAN}--- Kiểm tra công cụ môi trường cho Skills đã cài ---${NC}"

    check_command() {
        local name="$1"
        local cmd="$2"
        local reason="$3"
        if command -v "$cmd" &> /dev/null; then
            echo -e "${GREEN}  [OK] ${name} đã sẵn sàng.${NC}"
            return 0
        else
            echo -e "${YELLOW}  [THIẾU] ${name}: ${reason}${NC}"
            return 1
        fi
    }

    need_git=false
    need_node=false
    need_npm=false

    for s in "${SELECTED_SKILLS[@]}"; do
        if [ "$s" = "find-bugs" ] || [ "$s" = "code-reviewer" ]; then need_git=true; fi
        if [ "$s" = "frontend-design" ] || [ "$s" = "webapp-testing" ]; then need_node=true; fi
        if [ "$s" = "webapp-testing" ]; then need_npm=true; fi
    done

    missing=0
    if [ "$need_git" = true ]; then
        check_command "Git" "git" "Cần cho skill 'find-bugs' (git diff) và 'code-reviewer'" || ((missing++))
    fi
    if [ "$need_node" = true ]; then
        check_command "Node.js" "node" "Cần cho 'webapp-testing' và 'frontend-design'" || ((missing++))
    fi
    if [ "$need_npm" = true ]; then
        check_command "npm / npx" "npm" "Cần để chạy Playwright / Vitest trong 'webapp-testing'" || ((missing++))
    fi

    if [ $missing -gt 0 ]; then
        echo -e "\n${YELLOW}[LƯU Ý]: Phát hiện thiếu một số công cụ. Vui lòng xem hướng dẫn chi tiết trong file README.md.${NC}"
    elif [ "$need_git" = true ] || [ "$need_node" = true ] || [ "$need_npm" = true ]; then
        echo -e "${GREEN}  Tất cả công cụ cần thiết cho các skills đã chọn đều sẵn sàng!${NC}"
    fi
fi

# Báo cáo tổng kết
echo -e "\n${CYAN}=======================================================${NC}"
echo -e "${CYAN}                 KẾT QUẢ THIẾT LẬP                     ${NC}"
echo -e "${CYAN}=======================================================${NC}"
echo -e "${GREEN}  - File tạo mới       : ${STAT_CREATED}${NC}"
echo -e "${GRAY}  - File bỏ qua (trùng): ${STAT_IDENTICAL}${NC}"
if [ $STAT_CONFLICT -gt 0 ]; then
    echo -e "${YELLOW}  - File giữ nguyên do xung đột nội dung: ${STAT_CONFLICT}${NC}"
    for cf in "${CONFLICTED_FILES[@]}"; do
        echo -e "${YELLOW}      * ${cf}${NC}"
    done
    echo -e "${GRAY}  (Gợi ý: Thêm cờ -o / --overwrite nếu bạn muốn ghi đè các file trên theo chuẩn bộ cài)\n${NC}"
fi
if [ $STAT_OVERWRITTEN -gt 0 ]; then
    echo -e "${MAGENTA}  - File đã ghi đè     : ${STAT_OVERWRITTEN}${NC}"
fi

echo -e "\n${GREEN}Cài đặt hoàn tất cho dự án tại: ${TARGET_DIR}\n${NC}"
