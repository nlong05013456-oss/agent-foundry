# Antigravity Starter Kit 🚀

Bộ cài đặt cấu hình chuẩn hóa dành cho **Google Antigravity / AI Agent**, giúp biến bất kỳ thư mục dự án nào thành môi trường làm việc thông minh với đầy đủ Bộ Quy tắc (Rules), Kỹ năng (Skills) và Cơ chế Tích lũy Tri thức (Learnings).

---

## 📌 Tính năng nổi bật

- **Chuẩn hóa `.agents/`**: Đưa rules, skills và learnings vào đúng vị trí quy chuẩn của Antigravity.
- **An toàn tuyệt đối với mã nguồn**: Giữ nguyên code hiện có của dự án đích.
- **Cơ chế so khớp thông minh (Smart Sync)**:
  - Bỏ qua các file cấu hình giống hệt nội dung để tiết kiệm thời gian.
  - Cảnh báo rõ ràng các file trùng tên nhưng khác nội dung để bảo vệ cấu hình tùy biến riêng của dự án.
- **Tích lũy tri thức liên tục**: Tự động ghi nhớ kiến trúc, lỗi đã giải quyết và conventions để không bao giờ lặp lại sai lầm.

---

## 🛠️ Hướng dẫn cài đặt nhanh

### Cách 1: Tải về và cài đặt cho dự án bất kỳ

Mở **PowerShell** trên Windows và thực hiện:

```powershell
# 1. Clone repository bộ cài về máy (nếu chưa có)
git clone https://github.com/nlong05013456-oss/antigravity-starter.git D:\Tools\antigravity-starter

# 2. Chuyển vào thư mục bộ cài
cd D:\Tools\antigravity-starter

# 3. Chạy setup trỏ tới dự án của bạn
.\setup.ps1 -ProjectPath "D:\Path\To\YourProject"
```

### Cách 2: Tùy chọn ghi đè nếu có xung đột nội dung

Mặc định `setup.ps1` sẽ **giữ nguyên** file của bạn nếu phát hiện file cùng tên nhưng khác nội dung. Nếu bạn muốn ép buộc cập nhật theo bộ cài chuẩn:

```powershell
.\setup.ps1 -ProjectPath "D:\Path\To\YourProject" -Overwrite
```

---

## 📖 Danh mục Skills và Hướng dẫn sử dụng

| Tên Skill | Mô tả | Cách kích hoạt trong chat |
|---|---|---|
| **`plan`** | Quy trình thực thi task 3 pha: Brainstorm → Execute → Lưu Learnings | "Lên kế hoạch và thực thi task này giúp mình", "/plan" |
| **`brainstorming`** | Làm rõ ý tưởng, hỏi từng câu một, khóa hiểu biết trước khi bắt đầu code | "Brainstorm ý tưởng làm tính năng...", "Phân tích yêu cầu tính năng X" |
| **`frontend-design`** | Thiết kế giao diện hiện đại, chuẩn Design Tokens, Typography, hiệu ứng mượt mà | "Thiết kế giao diện landing page/dashboard...", "Tối ưu UI cho mobile" |
| **`webapp-testing`** | Kiểm thử ứng dụng Web toàn diện: E2E Playwright, Vitest, Component & Edge cases | "Viết test Playwright cho luồng login", "Kiểm thử component modal" |
| **`find-bugs`** | Quét git diff trên nhánh để tìm lỗi tiềm ẩn, lỗ hổng bảo mật (OWASP, SQLi, XSS) | "Quét bug và bảo mật trên nhánh hiện tại", "Review diff" |
| **`code-reviewer`** | Đánh giá chất lượng code, kiến trúc, hiệu năng và chuẩn clean code | "Review file/PR này giúp mình", "Đánh giá chất lượng mã nguồn" |
| **`ai-learning`** | Tự động tổng hợp kiến thức từ đoạn chat vào `.agents/learnings/` | "Lưu learnings từ task này vào dự án", "Tổng hợp kinh nghiệm vừa làm" |
| **`human-learning`** | Viết tài liệu giải thích dạng 'coffee talk' phân tích tư duy, bài học cho developer | "Viết tài liệu tổng kết kinh nghiệm dạng coffee talk cho task vừa rồi" |

---

## 📐 Danh mục Rules (Tự động áp dụng)

1. **`load-learnings.md`**:
   - **Tự động kích hoạt** ở đầu mỗi phiên trò chuyện.
   - Quét danh sách `.agents/learnings/`, chỉ đọc các tài liệu liên quan đến task để tiết kiệm token và áp dụng ngầm vào câu trả lời.
2. **`web-design-backbone.md`**:
   - **Luật bất khả thương lượng** khi xây dựng Frontend Web.
   - Bắt buộc dùng Google Font, hệ thống CSS Variables, Spacing hệ bội số 4/8px, Responsive không cuộn ngang, vi tương tác hover/focus và chuẩn truy cập WCAG.

---

## 🧰 Yêu cầu công cụ & Cách cài đặt nếu thiếu

Khi chạy `setup.ps1`, script sẽ tự động kiểm tra xem máy bạn đã có đủ các công cụ hỗ trợ cho các skills hay chưa. Nếu thiếu, bạn có thể cài đặt dễ dàng theo hướng dẫn dưới đây:

### 1. Git (Cần cho `find-bugs`, `code-reviewer`)
- **Kiểm tra**: `git --version`
- **Cách cài đặt**:
  - Dùng Winget: `winget install --id Git.Git -e --source winget`
  - Hoặc tải bộ cài từ: [https://git-scm.com/download/win](https://git-scm.com/download/win)

### 2. Node.js & npm (Cần cho `frontend-design`, `webapp-testing`)
- **Kiểm tra**: `node -v` và `npm -v`
- **Cách cài đặt**:
  - Dùng Winget: `winget install OpenJS.NodeJS.LTS`
  - Hoặc tải từ trang chủ: [https://nodejs.org/](https://nodejs.org/)

### 3. Playwright (Cần cho chạy E2E tests trong `webapp-testing`)
Trong thư mục dự án Web của bạn, cài đặt bằng:
```bash
npm install -D @playwright/test
npx playwright install
```

### 4. Vitest (Cần cho chạy Unit / Component test trong `webapp-testing`)
```bash
npm install -D vitest
```

---

## 📂 Cấu trúc thư mục sau khi cài đặt

```text
<Thư mục dự án của bạn>/
├── .agents/
│   ├── rules/
│   │   ├── load-learnings.md
│   │   └── web-design-backbone.md
│   ├── skills/
│   │   ├── ai-learning/SKILL.md
│   │   ├── brainstorming/SKILL.md
│   │   ├── code-reviewer/SKILL.md
│   │   ├── find-bugs/SKILL.md
│   │   ├── frontend-design/SKILL.md
│   │   ├── human-learning/SKILL.md
│   │   ├── plan/SKILL.md
│   │   └── webapp-testing/SKILL.md
│   └── learnings/
│       └── landing-page.md
├── <toàn bộ mã nguồn dự án của bạn được giữ nguyên 100%>
```

---

## 🤝 Giấy phép & Tác giả
- Phát triển cho hệ sinh thái **Google Antigravity**.
- Quản lý và bảo trì bởi **nlong05013456-oss**.
