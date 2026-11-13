---
name: frontend-design
description: "Chuyên gia thiết kế và xây dựng giao diện frontend đẳng cấp, hiện đại, chuẩn UI/UX, responsive và tương tác mượt mà"
---

# Frontend Design Skill

Hướng dẫn toàn diện cho việc thiết kế và lập trình giao diện Web Frontend đạt đẳng cấp cao nhất (tương đương Apple, Stripe, Linear), tuân thủ nghiêm ngặt nguyên lý thiết kế và trải nghiệm người dùng.

---

## Khi nào sử dụng
- Khi thiết kế hoặc code UI mới: Landing pages, Dashboards, Web App Components, Modals, Forms.
- Khi cần nâng cấp giao diện cũ từ dạng thô/cơ bản lên chuẩn hiện đại, có chiều sâu và vi tương tác (micro-interactions).
- Khi tối ưu Responsive (Mobile / Tablet / Desktop), Dark Mode, Typography và Hệ màu.

---

## 1. Triết lý thiết kế (Design Philosophy)

1. **Premium & Delightful**:
   - Giao diện phải tạo ấn tượng thị giác chuyên nghiệp ngay trong 3 giây đầu tiên.
   - Tránh tuyệt đối giao diện đơn điệu, phẳng lì hoặc dùng các màu mặc định chưa qua tinh chỉnh (ví dụ: `#ff0000`, `blue`).
2. **Alive, Not Static**:
   - Mọi phần tử tương tác (button, link, card, input) đều phải có phản hồi thị giác: hover state, active state, focus ring mượt mà.
   - Hiệu ứng chuyển động (animations/transitions) có chủ đích, dùng đường cong gia tốc tự nhiên (`cubic-bezier(0.4, 0, 0.2, 1)`).
3. **Hierarchy & Scannability**:
   - Người dùng lướt qua phải nhận biết ngay cấu trúc thông tin: Headings rõ ràng, khoảng cách thoáng đãng, điểm nhấn CTA nổi bật.

---

## 2. Hệ thống Design Tokens (Bắt buộc dùng CSS Variables)

Mọi dự án UI phải khai báo và sử dụng hệ thống Design Tokens:

```css
:root {
  /* Colors */
  --color-primary: #6366f1;
  --color-primary-hover: #4f46e5;
  --color-primary-glow: rgba(99, 102, 241, 0.25);
  
  --color-bg: #0f172a;
  --color-surface: #1e293b;
  --color-surface-elevated: #334155;
  --color-border: rgba(255, 255, 255, 0.08);
  
  --color-text-primary: #f8fafc;
  --color-text-secondary: #94a3b8;
  --color-text-muted: #64748b;
  
  /* Spacing Scale (Bội số 4px/8px) */
  --space-1: 4px;
  --space-2: 8px;
  --space-3: 12px;
  --space-4: 16px;
  --space-6: 24px;
  --space-8: 32px;
  --space-12: 48px;
  --space-16: 64px;
  --space-20: 80px;

  /* Typography */
  --font-heading: 'Plus Jakarta Sans', system-ui, -apple-system, sans-serif;
  --font-body: 'Inter', system-ui, -apple-system, sans-serif;

  /* Radius */
  --radius-sm: 6px;
  --radius-md: 10px;
  --radius-lg: 16px;
  --radius-full: 9999px;

  /* Transitions */
  --transition-fast: 150ms cubic-bezier(0.4, 0, 0.2, 1);
  --transition-base: 300ms cubic-bezier(0.4, 0, 0.2, 1);
}
```

---

## 3. Quy chuẩn Thành phần (Component Patterns)

### Buttons
- Kích thước chạm tối thiểu: 44px x 44px (chuẩn mobile).
- Hiệu ứng hover: Nâng nhẹ (`transform: translateY(-2px)`) kết hợp tăng đổ bóng hoặc glow vi tế.
- Trạng thái loading: Phải hiển thị spinner rõ ràng, disable pointer events.

### Cards & Surfaces
- Áp dụng Glassmorphism hoặc Subtle Border: `border: 1px solid var(--color-border); background: var(--color-surface);`.
- Bo góc hiện đại (12px - 20px).
- Hiệu ứng hover: Nhẹ nhàng nổi lên và đổi viền sáng hơn.

### Typography
- Tiêu đề lớn (Display/Hero): Font-size co giãn mượt theo viewport: `font-size: clamp(2.25rem, 5vw, 4.5rem)`.
- Letter-spacing âm cho tiêu đề lớn: `letter-spacing: -0.025em;`.
- Tỉ lệ chiều cao dòng (Line-height): 1.1–1.25 cho Headings; 1.6–1.8 cho Body Text.

---

## 4. Responsive & Khả năng tiếp cận (Accessibility)

- **Mobile First**: Thiết kế từ màn hình nhỏ (375px) lên Tablet (768px), Laptop (1024px) và Desktop lớn (1440px+).
- **Tuyệt đối không gây cuộn ngang** (`overflow-x: hidden` có kiểm soát, container `max-width`).
- **Tương phản chuẩn WCAG AA**: Tỉ lệ tương phản màu chữ/màu nền tối thiểu 4.5:1.
- **Giảm chuyển động (Prefers-Reduced-Motion)**: Luôn bao gồm media query tôn trọng cài đặt hệ thống của người dùng.

---

## 5. Checklist kiểm tra giao diện trước khi hoàn tất

- [ ] Typography có phân cấp rõ rệt, font Google chất lượng cao?
- [ ] Không có màu sắc thô cứng hardcoded?
- [ ] Mọi nút bấm, thẻ thông tin đều có hover/focus/active state?
- [ ] Hiệu ứng chuyển động mượt, không giật lag?
- [ ] Đã kiểm tra hiển thị responsive ở 375px, 768px, 1200px?
- [ ] Đầy đủ `alt` cho hình ảnh và semantic tags (`<header>`, `<nav>`, `<main>`, `<footer>`)?
