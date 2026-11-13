# Danh Mục Cấu Hình Antigravity (CATALOG.md) 📚

Tài liệu tra cứu tập trung toàn bộ Kỹ năng (Skills), Quy tắc (Rules) và Mẫu cấu hình (Templates) trong kho **Antigravity Starter Kit**.

Kho cấu hình này được thiết kế để cài đặt **từng phần theo nhu cầu thực tế của dự án**:
1. Khởi tạo nền tảng với **`-Preset base`** (chỉ cài `AGENTS.md`).
2. Bổ sung kỹ năng thiết kế Web khi cần làm giao diện.
3. Bổ sung kỹ năng kiểm thử khi chuẩn bị viết tests.
4. Bổ sung kỹ năng rà soát mã nguồn & bảo mật trước khi bàn giao / pull request.

---

## 1. Mẫu Cấu Hình Cơ Bản (Templates)

| Tên Mẫu | Dùng khi nào | Đường dẫn trong kho | Lệnh cài đặt mẫu |
|---|---|---|---|
| **`AGENTS.md`** | Khởi tạo cấu hình ban đầu cho dự án mới; định nghĩa mục tiêu, quy ước mã nguồn, lệnh kiểm tra và hướng dẫn Anti lấy thêm cấu hình khi cần. | `templates/AGENTS.md` | `.\setup.ps1 -ProjectPath "." -Preset base` |

---

## 2. Danh Mục Kỹ Năng (Skills)

| Tên Skill | Dùng khi nào | Đường dẫn trong kho | Công cụ cần thêm | Lệnh cài đặt chọn lọc mẫu |
|---|---|---|---|---|
| **`plan`** | Bắt đầu task lập trình quan trọng; quy trình 3 pha chuẩn mực: Brainstorming → Execution → Save Learnings. | `.agents/skills/plan/` | Test runner theo công nghệ dự án | `.\setup.ps1 -ProjectPath "." -Skills "plan"` |
| **`brainstorming`** | Trước khi viết code; làm rõ ý tưởng, hỏi từng câu một, khóa hiểu biết (Understanding Lock) tránh phỏng đoán sai lệch. | `.agents/skills/brainstorming/` | Không cần thêm | `.\setup.ps1 -ProjectPath "." -Skills "brainstorming"` |
| **`frontend-design`** | Thiết kế UI/UX mới, tối ưu responsive, xây dựng Design Tokens, hiệu ứng chuyển động mượt mà theo chuẩn cao cấp. | `.agents/skills/frontend-design/` | **Node.js** | `.\setup.ps1 -ProjectPath "." -Skills "frontend-design" -Rules "web-design-backbone"` |
| **`webapp-testing`** | Viết kịch bản kiểm thử E2E (Playwright), Unit/Component testing (Vitest), kiểm tra edge cases, API mock và validation. | `.agents/skills/webapp-testing/` | **Node.js**, **npm/npx**, `@playwright/test`, `vitest` | `.\setup.ps1 -ProjectPath "." -Skills "webapp-testing"` |
| **`find-bugs`** | Quét git diff trên nhánh local trước khi commit/PR; tìm lỗi logic, lỗ hổng bảo mật (OWASP, SQLi, XSS, CSRF, IDOR). | `.agents/skills/find-bugs/` | **Git** (`git diff`) | `.\setup.ps1 -ProjectPath "." -Skills "find-bugs"` |
| **`code-reviewer`** | Đánh giá chất lượng mã nguồn, hiệu năng, nợ kỹ thuật và clean code kèm playbook hướng dẫn thực tế. | `.agents/skills/code-reviewer/` | **Git**, Linter dự án | `.\setup.ps1 -ProjectPath "." -Skills "code-reviewer"` |
| **`ai-learning`** | Sau khi kết thúc task; tự động tổng hợp kiến thức (Architecture, Bugs & Solutions, How-To, Patterns) vào `.agents/learnings/`. | `.agents/skills/ai-learning/` | Không cần thêm | `.\setup.ps1 -ProjectPath "." -Skills "ai-learning" -Rules "load-learnings"` |
| **`human-learning`** | Sau khi hoàn thành task phức tạp; viết tài liệu giải thích sâu dạng 'coffee talk' về lý do lựa chọn và bài học kinh nghiệm. | `.agents/skills/human-learning/` | Không cần thêm | `.\setup.ps1 -ProjectPath "." -Skills "human-learning"` |

*Ghi chú: Khi cài đặt bất kỳ skill nào, script sẽ tự động sao chép **toàn bộ thư mục** của skill đó (kèm tất cả tài liệu, scripts, resources phụ).*

---

## 3. Danh Mục Quy Tắc Tự Động (Rules)

| Tên Rule | Dùng khi nào | Đường dẫn trong kho | Công cụ cần thêm | Lệnh cài đặt chọn lọc mẫu |
|---|---|---|---|---|
| **`load-learnings.md`** | Tự động kích hoạt ở đầu mỗi phiên trò chuyện (`trigger: always_on`); chỉ đọc các file trong `.agents/learnings/` liên quan trực tiếp đến task để tiết kiệm quota. | `.agents/rules/load-learnings.md` | Không cần thêm | `.\setup.ps1 -ProjectPath "." -Rules "load-learnings"` |
| **`web-design-backbone.md`** | Bắt buộc tuân thủ 100% khi tạo hoặc sửa file web (`globs: **/*.{html,css,js,jsx,tsx...}`). Đảm bảo chuẩn màu sắc, font, spacing, responsive không cuộn ngang. | `.agents/rules/web-design-backbone.md` | Không cần thêm | `.\setup.ps1 -ProjectPath "." -Rules "web-design-backbone"` |

---

## 4. Các Gói Định Sẵn (Presets)

| Tên Preset | Thành phần bao gồm | Mục đích sử dụng | Lệnh cài đặt mẫu |
|---|---|---|---|
| **`base`** | Chỉ cài file mẫu `AGENTS.md` tại gốc dự án đích. | Dành cho dự án mới bắt đầu; thiết lập ngữ cảnh và lệnh kiểm tra trước khi cài thêm skills. | `.\setup.ps1 -ProjectPath "." -Preset base` |
| **`web`** | Trọn bộ 8 skills, 2 rules và learnings mẫu. | Dành cho các dự án Web Frontend / Fullstack muốn có sẵn toàn bộ công cụ. | `.\setup.ps1 -ProjectPath "." -Preset web` |
| **`all`** | Toàn bộ kho cấu hình (bao gồm `AGENTS.md`, 8 skills, 2 rules, learnings). | Cài đặt toàn diện không thiếu mục nào. | `.\setup.ps1 -ProjectPath "." -Preset all` |
