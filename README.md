# Agent Foundry 🚀

Kho cấu hình chuẩn hóa dùng chung cho **Google Antigravity / AI Agent**, hỗ trợ cài đặt **từng phần theo tiến độ dự án (Modular Configuration Setup)**. Dự án mới bắt đầu chỉ cần cấu hình nền (`AGENTS.md`), khi phát sinh công việc làm web, kiểm thử, review hoặc dọn dẹp thư mục mới cài thêm đúng mục cần dùng.

- **Repository**: [https://github.com/nlong05013456-oss/agent-foundry](https://github.com/nlong05013456-oss/agent-foundry) (Public)
- **Danh mục đầy đủ Skills & Rules**: Xem tại file [CATALOG.md](CATALOG.md).

---

## ⚡ Bắt Đầu Nhanh (Quick Start)

### 1. Tải kho cấu hình về máy (chỉ làm 1 lần)

```powershell
git clone https://github.com/nlong05013456-oss/agent-foundry.git D:\Tools\agent-foundry
cd D:\Tools\agent-foundry
```

> 💡 *Lưu ý: `D:\Tools\agent-foundry` là đường dẫn ví dụ. Bạn có thể clone và đặt thư mục kho ở bất kỳ ổ đĩa hay thư mục nào tiện lợi trên máy của mình.*

### 2. Khởi tạo cấu hình nền tảng cho dự án mới (`base`)

```powershell
.\setup.ps1 -ProjectPath "D:\Projects\MyApp" -Preset base
```
*Lệnh này chỉ tạo file `AGENTS.md` ở gốc dự án đích chứa 4 luật nền cốt lõi, giữ dự án hoàn toàn sạch sẽ.*

### 3. Cài thêm cấu hình khi bắt đầu làm việc (Ví dụ: Làm Web)

```powershell
.\setup.ps1 -ProjectPath "D:\Projects\MyApp" -Skills "frontend-design" -Rules "web-design-backbone"
```

---

## 🔄 Cách Cập Nhật Kho Cấu Hình (`git pull`)

Khi Agent Foundry có thêm các skills hoặc rules mới trên GitHub, cập nhật bản cục bộ dễ dàng bằng lệnh:

```powershell
cd D:\Tools\agent-foundry
git pull origin main
```

Sau khi cập nhật, chạy lại `setup.ps1` trỏ vào dự án của bạn (thêm cờ `-Overwrite` nếu muốn cập nhật các file đã sửa đổi).

---

## 📂 Cây Thư Mục Ngắn Gọn (Directory Tree)

```text
agent-foundry/
├── setup.ps1                 # Script cài đặt thông minh (-Preset base/web/all, -Skills, -Rules)
├── CATALOG.md                # Bảng tra cứu "Việc cần làm → mục cần cài" kèm câu nói mẫu
├── README.md                 # Hướng dẫn sử dụng & quy trình làm việc
├── LICENSE                   # Giấy phép MIT & thông tin nguồn gốc
├── templates/
│   └── AGENTS.md             # Mẫu chỉ dẫn dự án nền tảng (chứa 4 luật nền)
├── examples/
│   └── learnings/
│       └── landing-page.md   # Ghi chú mẫu tham khảo cấu trúc (không chép vào dự án)
└── .agents/
    ├── rules/                # Quy tắc tự động (web-design-backbone, load-learnings)
    └── skills/               # Bộ 9 kỹ năng chuyên biệt (frontend-design, webapp-testing...)
```

---

## 💻 Yêu Cầu Môi Trường PowerShell Đã Kiểm Thử

- **Hệ điều hành**: Windows 10 / 11.
- **Phiên bản PowerShell**: Đã kiểm thử hoạt động ổn định trên cả **Windows PowerShell 5.1** và **PowerShell 7+ (Core)**.
- **Bảng mã**: Toàn bộ script `setup.ps1` được lưu chuẩn **UTF-8 with BOM**, ngăn ngừa hoàn toàn lỗi parse ký tự tiếng Việt.
- **Chính sách thực thi (Execution Policy)**: Nếu PowerShell báo lỗi chặn script khi chạy lần đầu, hãy mở PowerShell và chạy:
  ```powershell
  Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
  ```

---

## 🧠 Giải Thích: Workflow Gọi Dưới Dạng Skill

Trong chuẩn Antigravity hiện đại:
- Các quy trình làm việc nhiều bước (workflows) như **`plan`** (Lập kế hoạch 3 pha), **`ai-learning`** (Tự động trích xuất tri thức) và **`human-learning`** (Báo cáo coffee talk) được đóng gói và gọi trực tiếp dưới dạng **Skill** (`.agents/skills/<name>/SKILL.md`).
- Lợi ích: AI Agent tự động phát hiện, hiểu ngữ cảnh và kích hoạt linh hoạt thông qua chat tự nhiên mà không cần khai báo workflow phức tạp.

---

## 📝 Tách Biệt Ghi Chú Mẫu Khỏi Bộ Cài

- File ghi chú học hỏi mẫu [`landing-page.md`](examples/learnings/landing-page.md) được lưu tại thư mục `examples/learnings/` chỉ để tham khảo định dạng.
- Khi chạy cài đặt (`setup.ps1`), các preset sẽ **không sao chép** ghi chú mẫu này sang dự án đích.
- Thư mục `.agents/learnings/` trong dự án đích sẽ được tạo sẵn sạch sẽ để lưu trữ tri thức, lỗi và conventions của **chính dự án đó**.

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
| **Lên kế hoạch task lớn** | *"lên kế hoạch làm tính năng..."*, *"/plan"* | Skill `plan` + Skill `brainstorming` |
| **Lưu kinh nghiệm task** | *"lưu lại kinh nghiệm từ task này"* | Skill `ai-learning` + `human-learning` + Rule `load-learnings` |
| **⚡ Cài trọn bộ Web** | *"cài toàn bộ cấu hình web"*, *"setup full web"* | Preset `web` (9 skills + 2 rules) |

> 💡 **Lưu ý**: Với việc nhỏ như *"sửa chữ trên nút Đăng nhập"*, Anti sẽ trực tiếp sửa file mã nguồn ngay mà không cài thêm skill thừa.

---

## 📜 Nguồn Gốc & Giấy Phép (Attribution & Licensing)

- **Giấy phép chính**: Xem chi tiết tại [LICENSE](LICENSE). Các script (`setup.ps1`), tài liệu (`CATALOG.md`, `README.md`, `templates/AGENTS.md`) và các skills xây dựng mới (`frontend-design`, `webapp-testing`, `organize-project`) được phát hành theo giấy phép **MIT License**.
- **Nguồn gốc thành phần cộng đồng**:
  - Các quy tắc `web-design-backbone.md`, `load-learnings.md` và các skills `brainstorming`, `code-reviewer`, `find-bugs`, `plan`, `ai-learning`, `human-learning` được chuyển thể từ cấu hình cộng đồng tại: [quang26071999/demo_landing_page](https://github.com/quang26071999/demo_landing_page).
  - *Lưu ý*: Do upstream repository không đính kèm file LICENSE chính thức, các tệp trên được sử dụng và chia sẻ lại trên tinh thần cộng đồng nhà phát triển mã nguồn mở (Open Community Sharing) phi thương mại.
