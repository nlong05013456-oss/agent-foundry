---
name: organize-project
description: "Chuyên gia rà soát, dọn dẹp và tổ chức cấu trúc thư mục dự án theo chuẩn kiến trúc sạch, an toàn và dễ bảo trì"
---

<!-- 
  Origin:
  - Original work created specifically for agent-foundry by nlong05013456-oss.
-->

# Organize Project Skill

Hướng dẫn quy trình chuyên nghiệp để rà soát, dọn dẹp và tái cấu trúc cây thư mục của dự án phần mềm, bảo đảm dự án gọn gàng, tuân thủ cấu trúc chuẩn của từng hệ sinh thái và không làm hỏng các đường dẫn import.

---

## Khi nào sử dụng
- Khi thư mục dự án trở nên lộn xộn, nhiều tệp tin rải rác ở gốc (root) chưa được gom nhóm.
- Khi muốn tái cấu trúc (refactor) từ cấu trúc phẳng sang cấu trúc module hóa (Feature-based hoặc Layer-based).
- Khi dọn dẹp các tệp tạm, tệp rác, hoặc cấu hình trùng lặp sau một thời gian phát triển dài.
- Trước khi release hoặc bàn giao dự án cho team khác.

---

## 1. Nguyên tắc tổ chức cốt lõi (Không thương lượng)

1. **Gốc dự án sạch sẽ (Clean Root Directory)**:
   - Thư mục gốc chỉ chứa các tệp cấu hình cốt lõi (`package.json`, `README.md`, `AGENTS.md`, `.gitignore`, `tsconfig.json`...).
   - Tuyệt đối không để mã nguồn tự do (loose files) ngoài thư mục `src/` hoặc `app/`.
2. **Quy chuẩn đặt tên nhất quán (Consistent Naming)**:
   - Thư mục: `kebab-case` (ví dụ: `auth-flow`, `user-profile`) hoặc `camelCase` tùy theo quy ước hiện có của dự án.
   - Tệp React/Vue components: `PascalCase` (ví dụ: `UserProfile.tsx`, `HeaderBar.vue`).
   - Tệp hooks: bắt đầu bằng `use` (ví dụ: `useAuth.ts`, `useDebounce.ts`).
   - Tệp utils/services: `kebab-case` hoặc `camelCase` (ví dụ: `api-client.ts`, `formatDate.ts`).
3. **An toàn liên kết Import (Import Path Integrity)**:
   - Trước khi di chuyển bất kỳ tệp nào, AI PHẢI quét toàn bộ các vị trí đang import tệp đó và cập nhật đồng thời đường dẫn import (ưu tiên dùng path aliases `@/...` nếu dự án có cấu hình).

---

## 2. Quy trình 4 bước thực hiện

### Bước 1: Quét và phân tích hiện trạng (Audit)
- Liệt kê toàn bộ cấu trúc cây thư mục hiện tại.
- Xác định kiểu kiến trúc phù hợp:
  - **Feature-based** (khuyến nghị cho app lớn): Gom component, hook, service, test theo từng tính năng (ví dụ: `features/auth/`, `features/checkout/`).
  - **Layer-based** (phù hợp cho app nhỏ/vừa): Gom theo tầng kỹ thuật (`components/`, `hooks/`, `services/`, `utils/`, `types/`).
- Lập danh sách các tệp mồ côi (không được import ở đâu) hoặc tệp tạm cần dọn dẹp.

### Bước 2: Đề xuất kế hoạch tổ chức (Plan & Approval)
- Trình bày bảng so sánh:
  - Cấu trúc cũ → Cấu trúc mới đề xuất.
  - Danh sách tệp sẽ di chuyển và đường dẫn mới.
  - Danh sách tệp rác đề xuất xóa (nếu có).
- **Hỏi xác nhận từ người dùng trước khi thực hiện.**

### Bước 3: Thực thi từng bước an toàn (Safe Execution)
1. Tạo các thư mục đích mới nếu chưa có.
2. Di chuyển từng tệp hoặc cụm tệp liên quan.
3. Cập nhật lại đường dẫn `import` trong tất cả các tệp tham chiếu.
4. Kiểm tra lại `.gitignore` để đảm bảo không bỏ sót các tệp build/cache tạm thời.

### Bước 4: Kiểm tra và xác minh (Verification)
- Chạy lệnh typecheck hoặc build của dự án (ví dụ: `npm run typecheck` hoặc `npm run build`).
- Chạy unit tests (nếu có) để đảm bảo không bị lỗi import runtime.

---

## 3. Checklist hoàn tất

- [ ] Gốc dự án không còn file mã nguồn tự do?
- [ ] Tất cả imports đã được cập nhật chính xác và build thành công?
- [ ] Không có file tạm (`.tmp`, `*.bak`, `Thumbs.db`) bị bỏ lại?
- [ ] Quy tắc đặt tên tệp và thư mục đã đồng nhất 100%?

