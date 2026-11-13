# Danh Mục Cấu Hình Antigravity (CATALOG.md) 📚

Kho cấu hình chuẩn hóa dùng chung cho **Google Antigravity / AI Agent**. 

> 🎯 **Cài đặt theo nhu cầu thực tế**: Dự án mới bắt đầu chỉ cần cấu hình nền (`-Preset base`). Trong quá trình phát triển, khi người dùng mô tả công việc bằng tiếng Việt, Anti sẽ tự động đối chiếu với bảng dưới đây để xác định và cài thêm đúng mục cần dùng.

---

## 🎯 Bảng Tra Cứu: “Việc Cần Làm → Mục Cần Cài”

| Việc cần làm (Mục đích công việc) | Câu nói mẫu (Cách nói tự nhiên thường gặp) | Mục cần cài (Tên thật trong repo) | Lệnh cài chọn lọc mẫu | Đường dẫn nguồn | Công cụ cần thêm |
|---|---|---|---|---|---|
| **1. Khởi tạo cấu hình nền tảng cho dự án mới** | • *"Khởi tạo cấu hình agent cho dự án mới"*<br>• *"Tạo file AGENTS.md cơ bản"*<br>• *"Cài đặt base ban đầu"* | Mẫu `AGENTS.md` (chứa 4 luật nền) | `.\setup.ps1 -ProjectPath "." -Preset base` | `templates/AGENTS.md` | Không cần thêm |
| **2. Làm giao diện Web / Frontend / UI-UX** | • *"làm web đẹp kiểu ảnh này"*<br>• *"làm giao diện giống ảnh này"*<br>• *"thiết kế lại UI trang chủ cho hiện đại"*<br>• *"tối ưu giao diện mobile"* | Skill `frontend-design`<br>+ Rule `web-design-backbone` | `.\setup.ps1 -ProjectPath "." -Skills "frontend-design" -Rules "web-design-backbone"` | `.agents/skills/frontend-design/`<br>`.agents/rules/web-design-backbone.md` | **Node.js** (dev server / preview) |
| **3. Kiểm thử trình duyệt & Web Application** | • *"mở web thử nút đăng nhập"*<br>• *"viết test Playwright cho luồng checkout"*<br>• *"kiểm thử tự động giao diện này"*<br>• *"test form đăng ký"* | Skill `webapp-testing` | `.\setup.ps1 -ProjectPath "." -Skills "webapp-testing"` | `.agents/skills/webapp-testing/` | **Node.js**, **npm/npx**, `@playwright/test`, `vitest` |
| **4. Dọn dẹp & sắp xếp cấu trúc thư mục** | • *"dọn thư mục cho gọn"*<br>• *"sắp xếp lại thư mục cho gọn"*<br>• *"tổ chức lại cây thư mục src"*<br>• *"dọn dẹp các file rác và file thừa"* | Skill `organize-project` | `.\setup.ps1 -ProjectPath "." -Skills "organize-project"` | `.agents/skills/organize-project/` | Không cần thêm |
| **5. Tìm bug, rà soát bảo mật & kiểm tra git diff** | • *"rà phần code vừa sửa"*<br>• *"quét bug và bảo mật trên diff này"*<br>• *"kiểm tra nhánh hiện tại có lỗi bảo mật gì không"* | Skill `find-bugs` | `.\setup.ps1 -ProjectPath "." -Skills "find-bugs"` | `.agents/skills/find-bugs/` | **Git** (`git diff`) |
| **6. Rà soát mã nguồn & đánh giá chất lượng** | • *"review file này giúp mình"*<br>• *"đánh giá chất lượng đoạn code vừa viết"*<br>• *"rà soát nợ kỹ thuật và clean code cho PR này"* | Skill `code-reviewer`<br>(kèm playbook) | `.\setup.ps1 -ProjectPath "." -Skills "code-reviewer"` | `.agents/skills/code-reviewer/` | **Git**, Linter dự án |
| **7. Lập kế hoạch & phân tích ý tưởng trước khi code** | • *"lên kế hoạch làm tính năng giỏ hàng"*<br>• *"brainstorm cách triển khai tính năng X"*<br>• *"phân tích yêu cầu và thiết kế giải pháp"* | Skill `plan`<br>+ Skill `brainstorming` | `.\setup.ps1 -ProjectPath "." -Skills "plan","brainstorming"` | `.agents/skills/plan/`<br>`.agents/skills/brainstorming/` | Không cần thêm |
| **8. Tích lũy tri thức & lưu kinh nghiệm dự án** | • *"lưu lại kinh nghiệm từ task này"*<br>• *"ghi lại kiến trúc và lỗi vừa fix vào learnings"*<br>• *"viết tài liệu coffee talk cho developer"* | Skill `ai-learning`<br>+ Skill `human-learning`<br>+ Rule `load-learnings` | `.\setup.ps1 -ProjectPath "." -Skills "ai-learning","human-learning" -Rules "load-learnings"` | `.agents/skills/ai-learning/`<br>`.agents/skills/human-learning/`<br>`.agents/rules/load-learnings.md` | Không cần thêm |
| **⚡ Cài đặt trọn bộ cho dự án Web** | • *"cài toàn bộ cấu hình web"*<br>• *"setup full bộ web development"* | Preset `web` (9 skills + 2 rules + learnings) | `.\setup.ps1 -ProjectPath "." -Preset web` | `.agents/` | Git, Node.js |

> 💡 **Quy tắc xử lý đặc biệt dành cho Agent**:
> 1. **Kết hợp nhiều việc (Multi-intent)**: Khi người dùng nói câu chứa nhiều việc (ví dụ: *“làm lại giao diện rồi test nút đăng nhập”*), lấy tất cả các mục tương ứng (`frontend-design`, `web-design-backbone` và `webapp-testing`).
> 2. **Việc nhỏ, đơn giản (Trivial task)**: Khi người dùng chỉ yêu cầu sửa việc nhỏ (ví dụ: *“sửa chữ trên nút Đăng nhập”*, sửa chính tả, đổi 1 tên biến), hãy **xử lý trực tiếp** mà không cài thêm skill/rule.

---

## 📖 Chi Tiết Danh Mục Kỹ Năng (Skills)

| Tên Skill | Dùng khi nào | Khả năng bổ sung | Đường dẫn trong kho | Công cụ cần thêm |
|---|---|---|---|---|
| **`organize-project`** | Thư mục dự án lộn xộn, nhiều file tự do ở gốc; cần tái cấu trúc sạch sẽ trước khi release | Rà soát cây thư mục, dọn dẹp file rác/file tạm, chuẩn hóa naming convention, đảm bảo an toàn import | `.agents/skills/organize-project/` | Không cần thêm |
| **`frontend-design`** | Thiết kế UI/UX mới, landing page, dashboard; tối ưu responsive, styling chuẩn Design Tokens | Tạo giao diện cao cấp (Apple/Stripe/Linear), hệ màu CSS variables, typography chuẩn, micro-animations | `.agents/skills/frontend-design/` | Node.js |
| **`webapp-testing`** | Viết kịch bản kiểm thử E2E (Playwright), Unit/Component tests (Vitest), kiểm tra edge cases | Tháp kiểm thử tự động hóa, kiểm tra network throttling, form validation, error boundary, visual regression | `.agents/skills/webapp-testing/` | Node.js, npm/npx, `@playwright/test`, `vitest` |
| **`find-bugs`** | Quét git diff trên nhánh local trước khi tạo PR hoặc commit | Rà soát lỗi logic biên, 10 lỗ hổng bảo mật hàng đầu (OWASP, SQLi, XSS, CSRF, IDOR, race conditions) | `.agents/skills/find-bugs/` | Git (`git diff`) |
| **`code-reviewer`** | Đánh giá chất lượng mã nguồn, clean code, hiệu năng và kiến trúc | Phân tích code bằng AI, tích hợp static analysis, kèm playbook hướng dẫn thực hành chi tiết | `.agents/skills/code-reviewer/` | Git, Linter dự án |
| **`plan`** | Bắt đầu task lập trình quan trọng cần kiểm soát rủi ro | Quy trình 3 pha: Brainstorming (làm rõ) → Execution (thực thi checklist) → Save Learnings (lưu tri thức) | `.agents/skills/plan/` | Test runner dự án |
| **`brainstorming`** | Trước khi viết code; chuyển đổi ý tưởng thô thành đặc tả rõ ràng | Hỏi từng câu một, khóa hiểu biết (Understanding Lock), phân tích phương án và lập nhật ký quyết định | `.agents/skills/brainstorming/` | Không cần thêm |
| **`ai-learning`** | Khi kết thúc task; muốn lưu trữ bài học tự động | Trích xuất kiến thức (Architecture, Bugs & Solutions, How-To, Patterns) vào `.agents/learnings/` | `.agents/skills/ai-learning/` | Không cần thêm |
| **`human-learning`** | Sau khi giải quyết bài toán khó; muốn tài liệu chia sẻ kinh nghiệm | Viết tài liệu giải thích sâu dạng "coffee talk" chia sẻ tư duy, con đường đã loại bỏ và bài học cho dev | `.agents/skills/human-learning/` | Không cần thêm |

*Lưu ý: Khi cài đặt bất kỳ skill nào, script sẽ tự động sao chép **toàn bộ thư mục** của skill đó (kèm tất cả tài liệu, scripts, resources phụ).*

---

## 📜 Chi Tiết Danh Mục Quy Tắc (Rules)

| Tên Rule | Dùng khi nào | Khả năng kiểm soát | Đường dẫn trong kho |
|---|---|---|---|
| **`load-learnings.md`** | Tự động kích hoạt đầu mỗi phiên trò chuyện (`trigger: always_on`) | Tự động quét `.agents/learnings/`, chỉ đọc các file liên quan trực tiếp đến task để tiết kiệm quota | `.agents/rules/load-learnings.md` |
| **`web-design-backbone.md`** | Bắt buộc tuân thủ 100% khi tạo hoặc sửa file web (`globs: **/*`) | Nghiêm cấm giao diện thô/flat; bắt buộc Google Font, hệ 4px/8px, không cuộn ngang trên mobile, WCAG AA | `.agents/rules/web-design-backbone.md` |

---

## 📦 Danh Mục Gói Định Sẵn (Presets)

| Tên Preset | Thành phần bao gồm | Mục đích sử dụng | Lệnh cài đặt mẫu |
|---|---|---|---|
| **`base`** | Chỉ cài file mẫu `AGENTS.md` (chứa 4 luật nền) tại gốc dự án đích. | Dành cho dự án mới bắt đầu; giữ dự án gọn nhẹ và có sẵn chỉ dẫn để AI tự lấy thêm kỹ năng khi cần. | `.\setup.ps1 -ProjectPath "." -Preset base` |
| **`web`** | Trọn bộ 9 skills, 2 rules và learnings mẫu. | Dành cho các dự án Web Frontend / Fullstack muốn có sẵn toàn bộ công cụ. | `.\setup.ps1 -ProjectPath "." -Preset web` |
| **`all`** | Toàn bộ kho cấu hình (bao gồm `AGENTS.md`, 9 skills, 2 rules, learnings). | Cài đặt toàn diện không thiếu bất kỳ mục nào. | `.\setup.ps1 -ProjectPath "." -Preset all` |
