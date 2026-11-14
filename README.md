# Agent Foundry

Bộ cài cấu hình tinh gọn cho **Google Antigravity / AI Agent**, giúp chép nhanh các rules và skills cần thiết vào dự án.

## ⚡ Cài đặt nhanh

```powershell
# Windows (PowerShell) - Cài trọn bộ hoặc chọn lọc:
.\setup.ps1 -ProjectPath "D:\Projects\MyApp" -Preset web
.\setup.ps1 -ProjectPath "D:\Projects\MyApp" -Skills "frontend-design" -Rules "web-design-backbone"
```

```bash
# Linux / macOS (Bash) - Cài trọn bộ hoặc chọn lọc:
./setup.sh -p /path/to/project -P web
./setup.sh -p /path/to/project -s "frontend-design" -r "web-design-backbone"
```

> Thêm cờ `-Overwrite` (PowerShell) hoặc `-o` (Bash) nếu muốn ghi đè các file đã có.

## 📦 Danh mục Skills & Rules

| Tên mục | Loại | Mô tả & Cách gọi tự nhiên |
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

> 💡 **Lưu ý phụ thuộc**: Skill `plan` cần `brainstorming` và `ai-learning`; khuyến nghị dùng preset `web` để cài đủ bộ.

## 🛠️ Yêu cầu & Bản quyền

- **Yêu cầu môi trường**: Git (cho `find-bugs`, `code-reviewer`) và Node.js (cho web dev/testing).
- **Bản quyền**: Giấy phép chính [MIT License](LICENSE). Thông tin nguồn gốc chi tiết xem tại [NOTICE.md](NOTICE.md).
