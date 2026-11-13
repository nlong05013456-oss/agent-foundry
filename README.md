# Antigravity Starter Kit 🚀

Kho cấu hình chuẩn hóa dùng chung cho **Google Antigravity / AI Agent**, hỗ trợ cài đặt **từng phần theo tiến độ dự án (Modular Configuration Setup)**. Dự án mới chỉ cần cấu hình nền, khi đến giai đoạn làm web, kiểm thử, review hoặc dọn dẹp thư mục mới cài đúng mục cần dùng.

- **Repository**: [https://github.com/nlong05013456-oss/antigravity-starter](https://github.com/nlong05013456-oss/antigravity-starter) (Private)
- **Danh mục chi tiết toàn bộ Skills & Rules**: Xem tại file [CATALOG.md](CATALOG.md) với bảng tra cứu **“Việc cần làm → mục cần cài”**.

---

## 📌 Triết lý thiết kế & Tính năng nổi bật

- **Cài đặt từng phần (Modular & Incremental)**: Không nhồi nhét tất cả cấu hình ngay từ đầu. Dự án bắt đầu gọn nhẹ với file nền tảng `AGENTS.md` (chứa 4 luật nền), sau đó mở rộng dần theo từng chặng phát triển.
- **Tự động hóa thông minh cho Anti**: File `AGENTS.md` ở gốc dự án hướng dẫn AI Agent (Anti) tự tra cứu `CATALOG.md` (từ clone cục bộ hoặc GitHub API với quyền hiện tại) để lấy thêm đúng skill/rule khi người dùng yêu cầu.
- **Bảo toàn trọn vẹn thư mục Skill**: Sao chép nguyên vẹn cả thư mục của skill, giữ lại tất cả file phụ trong `resources/`, `scripts/`, `references/`.
- **An toàn tuyệt đối cho dự án**:
  - Mã nguồn hiện có được giữ nguyên 100%.
  - Bỏ qua các file giống hệt nhau (SHA256).
  - Cảnh báo rõ ràng và **giữ nguyên cấu hình tùy biến riêng** của dự án nếu phát hiện file trùng tên nhưng khác nội dung (chỉ ghi đè khi có cờ `-Overwrite`).

---

## 🛠️ Hướng dẫn cài đặt theo từng chặng dự án (Đã kiểm thử thành công)

Tải kho cấu hình về máy của bạn (chỉ cần thực hiện 1 lần):

```powershell
git clone https://github.com/nlong05013456-oss/antigravity-starter.git D:\Tools\antigravity-starter
cd D:\Tools\antigravity-starter
```

### 1️⃣ Chặng 1: Khởi tạo cấu hình nền tảng (`base`)
Khi vừa khởi tạo một dự án mới, bạn chỉ cần chạy preset `base`. Script sẽ đưa mẫu `AGENTS.md` vào gốc dự án. Mẫu chứa sẵn **Bốn luật nền** cùng các mục để bạn điền mục tiêu, quy ước mã nguồn và lệnh kiểm tra:

```powershell
.\setup.ps1 -ProjectPath "D:\Projects\MyApp" -Preset base
```

*Lưu ý: Nếu dự án đã có file `AGENTS.md` tùy biến trước đó, script sẽ tự động giữ nguyên file của bạn và in ra phần hướng dẫn cần bổ sung vào console.*

---

### 2️⃣ Chặng 2: Khi bắt đầu thiết kế Web (`frontend-design`)
Khi bước vào giai đoạn thiết kế giao diện, cài đặt skill thiết kế UI/UX cùng rule quy chuẩn web:

```powershell
.\setup.ps1 -ProjectPath "D:\Projects\MyApp" -Skills "frontend-design" -Rules "web-design-backbone"
```

*Tác động: Toàn bộ thư mục `frontend-design` và rule `web-design-backbone.md` được thêm vào `.agents/`, các file khác trong dự án không bị ảnh hưởng.*

---

### 3️⃣ Chặng 3: Khi viết kịch bản kiểm thử (`webapp-testing`)
Khi hoàn thành giao diện và cần viết tests E2E (Playwright) hoặc Unit/Component tests (Vitest):

```powershell
.\setup.ps1 -ProjectPath "D:\Projects\MyApp" -Skills "webapp-testing"
```

*Tác động: Bổ sung riêng skill `webapp-testing` vào `.agents/skills/`. Script tự kiểm tra sự sẵn sàng của Node.js & npm/npx trên máy.*

---

### 4️⃣ Chặng 4: Khi rà soát mã nguồn & bảo mật (`review & find-bugs`)
Trước khi tạo Pull Request hoặc phát hành, cài đặt bộ đôi reviewer và quét bug bảo mật:

```powershell
.\setup.ps1 -ProjectPath "D:\Projects\MyApp" -Skills "code-reviewer","find-bugs"
```

*Tác động: Sao chép cả `code-reviewer` (kèm file phụ `resources/implementation-playbook.md`) và `find-bugs`.*

---

### 5️⃣ Chặng 5: Khi dọn dẹp & sắp xếp cấu trúc thư mục (`organize-project`)
Khi dự án phình to, xuất hiện nhiều file tự do hoặc cần tái cấu trúc sạch sẽ:

```powershell
.\setup.ps1 -ProjectPath "D:\Projects\MyApp" -Skills "organize-project"
```

*Tác động: Bổ sung skill `organize-project` để AI hỗ trợ rà soát, dọn file rác, chuẩn hóa quy chuẩn đặt tên và kiểm tra tính toàn vẹn của import.*

---

### ⚡ Cài đặt trọn bộ khi cần (`-Preset web`)
Nếu bạn muốn trang bị đầy đủ toàn bộ kỹ năng và quy tắc web ngay từ đầu:

```powershell
.\setup.ps1 -ProjectPath "D:\Projects\MyApp" -Preset web
```

*(Thêm cờ `-Overwrite` nếu bạn muốn ép buộc cập nhật lại các file cấu hình theo chuẩn mới nhất của bộ cài).*

---

## 📋 Bảng tra cứu nhanh Skills & Rules

> 📖 **Xem chi tiết đầy đủ tại: [CATALOG.md](CATALOG.md)**

### Bảng Skills
| Tên Skill | Dùng khi nào | Ví dụ cách gọi (Prompt / Lệnh) | Nguồn (Source) | Công cụ cần thêm nếu có |
|---|---|---|---|---|
| **`organize-project`** | Thư mục dự án lộn xộn, cần tái cấu trúc, dọn file rác, chuẩn hóa naming | *"Tổ chức lại cấu trúc thư mục dự án"*, *"Dọn dẹp file thừa trong src"* | Tích hợp mới (`antigravity-starter`) | Không cần thêm |
| **`plan`** | Bắt đầu task lớn; quy trình 3 pha: Brainstorming → Execution → Save Learnings | *"Lên kế hoạch và thực thi task giỏ hàng"*, *"/plan"* | Workflow chuẩn hóa (`antigravity-starter`) | Test runner dự án |
| **`brainstorming`** | Trước khi code; làm rõ ý tưởng, hỏi từng câu một, khóa hiểu biết (Understanding Lock) | *"Brainstorm ý tưởng làm trang thanh toán"* | Community (`demo_landing_page`) | Không cần thêm |
| **`frontend-design`** | Thiết kế UI/UX mới, chuẩn Design Tokens, responsive, animations mượt mà | *"Thiết kế dashboard mobile và desktop"* | Tích hợp mới (`antigravity-starter`) | **Node.js** |
| **`webapp-testing`** | Viết test E2E Playwright, Vitest, Component testing; kiểm tra edge cases | *"Viết test Playwright cho luồng login"* | Tích hợp mới (`antigravity-starter`) | **Node.js**, **npm/npx**, `@playwright/test`, `vitest` |
| **`find-bugs`** | Quét git diff trên nhánh local tìm bug logic và bảo mật (OWASP, SQLi, XSS, CSRF) | *"Quét bug và bảo mật trên diff nhánh này"* | Community (`demo_landing_page`) | **Git** (`git diff`) |
| **`code-reviewer`** | Đánh giá chất lượng code, cấu trúc, hiệu năng, nợ kỹ thuật kèm playbook | *"Review file AuthService.ts giúp mình"* | Community (`demo_landing_page`) | **Git**, Linter |
| **`ai-learning`** | Khi kết thúc task; tự động trích xuất kiến thức vào `.agents/learnings/` | *"Lưu learnings từ task này vào dự án"* | Workflow chuẩn hóa (`antigravity-starter`) | Không cần thêm |
| **`human-learning`** | Giải thích sâu task phức tạp dạng "coffee talk" cho developer | *"Viết tài liệu coffee talk cho task vừa rồi"* | Workflow chuẩn hóa (`antigravity-starter`) | Không cần thêm |

### Bảng Rules
| Tên Rule | Dùng khi nào | Ví dụ cách gọi (Kích hoạt) | Nguồn (Source) | Công cụ cần thêm nếu có |
|---|---|---|---|---|
| **`load-learnings.md`** | Tự động kích hoạt đầu mỗi phiên chat; chỉ nạp các learnings liên quan | Tự động kích hoạt (`trigger: always_on`) | Chuẩn hóa (`antigravity-starter`) | Không cần thêm |
| **`web-design-backbone.md`** | Bắt buộc tuân thủ khi viết/sửa file web (HTML, CSS, JSX, TSX, Vue...) | Tự động kích hoạt khi sửa web files (`globs: **/*`) | Community (`demo_landing_page`) | Không cần thêm |

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

## 📂 Cấu trúc kho lưu trữ (Repository Structure)

```text
antigravity-starter/
├── CATALOG.md             # Danh mục tra cứu toàn bộ Skills, Rules và bảng “Việc cần làm → mục cần cài”
├── README.md              # Hướng dẫn sử dụng & quy trình cài đặt từng phần
├── setup.ps1              # Script cài đặt thông minh (-Preset base/web/all, -Skills, -Rules)
├── templates/
│   └── AGENTS.md          # Mẫu tài liệu thiết lập dự án (chứa 4 luật nền) và hướng dẫn cho Anti
└── .agents/
    ├── rules/
    │   ├── load-learnings.md
    │   └── web-design-backbone.md
    ├── skills/
    │   ├── ai-learning/
    │   ├── brainstorming/
    │   ├── code-reviewer/
    │   │   ├── SKILL.md
    │   │   └── resources/implementation-playbook.md
    │   ├── find-bugs/
    │   ├── frontend-design/
    │   ├── human-learning/
    │   ├── organize-project/
    │   │   └── SKILL.md
    │   ├── plan/
    │   └── webapp-testing/
    └── learnings/
        └── landing-page.md
```

---

## 🔒 Bản quyền & Quản lý
- **Repository**: [https://github.com/nlong05013456-oss/antigravity-starter](https://github.com/nlong05013456-oss/antigravity-starter)
- Được phát triển và tối ưu cho môi trường **Google Antigravity**.
