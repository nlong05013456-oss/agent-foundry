---
name: webapp-testing
description: "Chuyên gia kiểm thử ứng dụng Web: End-to-End (Playwright/Cypress), Component testing, API mocking và kiểm tra chất lượng toàn diện"
---

# Web App Testing Skill

Quy trình và chuẩn mực kiểm thử phần mềm ứng dụng Web toàn diện, từ Unit, Component đến End-to-End (E2E), kiểm thử hiệu năng, độ tin cậy và khả năng tiếp cận (Accessibility).

---

## Khi nào sử dụng
- Khi viết kịch bản kiểm thử (test suite) mới cho tính năng, component hoặc API.
- Khi kiểm thử hồi quy (regression testing) trước khi release.
- Khi cần mô phỏng hành vi người dùng cuối (E2E testing) bằng Playwright hoặc Cypress.
- Khi phát hiện bug khó tái hiện, cần viết test case để cô lập và bảo đảm không tái diễn.

---

## 1. Tháp kiểm thử (Testing Strategy)

1. **Unit & Logic Tests**:
   - Kiểm tra các hàm tính toán, utils, custom hooks, reducers độc lập.
   - Công cụ: **Vitest** (khuyến nghị cho Vite/Modern) hoặc **Jest**.
2. **Component & Integration Tests**:
   - Kiểm tra khả năng render, tương tác sự kiện (click, type) và trạng thái hiển thị của UI.
   - Công cụ: **Testing Library** (`@testing-library/react` / `@testing-library/vue`).
3. **End-to-End (E2E) & Visual Tests**:
   - Kiểm tra toàn bộ luồng người dùng (user journey) trên trình duyệt thực tế.
   - Công cụ: **Playwright** (ưu tiên hàng đầu) hoặc **Cypress**.

---

## 2. Kịch bản E2E chuẩn với Playwright

### Cấu trúc bài test mẫu:

```typescript
import { test, expect } from '@playwright/test';

test.describe('Authentication & User Flow', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
  });

  test('Người dùng đăng nhập thành công và thấy dashboard', async ({ page }) => {
    // 1. Arrange & Act
    await page.getByRole('button', { name: /đăng nhập/i }).click();
    await page.getByLabel(/email/i).fill('testuser@example.com');
    await page.getByLabel(/mật khẩu/i).fill('SecurePassword123!');
    await page.getByRole('button', { name: /xác nhận/i }).click();

    // 2. Assert
    await expect(page).toHaveURL(/.*dashboard/);
    await expect(page.getByRole('heading', { name: /tổng quan/i })).toBeVisible();
  });

  test('Hiển thị thông báo lỗi khi thông tin không hợp lệ', async ({ page }) => {
    await page.getByRole('button', { name: /đăng nhập/i }).click();
    await page.getByLabel(/email/i).fill('wrong@example.com');
    await page.getByLabel(/mật khẩu/i).fill('wrongpass');
    await page.getByRole('button', { name: /xác nhận/i }).click();

    await expect(page.getByText(/thông tin đăng nhập không chính xác/i)).toBeVisible();
  });
});
```

---

## 3. Checklist Kiểm thử Edge Cases (Trường hợp biên)

Mỗi khi kiểm thử một tính năng, PHẢI kiểm tra các kịch bản sau:

- [ ] **Mạng chậm / Chập chờn (Network Throttling)**: Nút bấm có trạng thái loading rõ ràng không? Có bị submit đúp (double submit) khi bấm nhiều lần không?
- [ ] **Dữ liệu rỗng (Empty State)**: Danh sách chưa có dữ liệu có hiển thị lời mời tạo mới thân thiện không?
- [ ] **Dữ liệu cực lớn (Stress Data)**: Text quá dài có bị vỡ layout không (`text-overflow: ellipsis`)?
- [ ] **Xử lý lỗi API (Error Boundary)**: Khi server trả về 401, 403, 500, giao diện có crash màn hình trắng không?
- [ ] **Responsive Viewports**: Kiểm tra trên cả Mobile (375x667), Tablet (768x1024), Desktop (1440x900).
- [ ] **Form Validation**: Kiểm tra bỏ trống trường bắt buộc, nhập ký tự đặc biệt, SQL injection, script tags (`<script>`).

---

## 4. Công cụ hỗ trợ & Lệnh thực thi

- **Playwright Test Runner**:
  ```bash
  npx playwright test
  npx playwright test --ui     # Chế độ giao diện trực quan
  npx playwright show-report   # Xem báo cáo chi tiết
  ```
- **Vitest**:
  ```bash
  npx vitest run               # Chạy một lần
  npx vitest --coverage        # Đo độ bao phủ mã nguồn
  ```
- **Lighthouse / Axe-core (Accessibility)**:
  - Kiểm tra độ tương phản màu sắc và thẻ ARIA hợp lệ.

