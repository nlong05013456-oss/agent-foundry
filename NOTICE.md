# Notice & Attribution

Agent Foundry includes both original work and components adapted from open-source community contributions.

---

## Upstream Attribution

A subset of rules and skills in this repository was inspired by and adapted from configurations shared in the public repository:
- **Upstream Repository**: [`quang26071999/demo_landing_page`](https://github.com/quang26071999/demo_landing_page)
- **License Status**: Upstream repository does not contain an explicit license file at the time of adaptation. All adapted assets have been restructured, standardized into the modern Antigravity `.agents/` layout, refactored with UTF-8 BOM encoding and cross-platform compatibility, and provided back to the developer community under open terms.

### Adapted Components:
1. **Rules** (`.agents/rules/`):
   - `web-design-backbone.md`: Quy chuẩn thiết kế web chuẩn mực và triết lý giao diện cao cấp.
   - `load-learnings.md`: Cơ chế nạp bài học dự án tự động đầu mỗi phiên làm việc.
2. **Skills** (`.agents/skills/`):
   - `brainstorming`: Quy trình thảo luận ý tưởng, thiết kế giải pháp kỹ thuật trước khi code.
   - `code-reviewer`: Đánh giá chất lượng mã nguồn, kiểm tra kiến trúc và tiêu chuẩn code.
   - `find-bugs`: Dò tìm lỗ hổng bảo mật, lỗi tiềm ẩn và code smell trong branch.
3. **Workflows Converted to Skills** (`.agents/skills/`):
   - `plan`: Quy trình thực thi task lập trình toàn diện (trước đây là `.agent/workflows/plan.md`).
   - `ai-learning`: Trích xuất bài học kỹ thuật vào `.agents/learnings/` (trước đây là `.agent/workflows/ai-learning.md`).
   - `human-learning`: Tạo tài liệu giải thích kiến trúc 'coffee talk' cho developer (trước đây là `.agent/workflows/human-learning.md`).

---

## Original Components in Agent Foundry

The following components were created specifically for Agent Foundry by nlong05013456-oss:
- **Skills**:
  - `frontend-design`: Quy trình xây dựng UI/UX hiện đại, responsive và animation mượt mà.
  - `webapp-testing`: Tự động hóa kiểm thử E2E với Playwright/Cypress và kiểm tra chất lượng web.
  - `organize-project`: Chuẩn hóa, dọn dẹp và phân loại cấu trúc thư mục dự án sạch sẽ.
- **Core Tooling & Infrastructure**:
  - `setup.ps1` & `setup.sh`: Script cài đặt mô-đun hóa, hỗ trợ preset và chọn lọc skill/rule không ghi đè code dự án.
  - `CATALOG.md`: Bảng tra cứu intent thông minh với các câu nói tiếng Việt tự nhiên.
  - `templates/AGENTS.md`: Mẫu chỉ dẫn thông minh cho Antigravity AI agent.
  - `examples/learnings/`: Thư mục chứa tài liệu học mẫu tham khảo mà không làm bẩn dự án người dùng.
