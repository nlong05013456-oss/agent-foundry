# Agent Foundry

Bộ cài cấu hình tinh gọn cho **Google Antigravity / AI Agent**, giúp chép nhanh các rules và skills cần thiết vào dự án.

## ⚡ Cài đặt nhanh

```bash
# 1. Tải kho cấu hình về máy:
git clone https://github.com/nlong05013456-oss/agent-foundry
cd agent-foundry
```

```powershell
# 2. Windows (PowerShell) - Dùng ExecutionPolicy Bypass nếu hệ thống chặn script:
powershell -ExecutionPolicy Bypass -File .\setup.ps1 -ProjectPath "D:\Projects\MyApp" -Preset web
.\setup.ps1 -ProjectPath "D:\Projects\MyApp" -Skills "frontend-design" -Rules "web-design-backbone"
```

```bash
# 2. Linux / macOS / Git Bash:
bash setup.sh -p /path/to/project -P web
bash setup.sh -p /path/to/project -s "frontend-design" -r "web-design-backbone"
```

> File cấu hình được đưa vào `.agents/skills/` và `.agents/rules/` trong dự án đích (chuẩn Antigravity 2.0+). Thêm cờ `-Overwrite` (PowerShell) hoặc `-o` (Bash) nếu muốn ghi đè file đã có.

## 📦 Bảng tra cứu Skills & Rules

| Tên mục | Loại | Yêu cầu / Cách gọi tự nhiên |
|---|---|---|
| `frontend-design` | Skill | Thiết kế UI/UX hiện đại, responsive, Design Tokens (*"làm giao diện đẹp"*) |
| `webapp-testing` | Skill | Kịch bản kiểm thử E2E Playwright, Unit test Vitest (*"test nút đăng nhập"*) |
| `organize-project` | Skill | Dọn dẹp và tổ chức lại cây thư mục chuẩn (*"dọn thư mục cho gọn"*) |
| `find-bugs` | Skill | Quét git diff tìm lỗi logic và bảo mật OWASP (*"rà soát code vừa sửa"*) |
| `code-reviewer` | Skill | Đánh giá chất lượng code, clean code, performance (*"review file này"*) |
| `plan` | Skill | Quy trình lập trình 3 pha: Brainstorm → Execute → Learnings (*"lên kế hoạch"*) |
| `brainstorming` | Skill | Thảo luận và chốt thiết kế trước khi viết code (*"phân tích yêu cầu"*) |
| `ai-learning` | Skill | Trích xuất tri thức, lỗi đã fix vào `.agents/learnings/` (*"lưu bài học"*) |
| `human-learning` | Skill | Viết tài liệu giải thích kiến trúc dạng coffee talk cho dev |
| `web-design-backbone` | Rule | Quy chuẩn thiết kế web bắt buộc (Google Fonts, spacing 4px/8px, WCAG) |
| `load-learnings` | Rule | Tự động đọc các bài học liên quan trong `.agents/learnings/` đầu mỗi phiên |

> 💡 **Lưu ý phụ thuộc**: Skill `plan` cần `brainstorming` và `ai-learning`. Cài đủ bộ bằng lệnh:
> `.\setup.ps1 -ProjectPath "." -Skills "plan","brainstorming","ai-learning"` *(hoặc `bash setup.sh -p . -s "plan,brainstorming,ai-learning"`)*

> 💡 **Quy tắc cho Agent**: Khi người dùng yêu cầu nhiều việc (ví dụ: *"làm lại UI rồi test nút đăng nhập"*), hãy cài đủ các mục tương ứng; với việc nhỏ đơn giản (sửa typo, đổi chữ nút), hãy **xử lý trực tiếp** không cần cài thêm cấu hình.

## 🛠️ Yêu cầu & Bản quyền

- **Yêu cầu môi trường**: Git (cho `find-bugs`, `code-reviewer`), Node.js và Playwright / Vitest (cho `webapp-testing`, `frontend-design`).
- **Bản quyền**: Giấy phép chính [MIT License](LICENSE). Thông tin nguồn gốc chi tiết xem tại [NOTICE.md](NOTICE.md).
