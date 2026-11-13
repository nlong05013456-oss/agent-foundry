# Antigravity Starter Kit 🚀

Kho cấu hình chuẩn hóa dùng chung cho **Google Antigravity / AI Agent**, hỗ trợ cài đặt **từng phần theo tiến độ dự án (Modular Configuration Setup)**. Dự án mới chỉ cần cấu hình nền, khi đến giai đoạn làm web, kiểm thử, review hoặc dọn dẹp thư mục mới cài đúng mục cần dùng.

- **Repository**: [https://github.com/nlong05013456-oss/antigravity-starter](https://github.com/nlong05013456-oss/antigravity-starter) (Private)
- **Danh mục chi tiết toàn bộ Skills & Rules**: Xem tại file [CATALOG.md](CATALOG.md) với bảng tra cứu **“Việc cần làm → mục cần cài”** kèm **“Câu nói mẫu”**.

---

## 📌 Triết lý thiết kế & Tính năng nổi bật

- **Cài đặt từng phần (Modular & Incremental)**: Không nhồi nhét tất cả cấu hình ngay từ đầu. Dự án bắt đầu gọn nhẹ với file nền tảng `AGENTS.md` (chứa 4 luật nền), sau đó mở rộng dần theo từng chặng phát triển.
- **Tự động nhận diện ý định tiếng Việt**: Người dùng chỉ cần nói tự nhiên bằng tiếng Việt (ví dụ: *“làm web đẹp kiểu ảnh này”*, *“dọn thư mục cho gọn”*), Anti sẽ tự tra cứu `CATALOG.md` để cài đúng kỹ năng còn thiếu.
- **Bảo toàn trọn vẹn thư mục Skill**: Sao chép nguyên vẹn cả thư mục của skill, giữ lại tất cả file phụ trong `resources/`, `scripts/`, `references/`.
- **An toàn tuyệt đối cho dự án**:
  - Mã nguồn hiện có được giữ nguyên 100%.
  - Bỏ qua các file giống hệt nhau (SHA256).
  - Cảnh báo rõ ràng và **giữ nguyên cấu hình tùy biến riêng** của dự án nếu phát hiện file trùng tên nhưng khác nội dung (chỉ ghi đè khi có cờ `-Overwrite`).

---

## 🤖 Nhận Diện Ý Định Tự Động Từ Tiếng Việt (Đã kiểm thử thực tế)

Khi dự án đã được khởi tạo với `-Preset base`, bạn chỉ cần ra lệnh bằng tiếng Việt trong khung chat của Anti:

| Câu nói tự nhiên của bạn | Anti tự động phân tích & xử lý | Cấu hình được cài vào `.agents/` |
|---|---|---|
| **“làm giao diện giống ảnh này”** *(hoặc “làm web đẹp kiểu ảnh này”)* | Khớp mục **Làm giao diện Web** trong `CATALOG.md` → tự chạy setup lấy skill thiết kế và rule web. | • `skills/frontend-design/`<br>• `rules/web-design-backbone.md` |
| **“sắp xếp lại thư mục cho gọn”** *(hoặc “dọn thư mục cho gọn”)* | Khớp mục **Dọn dẹp thư mục** → tự lấy skill tổ chức lại cây thư mục chuẩn mực. | • `skills/organize-project/` |
| **“mở web thử nút đăng nhập”** *(hoặc “viết test tự động luồng checkout”)* | Khớp mục **Kiểm thử Web** → tự lấy skill kiểm thử E2E Playwright và Vitest. | • `skills/webapp-testing/` |
| **“rà phần code vừa sửa”** *(hoặc “quét bug trên diff này”)* | Khớp mục **Rà soát diff & bảo mật** → tự lấy skill kiểm tra bug và OWASP. | • `skills/find-bugs/` |
| **“làm lại giao diện rồi test nút đăng nhập”** | **Đa mục đích (Multi-intent)** → tự động lấy đủ cả hai nhóm công cụ. | • `frontend-design` + `web-design-backbone`<br>• `webapp-testing` |
| **“sửa chữ trên nút Đăng nhập”** *(ví dụ: sửa text, fix typo, đổi 1 tên biến)* | **Việc nhỏ (Trivial task)** → Anti trực tiếp sửa code ngay, **KHÔNG** cài thêm skill rác. | *Không cài thêm file nào* (xử lý trực tiếp file code) |

---

## 🛠️ Hướng dẫn cài đặt thủ công theo từng chặng (Nếu muốn chủ động chạy lệnh)

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

---

### 3️⃣ Chặng 3: Khi viết kịch bản kiểm thử (`webapp-testing`)
Khi hoàn thành giao diện và cần viết tests E2E (Playwright) hoặc Unit/Component tests (Vitest):

```powershell
.\setup.ps1 -ProjectPath "D:\Projects\MyApp" -Skills "webapp-testing"
```

---

### 4️⃣ Chặng 4: Khi rà soát mã nguồn & bảo mật (`review & find-bugs`)
Trước khi tạo Pull Request hoặc phát hành, cài đặt bộ đôi reviewer và quét bug bảo mật:

```powershell
.\setup.ps1 -ProjectPath "D:\Projects\MyApp" -Skills "code-reviewer","find-bugs"
```

---

### 5️⃣ Chặng 5: Khi dọn dẹp & sắp xếp cấu trúc thư mục (`organize-project`)
Khi dự án phình to, xuất hiện nhiều file tự do hoặc cần tái cấu trúc sạch sẽ:

```powershell
.\setup.ps1 -ProjectPath "D:\Projects\MyApp" -Skills "organize-project"
```

---

### ⚡ Cài đặt trọn bộ khi cần (`-Preset web`)
Nếu bạn muốn trang bị đầy đủ toàn bộ 9 skills và 2 rules web ngay từ đầu:

```powershell
.\setup.ps1 -ProjectPath "D:\Projects\MyApp" -Preset web
```

*(Thêm cờ `-Overwrite` nếu bạn muốn ép buộc cập nhật lại các file cấu hình theo chuẩn mới nhất của bộ cài).*

---

## 📋 Bảng tra cứu nhanh Skills & Rules

> 📖 **Xem chi tiết đầy đủ tại: [CATALOG.md](CATALOG.md)**

### Bảng Skills
| Tên Skill | Dùng khi nào | Câu nói tự nhiên thường gặp | Nguồn (Source) | Công cụ cần thêm nếu có |
|---|---|---|---|---|
| **`organize-project`** | Cần tái cấu trúc thư mục, dọn file rác, chuẩn hóa naming | *"dọn thư mục cho gọn"*, *"sắp xếp lại thư mục"* | Tích hợp mới (`antigravity-starter`) | Không cần thêm |
| **`plan`** | Bắt đầu task lớn; quy trình 3 pha: Brainstorm → Execute → Learnings | *"lên kế hoạch làm tính năng..."*, *"/plan"* | Workflow chuẩn hóa (`antigravity-starter`) | Test runner dự án |
| **`brainstorming`** | Trước khi code; làm rõ ý tưởng, hỏi từng câu một, khóa hiểu biết | *"brainstorm cách làm..."*, *"phân tích yêu cầu"* | Community (`demo_landing_page`) | Không cần thêm |
| **`frontend-design`** | Thiết kế UI/UX mới, chuẩn Design Tokens, responsive, animations | *"làm web đẹp kiểu ảnh này"*, *"làm giao diện giống ảnh này"* | Tích hợp mới (`antigravity-starter`) | **Node.js** |
| **`webapp-testing`** | Viết test E2E Playwright, Vitest, Component testing; test edge cases | *"mở web thử nút đăng nhập"*, *"viết test Playwright"* | Tích hợp mới (`antigravity-starter`) | **Node.js**, **npm/npx**, `@playwright/test`, `vitest` |
| **`find-bugs`** | Quét git diff trên nhánh local tìm bug logic và bảo mật (OWASP, SQLi) | *"rà phần code vừa sửa"*, *"quét bug trên diff này"* | Community (`demo_landing_page`) | **Git** (`git diff`) |
| **`code-reviewer`** | Đánh giá chất lượng code, cấu trúc, hiệu năng, nợ kỹ thuật | *"review file này"*, *"đánh giá chất lượng code"* | Community (`demo_landing_page`) | **Git**, Linter |
| **`ai-learning`** | Khi kết thúc task; tự động trích xuất kiến thức vào learnings | *"lưu lại kinh nghiệm từ task này"* | Workflow chuẩn hóa (`antigravity-starter`) | Không cần thêm |
| **`human-learning`** | Giải thích sâu task phức tạp dạng "coffee talk" cho developer | *"viết tài liệu coffee talk cho task vừa rồi"* | Workflow chuẩn hóa (`antigravity-starter`) | Không cần thêm |

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

## 🔒 Bản quyền & Quản lý
- **Repository**: [https://github.com/nlong05013456-oss/antigravity-starter](https://github.com/nlong05013456-oss/antigravity-starter)
- Được phát triển và tối ưu cho môi trường **Google Antigravity**.
