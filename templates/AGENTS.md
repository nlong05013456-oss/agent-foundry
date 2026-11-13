# Quy Ước Dự Án & Chỉ Dẫn Agent (AGENTS.md)

Tài liệu thiết lập ngữ cảnh và các quy tắc làm việc bắt buộc dành cho AI Agent (Anti / Antigravity) trong dự án này.

---

## 1. Bốn Luật Nền Cốt Lõi (Bắt Buộc Tuân Thủ)

Mọi AI Agent khi làm việc trong dự án này PHẢI tuân thủ nghiêm ngặt 4 nguyên tắc sau:

1. **Đọc cấu trúc & theo quy ước hiện có**: Trước khi chỉnh sửa hoặc tạo mới, phải khảo sát kỹ cây thư mục, phong cách code, thư viện đang dùng và tuân thủ nhất quán các quy chuẩn sẵn có của dự án.
2. **Giữ thay đổi đúng phạm vi**: Chỉ can thiệp vào các tệp và chức năng liên quan trực tiếp đến yêu cầu; tuyệt đối không tự ý refactor lan man hoặc sửa đổi các phần code ngoài phạm vi được giao.
3. **Chạy kiểm tra phù hợp trước khi báo xong**: Luôn chủ động chạy các lệnh kiểm tra tương ứng (build, lint, typecheck, unit test...) để xác nhận không phát sinh lỗi hoặc cảnh báo trước khi thông báo hoàn tất task.
4. **Tra catalog để cài thêm đúng mục khi cần**: Khi bắt đầu một giai đoạn công việc mới (làm giao diện web, viết kịch bản test, debug bảo mật, review code, dọn dẹp thư mục...), AI phải tra cứu file `CATALOG.md` trong kho cấu hình chuẩn để cài đặt đúng skill và rule cần thiết vào thư mục `.agents/` của dự án.

---

## 2. Thông Tin Dự Án (Điền khi khởi tạo)

- **Tên dự án**: [Điền tên dự án]
- **Mục tiêu chính**: [Mô tả ngắn gọn chức năng cốt lõi và bài toán dự án giải quyết]
- **Công nghệ sử dụng**: [Ví dụ: React, Vite, TypeScript, Tailwind CSS, Node.js...]

---

## 3. Lệnh Kiểm Tra Dự Án (Verification Commands)

- **Chạy môi trường Dev**: `npm run dev`
- **Kiểm tra Linter/Format**: `npm run lint`
- **Kiểm tra Kiểu dữ liệu**: `npm run typecheck`
- **Chạy Tests**: `npm test` hoặc `npx playwright test`
- **Build Production**: `npm run build`

---

## 4. Hướng Dẫn Dành Cho Anti: Nhận Diện Ý Định & Cài Đặt Cấu Hình Tự Động

Khi người dùng đưa ra bất kỳ yêu cầu nào bằng ngôn ngữ tự nhiên:

1. **Suy ra mục đích từ toàn bộ yêu cầu**:
   - Đối chiếu yêu cầu của người dùng với cột *“Câu nói mẫu”* và *“Việc cần làm”* trong file `CATALOG.md` (từ clone cục bộ `D:\Tools\antigravity-starter\CATALOG.md` hoặc GitHub repo `https://github.com/nlong05013456-oss/antigravity-starter`).
2. **Phân loại hành động**:
   - **Nếu yêu cầu khớp rõ với một mục trong catalog**:
     - Kiểm tra trong thư mục `.agents/` của dự án đích.
     - Nếu đã có sẵn: dùng ngay skill/rule đó để thực hiện yêu cầu.
     - Nếu còn thiếu: tự động chạy script `setup.ps1` để cài chọn lọc đúng mục còn thiếu vào dự án hiện tại:
       ```powershell
       <Đường_dẫn_kho>\setup.ps1 -ProjectPath "." -Skills "<Tên_Skill>" -Rules "<Tên_Rule>"
       ```
       sau đó tiến hành thực hiện yêu cầu.
   - **Nếu yêu cầu kết hợp nhiều việc** (ví dụ: *“làm lại giao diện rồi test nút đăng nhập”*):
     - Xác định và lấy đủ tất cả các mục tương ứng (ví dụ: `frontend-design`, `web-design-backbone` và `webapp-testing`).
   - **Nếu là việc nhỏ, đơn giản** (ví dụ: *“sửa một chữ trên nút Đăng nhập”*, sửa typo, chỉnh nhanh 1 giá trị):
     - Xử lý trực tiếp ngay lập tức nếu chỉ dẫn hiện tại đã đủ, **KHÔNG** cài đặt thêm skill hay rule không cần thiết.
3. **Phạm vi tác động**:
   - Mọi skill/rule cài thêm phải nằm trong `.agents/` của dự án đích.
   - Giữ nguyên 100% mã nguồn dự án và các nội dung tùy biến trong file `AGENTS.md` này.
