# Agent Foundry 🚀

Kho cấu hình chuẩn hóa dùng chung cho **Google Antigravity / AI Agent**, hỗ trợ cài đặt **từng phần theo tiến độ dự án (Modular Configuration Setup)**. Dự án mới bắt đầu chỉ cần cấu hình nền (`AGENTS.md`), khi phát sinh công việc làm web, kiểm thử, review hoặc dọn dẹp thư mục mới cài thêm đúng mục cần dùng.

- **Repository**: [https://github.com/nlong05013456-oss/agent-foundry](https://github.com/nlong05013456-oss/agent-foundry) (Public)
- **Danh mục đầy đủ Skills & Rules**: Xem tại file [CATALOG.md](CATALOG.md).
- **Thông báo nguồn gốc & bản quyền**: Xem tại [NOTICE.md](NOTICE.md) và [LICENSE](LICENSE).

---

## ⚡ Bắt Đầu Nhanh (Quick Start)

### 1. Tải kho cấu hình về máy (chỉ làm 1 lần)

```bash
# Clone về máy (ví dụ tại D:\Tools\agent-foundry trên Windows hoặc ~/tools/agent-foundry trên Linux/macOS):
git clone https://github.com/nlong05013456-oss/agent-foundry.git D:\Tools\agent-foundry
cd D:\Tools\agent-foundry
```

> 💡 *Lưu ý: `D:\Tools\agent-foundry` là đường dẫn ví dụ. Bạn có thể clone và đặt thư mục kho ở bất kỳ ổ đĩa hay thư mục nào thuận tiện trên máy tính của mình.*

### 2. Khởi tạo cấu hình nền tảng cho dự án mới (`base`)

Chỉ cài duy nhất một file `AGENTS.md` tại gốc dự án đích chứa 4 luật nền cốt lõi, giữ cho dự án hoàn toàn sạch sẽ (không tạo thư mục `.agents/` dư thừa):

```powershell
# Windows (PowerShell):
.\setup.ps1 -ProjectPath "D:\Projects\MyApp" -Preset base

# Linux / macOS (Bash):
./setup.sh -p /path/to/MyApp -P base
```

### 3. Cài thêm cấu hình khi phát sinh công việc (Ví dụ: Làm Web)

Khi bắt đầu làm giao diện, kiểm thử hoặc review, chỉ cần cài đúng các mục cần dùng:

```powershell
# Windows (PowerShell):
.\setup.ps1 -ProjectPath "D:\Projects\MyApp" -Skills "frontend-design" -Rules "web-design-backbone"

# Linux / macOS (Bash):
./setup.sh -p /path/to/MyApp -s "frontend-design" -r "web-design-backbone"
```

---

## 🔄 Cách Cập Nhật Kho Cấu Hình (`git pull`)

Khi Agent Foundry có thêm các skills hoặc rules mới trên GitHub, bạn cập nhật bản cục bộ dễ dàng bằng lệnh:

```bash
cd D:\Tools\agent-foundry
git pull origin main
```

Sau khi cập nhật, chạy lại script setup trỏ vào dự án của bạn (thêm cờ `-Overwrite` trên PowerShell hoặc `-o` trên Bash nếu muốn cập nhật các file đã sửa đổi).

---

## 📂 Cây Thư Mục Dự Án (Directory Tree)

```text
agent-foundry/
├── setup.ps1                 # Script cài đặt thông minh cho Windows PowerShell
├── setup.sh                  # Script cài đặt tương thích Linux / macOS (Bash)
├── CATALOG.md                # Bảng tra cứu "Việc cần làm → mục cần cài" kèm câu nói mẫu
├── README.md                 # Hướng dẫn sử dụng & tài liệu tổng quan
├── LICENSE                   # Giấy phép MIT License chuẩn cho đóng góp của Agent Foundry
├── NOTICE.md                 # Ghi nhận chi tiết nguồn gốc upstream & các bên thứ ba
├── templates/
│   └── AGENTS.md             # Mẫu chỉ dẫn dự án nền tảng (chứa 4 luật nền cốt lõi)
├── examples/
│   └── learnings/
│       └── landing-page.md   # Ghi chú mẫu tham khảo cấu trúc (không chép vào dự án)
└── .agents/
    ├── rules/                # Bộ 2 quy tắc tự động (web-design-backbone, load-learnings)
    └── skills/               # Bộ 9 kỹ năng chuyên biệt (frontend-design, webapp-testing...)
```

---

## 🛠️ Danh Sách 9 Skills & 2 Rules Có Trong Kho

Agent Foundry cung cấp đầy đủ **9 kỹ năng (Skills)** và **2 quy tắc (Rules)** chuyên nghiệp:

### 🧩 9 Kỹ Năng (Skills) — `.agents/skills/`
1. **`frontend-design`**: Thiết kế UI/UX hiện đại, responsive, micro-interactions, áp dụng hệ Design Tokens (Apple/Stripe/Linear).
2. **`webapp-testing`**: Tự động hóa kiểm thử web: kịch bản E2E bằng Playwright TypeScript, Unit/Component test bằng Vitest.
3. **`organize-project`**: Rà soát, dọn dẹp và tổ chức lại cây thư mục dự án theo chuẩn kiến trúc sạch, an toàn.
4. **`find-bugs`**: Quét git diff trên nhánh local để tìm lỗi logic biên và 10 lỗ hổng bảo mật hàng đầu (OWASP, SQLi, XSS, IDOR...).
5. **`code-reviewer`**: Đánh giá chất lượng mã nguồn, clean code, hiệu năng và kiến trúc (kèm playbook thực hành chi tiết).
6. **`plan`**: Quy trình thực thi task lập trình 3 pha chuẩn mực: *Brainstorming → Execution → Save Learnings* (tự động tích hợp phụ thuộc `brainstorming` và `ai-learning`).
7. **`brainstorming`**: Khảo sát yêu cầu, hỏi làm rõ từng ý, phân tích phương án và chốt thiết kế trước khi bắt tay viết code.
8. **`ai-learning`**: Tự động trích xuất kiến thức, kiến trúc, lỗi đã fix và mẫu xử lý từ phiên làm việc vào `.agents/learnings/`.
9. **`human-learning`**: Viết báo cáo giải thích chuyên sâu phong cách "coffee talk" chia sẻ tư duy kỹ thuật cho developer.

### 📜 2 Quy Tắc (Rules) — `.agents/rules/`
1. **`load-learnings.md`** (`trigger: always_on`): Tự động nạp các bài học kinh nghiệm từ `.agents/learnings/` ở đầu mỗi session; chỉ đọc các file liên quan để tiết kiệm context/quota.
2. **`web-design-backbone.md`** (`globs: **/*`): Quy tắc cốt lõi bắt buộc khi tạo hoặc chỉnh sửa giao diện web (bắt buộc Google Fonts, hệ spacing 4px/8px, WCAG AA, responsive không cuộn ngang).

---

## 💻 Yêu Cầu Môi Trường Đã Kiểm Thử

- **Hệ điều hành**: Windows 10 / 11, macOS, hoặc Linux (Ubuntu, Debian, WSL2).
- **PowerShell (Windows)**:
  - Đã kiểm thử ổn định trên cả **Windows PowerShell 5.1** và **PowerShell 7+ (Core)**.
  - Toàn bộ script `setup.ps1` được lưu chuẩn **UTF-8 with BOM**, ngăn ngừa lỗi parse ký tự tiếng Việt.
  - Nếu gặp lỗi Execution Policy chặn script, chạy lệnh:
    ```powershell
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
    ```
- **Bash (Linux / macOS)**:
  - Tương thích chuẩn Bash 4+ / Zsh. Cấp quyền thực thi trước khi dùng:
    ```bash
    chmod +x setup.sh
    ```

---

## 🧰 Công Cụ Môi Trường & Phiên Bản Tối Thiểu

| Công cụ | Phiên bản tối thiểu | Lệnh kiểm tra | Dùng cho Skill | Cách cài đặt nhanh |
|---|---|---|---|---|
| **Git** | `>= 2.30` | `git --version` | `find-bugs`, `code-reviewer` | **Windows**: `winget install Git.Git`<br>**macOS**: `brew install git`<br>**Linux**: `sudo apt update && sudo apt install -y git` |
| **Node.js** | `>= 18.0.0 LTS` *(khuyến nghị 20+)* | `node -v` | `frontend-design`, `webapp-testing` | **Windows**: `winget install OpenJS.NodeJS.LTS`<br>**macOS**: `brew install node@20`<br>**Linux**: `curl -fsSL https://deb.nodesource.com/setup_20.x \| sudo -E bash - && sudo apt install -y nodejs` |
| **Playwright** | `>= 1.40` | `npx playwright --version` | `webapp-testing` | Cài vào dự án đích:<br>`npm install -D @playwright/test`<br>`npx playwright install --with-deps` |
| **Vitest** | `>= 1.0` | `npx vitest --version` | `webapp-testing` | Cài vào dự án đích:<br>`npm install -D vitest` |

---

## 🧠 Phụ Thuộc Tự Động Giữa Các Kỹ Năng (Dependency Resolution)

- Skill **`plan`** áp dụng quy trình 3 pha:
  - **Pha 1 (Brainstorm)**: Gọi trực tiếp skill `brainstorming`.
  - **Pha 2 (Execute)**: Thực thi checklist và xác thực chất lượng qua lệnh test.
  - **Pha 3 (Save Learnings)**: Gọi trực tiếp skill `ai-learning`.
- Cả `setup.ps1` và `setup.sh` đều tích hợp cơ chế **tự động phát hiện và bổ sung phụ thuộc (Auto-resolve dependencies)**: Khi bạn chỉ định cài đặt `plan`, script sẽ tự động cài thêm `brainstorming` và `ai-learning` nếu trong danh sách chưa có, kèm thông báo xác nhận rõ ràng.

---

## 📝 Quản Lý Bài Học Dự Án & Tệp `.gitkeep`

- File [`examples/learnings/landing-page.md`](examples/learnings/landing-page.md) là một ví dụ thực tế minh họa cách ghi chép kiến trúc, lỗi và giải pháp theo chuẩn 4 phần (Architecture, Bugs, How-to, Patterns).
- Khi chạy script cài đặt, các preset (`base`, `web`, `all`) sẽ **không sao chép** file ví dụ này sang dự án đích.
- **Hành vi tạo thư mục `.agents/learnings/`**:
  - Khi cài đặt các preset (`web`, `all`) hoặc khi cài đặt bất kỳ skill/rule nào, script sẽ tự động tạo thư mục rỗng `.agents/learnings/` kèm tệp `.gitkeep` để Git có thể theo dõi và lưu trữ thư mục rỗng này.
  - Khi chạy `-Preset base`, thư mục này **không** được tạo để đảm bảo dự án đích hoàn toàn tinh gọn.

---

## 🤖 Bảng Tra Cứu Ý Định Tiếng Việt (“Việc Cần Làm → Mục Cần Cài”)

| Việc cần làm | Câu nói mẫu tự nhiên | Mục cài đặt tương ứng |
|---|---|---|
| **Khởi tạo dự án mới** | *"Khởi tạo cấu hình agent"*, *"Tạo AGENTS.md cơ bản"* | Preset `base` (`templates/AGENTS.md`) |
| **Làm giao diện Web** | *"làm web đẹp kiểu ảnh này"*, *"làm giao diện giống ảnh này"* | Skill `frontend-design` + Rule `web-design-backbone` |
| **Kiểm thử Web** | *"mở web thử nút đăng nhập"*, *"viết test Playwright"* | Skill `webapp-testing` |
| **Dọn dẹp thư mục** | *"dọn thư mục cho gọn"*, *"sắp xếp lại thư mục"* | Skill `organize-project` |
| **Rà diff & bảo mật** | *"rà phần code vừa sửa"*, *"quét bug trên diff này"* | Skill `find-bugs` |
| **Review chất lượng code** | *"review file này"*, *"đánh giá chất lượng PR"* | Skill `code-reviewer` |
| **Lên kế hoạch task lớn** | *"lên kế hoạch làm tính năng..."*, *"/plan"* | Skill `plan` *(tự động kèm `brainstorming` & `ai-learning`)* |
| **Lưu kinh nghiệm task** | *"lưu lại kinh nghiệm từ task này"* | Skill `ai-learning` + `human-learning` + Rule `load-learnings` |
| **⚡ Cài trọn bộ Web** | *"cài toàn bộ cấu hình web"*, *"setup full web"* | Preset `web` (9 skills + 2 rules) |

> 💡 **Quy tắc xử lý đặc biệt**:
> - **Nhiều việc một lúc (Multi-intent)**: Ví dụ *"làm lại giao diện rồi test nút đăng nhập"*, Agent tự động chọn cả `frontend-design`, `web-design-backbone` và `webapp-testing`.
> - **Cú pháp truyền nhiều mục**:
>   - **PowerShell**: `.\setup.ps1 -ProjectPath "." -Skills "frontend-design","webapp-testing"`
>   - **Bash**: `./setup.sh -p . -s "frontend-design,webapp-testing"` (hoặc `-s "frontend-design webapp-testing"`)
> - **Việc nhỏ (Trivial task)**: Với yêu cầu nhỏ như *"sửa chữ trên nút Đăng nhập"*, Agent sẽ sửa code trực tiếp mà không cần cài thêm cấu hình.

---

## 📜 Nguồn Gốc & Giấy Phép (Attribution & Licensing)

- **Phần sáng tạo của Agent Foundry**: Được phát hành theo giấy phép [MIT License](LICENSE).
- **Phần chuyển thể từ cộng đồng & bên thứ ba**: Xem chi tiết tại [NOTICE.md](NOTICE.md).
  - Giấy phép MIT của Agent Foundry không áp đặt lên các thành phần của bên thứ ba.
  - `brainstorming` bắt nguồn từ `obra/superpowers` (MIT License bởi Jesse Vincent).
  - `find-bugs` bắt nguồn từ `getsentry/skills` (Apache License 2.0 bởi Functional Software, Inc. d/b/a Sentry).
  - `code-reviewer` bắt nguồn từ `benjaminasterA/antigravity-awesome-skills` (MIT License).
  - `frontend-design` & `webapp-testing` lấy cảm hứng thiết kế từ `anthropics/skills` (Apache License 2.0 bởi Anthropic, PBC).
  - Các tệp kế thừa từ `quang26071999/demo_landing_page` (hiện không kèm file giấy phép chính thức) được ghi nhận minh bạch và liệt kê đầy đủ trong [NOTICE.md](NOTICE.md).
