# Antigravity Starter Kit 🚀

Kho cấu hình chuẩn hóa dùng chung cho **Google Antigravity / AI Agent**, giúp tích hợp nhanh Bộ Quy tắc (Rules), Kỹ năng (Skills) và Cơ chế Học hỏi (Learnings) vào bất kỳ dự án phần mềm nào.

Repository: **[https://github.com/nlong05013456-oss/antigravity-starter](https://github.com/nlong05013456-oss/antigravity-starter)** (Private)

---

## 📌 Tính năng cốt lõi

- **Kho cấu hình dùng chung (Multi-Project Configuration Hub)**: Một bộ cài duy nhất, phân phối linh hoạt cho mọi dự án Web, Mobile, Backend.
- **Hỗ trợ 2 chế độ cài đặt linh hoạt**:
  1. **Chế độ Preset (`-Preset web`)**: Cài đặt trọn gói được cấu hình sẵn cho các dự án Web Frontend / Fullstack.
  2. **Chế độ Chọn từng mục (`-Skills`, `-Rules`)**: Tự do lựa chọn chính xác những skill và rule bạn cần.
- **Bảo toàn thư mục Skill (Full Directory Preservation)**: Khi cài một skill, sao chép toàn bộ thư mục bao gồm cả file phụ (`resources/`, `scripts/`, `references/`...).
- **Cài đặt vào `.agents/` tại gốc dự án đích**: Giữ nguyên 100% mã nguồn hiện có của dự án.
- **Cơ chế so khớp thông minh (Smart SHA256 Sync)**:
  - Bỏ qua các file giống hệt nhau về nội dung để tiết kiệm thời gian.
  - Cảnh báo rõ ràng các file trùng tên nhưng khác nội dung và giữ nguyên cấu hình tùy biến của dự án (trừ khi bật `-Overwrite`).

---

## 🛠️ Hướng dẫn cài đặt & Lệnh mẫu đã chạy thành công

### Chuẩn bị: Tải bộ cài về máy (chỉ làm 1 lần)

```powershell
git clone https://github.com/nlong05013456-oss/antigravity-starter.git D:\Tools\antigravity-starter
cd D:\Tools\antigravity-starter
```

---

### Lệnh mẫu 1: Cài đặt theo Preset Web (Khuyến nghị cho Web Project)

Cài đặt đầy đủ 8 skills, 2 rules và learnings mẫu cho dự án Web:

```powershell
.\setup.ps1 -ProjectPath "D:\Projects\MyApp" -Preset web
```

**Kết quả thực tế khi chạy:**
```text
=======================================================
   ANTIGRAVITY STARTER - BỘ CÀI ĐẶT CẤU HÌNH DỰ ÁN     
=======================================================
Chế độ cài đặt        : Preset: 'web' (Mặc định cho phát triển Web Frontend / Fullstack)
Skills đã chọn (8)     : ai-learning, brainstorming, code-reviewer, find-bugs, frontend-design, human-learning, plan, webapp-testing
Rules đã chọn (2)      : load-learnings, web-design-backbone

  [TẠO MỚI] .agents/skills/ai-learning/SKILL.md
  [TẠO MỚI] .agents/skills/brainstorming/SKILL.md
  [TẠO MỚI] .agents/skills/code-reviewer/SKILL.md
  [TẠO MỚI] .agents/skills/code-reviewer/resources/implementation-playbook.md
  [TẠO MỚI] .agents/skills/find-bugs/SKILL.md
  [TẠO MỚI] .agents/skills/frontend-design/SKILL.md
  [TẠO MỚI] .agents/skills/human-learning/SKILL.md
  [TẠO MỚI] .agents/skills/plan/SKILL.md
  [TẠO MỚI] .agents/skills/webapp-testing/SKILL.md
  [TẠO MỚI] .agents/rules/load-learnings.md
  [TẠO MỚI] .agents/rules/web-design-backbone.md
  [TẠO MỚI] .agents/learnings/landing-page.md
```

---

### Lệnh mẫu 2: Cài đặt chọn lọc từng Skill & Rule (Custom Selection)

Chỉ cài đặt những skill hoặc rule cụ thể bạn muốn cho một dự án chuyên biệt:

```powershell
.\setup.ps1 -ProjectPath "D:\Projects\MyApp" -Skills "frontend-design","code-reviewer" -Rules "web-design-backbone"
```

*Lưu ý: Thư mục `code-reviewer` sẽ mang theo toàn bộ thư mục phụ `resources/implementation-playbook.md` vào dự án đích.*

---

### Lệnh mẫu 3: Cập nhật / Ghi đè cấu hình khi cần

Nếu dự án đích đã có file và bạn muốn đồng bộ lại theo nội dung mới nhất của bộ cài:

```powershell
.\setup.ps1 -ProjectPath "D:\Projects\MyApp" -Preset web -Overwrite
```

---

## 📋 Bảng tra cứu Skills (Kỹ năng)

| Tên Skill | Dùng khi nào | Ví dụ cách gọi (Prompt / Lệnh) | Nguồn (Source) | Công cụ cần thêm nếu có |
|---|---|---|---|---|
| **`plan`** | Bắt đầu task lập trình quan trọng; cần quy trình 3 pha chuẩn mực: Brainstorming → Execution → Save Learnings | *"Lên kế hoạch và thực thi task tạo tính năng giỏ hàng"*, *"/plan"* | Workflow chuyển đổi (`antigravity-starter`) | Tuỳ stack dự án: Node.js / Python / Go test runner |
| **`brainstorming`** | Trước khi viết code; cần phân tích ý tưởng, làm rõ yêu cầu, khóa hiểu biết (Understanding Lock) | *"Brainstorm ý tưởng làm trang checkout"*, *"Phân tích các phương án kiến trúc cho auth"* | Community (`demo_landing_page`) | Không cần thêm |
| **`frontend-design`** | Thiết kế UI/UX mới hoặc refactor giao diện; yêu cầu chuẩn thẩm mỹ cao cấp (Apple/Stripe/Linear), Design Tokens, responsive, micro-interactions | *"Thiết kế giao diện dashboard cho mobile và desktop"*, *"Tối ưu animations và styling cho component hero"* | Tích hợp mới (`antigravity-starter`) | **Node.js** (để preview/dev server) |
| **`webapp-testing`** | Viết kịch bản kiểm thử E2E, Unit, Component testing; kiểm tra edge cases, API error boundaries, form validation | *"Viết test Playwright cho luồng đăng ký người dùng"*, *"Viết component test cho Modal xác nhận"* | Tích hợp mới (`antigravity-starter`) | **Node.js**, **npm/npx**, `@playwright/test`, `vitest` |
| **`find-bugs`** | Quét git diff trên nhánh local trước khi commit/PR; tìm lỗi logic và bảo mật (OWASP, SQLi, XSS, CSRF, IDOR) | *"Quét bug và lỗ hổng bảo mật trên diff nhánh này"*, *"Kiểm tra thay đổi code vừa làm"* | Community (`demo_landing_page`) | **Git** (`git diff`) |
| **`code-reviewer`** | Đánh giá chất lượng code, cấu trúc, hiệu năng, nợ kỹ thuật và clean code | *"Review file AuthService.ts giúp mình"*, *"Đánh giá chất lượng pull request"* | Community (`demo_landing_page`) | **Git**, linter tương ứng của dự án (ESLint/Prettier) |
| **`ai-learning`** | Khi kết thúc task; tự động trích xuất kiến thức (Architecture, Bugs & Solutions, How-To, Patterns) vào `.agents/learnings/` | *"Lưu learnings từ task này vào dự án"*, *"Tổng hợp kinh nghiệm vừa fix bug vào learnings"* | Workflow chuyển đổi (`antigravity-starter`) | Không cần thêm |
| **`human-learning`** | Sau khi giải quyết vấn đề phức tạp; muốn có tài liệu giải thích sâu dạng "coffee talk" về lý do lựa chọn và bài học | *"Viết tài liệu coffee talk giải thích kiến trúc vừa làm"*, *"Tổng kết bài học từ task này cho developer"* | Workflow chuyển đổi (`antigravity-starter`) | Không cần thêm |

---

## 📜 Bảng tra cứu Rules (Quy tắc tự động)

| Tên Rule | Dùng khi nào | Ví dụ cách gọi (Kích hoạt) | Nguồn (Source) | Công cụ cần thêm nếu có |
|---|---|---|---|---|
| **`load-learnings.md`** | Tự động kích hoạt ở đầu mỗi phiên chat; quét các file `.agents/learnings/`, chỉ load kiến thức liên quan đến task để tiết kiệm quota | Tự động kích hoạt (`trigger: always_on`), không cần gọi thủ công | Chuyển đổi chuẩn hóa (`antigravity-starter`) | Không cần thêm |
| **`web-design-backbone.md`** | Bắt buộc tuân thủ khi viết/sửa code HTML, CSS, React, Vue, Svelte, Astro... Đảm bảo UI không bị đơn điệu | Tự động kích hoạt khi chỉnh sửa web files (`globs: **/*.{html,css,js,jsx,tsx...}`) | Community (`demo_landing_page`) | Không cần thêm |

---

## 🧰 Bảng hướng dẫn cài đặt công cụ bổ trợ

| Công cụ | Cần cho Skill nào? | Cách kiểm tra | Lệnh cài đặt nhanh trên Windows (Winget) |
|---|---|---|---|
| **Git** | `find-bugs`, `code-reviewer` | `git --version` | `winget install --id Git.Git -e --source winget` |
| **Node.js (LTS)** | `frontend-design`, `webapp-testing` | `node -v` | `winget install OpenJS.NodeJS.LTS` |
| **npm / npx** | `webapp-testing` | `npm -v` | Đi kèm sẵn khi cài Node.js |
| **Playwright** | `webapp-testing` (E2E testing) | `npx playwright --version` | Chạy trong dự án: `npm install -D @playwright/test && npx playwright install` |
| **Vitest** | `webapp-testing` (Unit/Component test) | `npx vitest --version` | Chạy trong dự án: `npm install -D vitest` |

---

## 📂 Cấu trúc thư mục sau khi cài đặt vào dự án đích

```text
<Thư_Mục_Dự_Án_Đích>/
├── .agents/
│   ├── rules/
│   │   ├── load-learnings.md
│   │   └── web-design-backbone.md
│   ├── skills/
│   │   ├── ai-learning/
│   │   │   └── SKILL.md
│   │   ├── brainstorming/
│   │   │   └── SKILL.md
│   │   ├── code-reviewer/
│   │   │   ├── SKILL.md
│   │   │   └── resources/
│   │   │       └── implementation-playbook.md
│   │   ├── find-bugs/
│   │   │   └── SKILL.md
│   │   ├── frontend-design/
│   │   │   └── SKILL.md
│   │   ├── human-learning/
│   │   │   └── SKILL.md
│   │   ├── plan/
│   │   │   └── SKILL.md
│   │   └── webapp-testing/
│   │       └── SKILL.md
│   └── learnings/
│       └── landing-page.md
├── <Toàn bộ mã nguồn dự án của bạn - không bị ảnh hưởng>
```

---

## 🔒 Bản quyền & Quản lý
- **Repository**: [https://github.com/nlong05013456-oss/antigravity-starter](https://github.com/nlong05013456-oss/antigravity-starter)
- Được phát triển và tối ưu cho môi trường **Google Antigravity**.
