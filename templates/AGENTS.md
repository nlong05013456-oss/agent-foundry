# Hướng Dẫn Dự Án & Cấu Hình Agent (AGENTS.md)

Tài liệu thiết lập ngữ cảnh cốt lõi và hướng dẫn tương tác dành cho AI Agent (Anti / Antigravity) trong dự án này.

---

## 1. Thông Tin & Mục Tiêu Dự Án
- **Tên dự án**: [Điền tên dự án của bạn]
- **Mục tiêu chính**: [Mô tả ngắn gọn chức năng, giải pháp và giá trị cốt lõi mà sản phẩm mang lại]
- **Công nghệ sử dụng (Stack)**: [Ví dụ: React, TypeScript, Tailwind CSS, Vite, Node.js...]

---

## 2. Quy Ước Mã Nguồn (Coding Conventions)
- **Cấu trúc thư mục**: [Ví dụ: src/components, src/hooks, src/services...]
- **Phong cách lập trình**: [Ví dụ: Functional components, TypeScript strict mode, CSS variables, kebab-case file naming...]
- **Quy tắc an toàn**: Không commit secrets/keys, luôn kiểm tra null/undefined, handle network errors.

---

## 3. Lệnh Kiểm Tra Dự Án (Verification Commands)
- **Chạy môi trường dev**: `npm run dev`
- **Kiểm tra linter/format**: `npm run lint`
- **Kiểm tra kiểu dữ liệu**: `npm run typecheck`
- **Chạy kiểm thử (Unit / E2E)**: `npm test` hoặc `npx playwright test`
- **Build production**: `npm run build`

---

## 4. Kho Cấu Hình Chuẩn (Antigravity Starter Kit)
Dự án này sử dụng kho cấu hình chuẩn hóa **Antigravity Starter** để bổ sung kỹ năng và quy tắc khi cần:
- **Đường dẫn cục bộ**: `D:\Tools\antigravity-starter` (hoặc thư mục clone của bạn)
- **GitHub Repo (Private)**: `https://github.com/nlong05013456-oss/antigravity-starter`
- **Danh mục cấu hình chi tiết**: Xem file `CATALOG.md` tại kho cấu hình trên.

---

## 5. Hướng Dẫn Dành Riêng Cho AI Agent (Anti)

> 🤖 **DÀNH CHO ANTI KHI NGƯỜI DÙNG YÊU CẦU LẤY THÊM CẤU HÌNH / SKILLS / RULES:**

1. **Tra cứu danh mục**: Khi người dùng yêu cầu kích hoạt hoặc thêm kỹ năng (ví dụ: làm UI, viết test, review code, phân tích bugs...), Anti hãy đọc file `CATALOG.md` từ:
   - Bản clone cục bộ đã có tại đường dẫn ghi ở mục 4, HOẶC:
   - GitHub API từ repo Private `nlong05013456-oss/antigravity-starter` bằng quyền GitHub hiện có.
2. **Xác định gói cần cài**: Chọn đúng tên `-Skills` và/hoặc `-Rules` tương ứng từ `CATALOG.md`.
3. **Thực thi cài đặt tự động**: Chạy script `setup.ps1` từ kho cấu hình trỏ vào workspace của dự án này:
   ```powershell
   <Đường_dẫn_kho>\setup.ps1 -ProjectPath "." -Skills "<Tên_Skill>" -Rules "<Tên_Rule>"
   ```
4. **Phạm vi tác động**:
   - Tất cả các file kỹ năng và quy tắc được cài đặt sẽ nằm gọn gàng trong thư mục `.agents/` ở gốc dự án đích.
   - Không được làm ảnh hưởng đến mã nguồn dự án hiện tại cũng như các nội dung tùy biến trong file `AGENTS.md` này.
