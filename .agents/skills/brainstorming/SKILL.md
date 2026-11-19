---
name: brainstorming
description: Dùng trước khi xây dựng tính năng, đổi kiến trúc hoặc đổi hành vi khi yêu cầu còn mơ hồ. Biến ý tưởng thô thành thiết kế đã được người dùng xác nhận (Understanding Lock, phương án, Decision Log). Thường được skill `plan` gọi ở Pha 1; cũng dùng độc lập khi người dùng chỉ muốn bàn thiết kế, chưa muốn code.
---

<!-- 
  Origin Chain:
  1. Root: obra/superpowers (skills/brainstorming/SKILL.md) by Jesse Vincent (MIT License)
  2. Intermediate: benjaminasterA/antigravity-awesome-skills (MIT License)
  3. Intermediate: quang26071999/demo_landing_page (No license file) - Vietnamese translation
  4. Current: agent-foundry (Heavily refactored, streamlined for Gate 1 workflow)
-->

# Brainstorming

Biến ý tưởng thô thành thiết kế rõ ràng, đã được xác nhận, trước khi bất kỳ dòng code nào được viết.

Skill này ngăn bốn thứ: làm sớm, giả định ngầm, giải pháp lệch ý, hệ thống dễ vỡ.

## Vai trò và giới hạn

Bạn là người hỗ trợ thiết kế, không phải người xây dựng. Khi skill này đang chạy:
- KHÔNG viết code, KHÔNG sửa file dự án, KHÔNG chạy lệnh làm thay đổi dự án.
- Chỉ được tạo/sửa file plan `.agents/plans/<slug>.md` (cấu trúc và quy tắc trạng thái xem skill `plan`).
- Không thêm tính năng suy đoán. Làm đúng điều người dùng cần, không hơn (YAGNI).

## Chọn chế độ

Theo cỡ task đã phân loại ở rule `workflow-gate`:
- **Vừa → chế độ gọn**: bước 1, 2, 4, 5 (rút gọn). Bỏ qua bước 3 và 6 nếu không liên quan.
- **Lớn → chế độ đầy đủ**: làm đủ các bước 1–7.

## Quy trình

### 1. Nắm hiện trạng (làm trước khi hỏi)
Đọc các file, tài liệu, kế hoạch và quyết định trước đó liên quan. Xác định cái gì đã có, cái gì được đề xuất mới, và ràng buộc nào đang ngầm tồn tại. Chưa thiết kế ở bước này.

### 2. Làm rõ yêu cầu
- Hỏi **tối đa 3 câu một lượt**, ưu tiên trắc nghiệm, chỉ hỏi điều thật sự chưa rõ.
- Điều suy ra được từ code/ngữ cảnh thì ghi thành **giả định**, không hỏi.
- Nếu một chủ đề cần đào sâu, để lượt sau.
- Cần hiểu: mục đích, người dùng mục tiêu, ràng buộc, tiêu chí thành công, và những gì **không** nằm trong phạm vi.

### 3. Yêu cầu phi chức năng (chế độ đầy đủ)
Làm rõ hoặc đề xuất mặc định cho: hiệu năng, quy mô (người dùng/dữ liệu/traffic), bảo mật & quyền riêng tư, độ tin cậy, bảo trì. Người dùng không chắc → đề xuất giá trị hợp lý và đánh dấu rõ là giả định.

### 4. Understanding Lock (cổng bắt buộc)
Trình bày đúng định dạng sau, rồi ghi vào file plan:

```
## Understanding Lock
- Làm gì:
- Vì sao:
- Cho ai:
- Ràng buộc chính:
- Ngoài phạm vi:
## Giả định
- ...
## Câu hỏi còn mở
- ... (hoặc "Không")
```

Sau đó hỏi: *"Điều này có đúng ý bạn không? Xác nhận hoặc sửa trước khi mình bắt đầu."*

**Kết thúc lượt trả lời tại đây.** Không đề xuất thiết kế, không gọi tool nào khác. Chỉ tiếp tục khi người dùng xác nhận rõ ràng. Việc ghi `gate1` và `gate1_quote` theo đúng quy tắc của skill `plan`.

### 5. Phương án
Sau khi Lock được xác nhận:
- Đề xuất 2–3 phương án khả thi, nêu phương án khuyến nghị trước.
- Mỗi phương án nêu đánh đổi: độ phức tạp, khả năng mở rộng, rủi ro, bảo trì.
- Chỉ có một cách hợp lý thì nói thẳng và bỏ so sánh.
- Chờ người dùng chọn.

### 6. Trình bày thiết kế (chế độ đầy đủ)
Chia phần ≤300 từ, hỏi *"Phần này ổn không?"* sau mỗi phần. Bao gồm khi liên quan: kiến trúc, thành phần, luồng dữ liệu, xử lý lỗi, trường hợp biên, chiến lược kiểm thử.

### 7. Decision Log
Ghi liên tục vào file plan, mỗi quyết định gồm: đã chọn gì, đã xem xét phương án nào khác, vì sao chọn.

## Điều kiện kết thúc

Chỉ rời brainstorming khi đủ cả năm:
1. Understanding Lock đã được xác nhận.
2. Đã có phương án được chấp nhận rõ ràng.
3. Giả định chính đã ghi lại.
4. Rủi ro chính đã ghi lại.
5. Decision Log đã cập nhật.

Thiếu điều nào → tiếp tục làm rõ, không triển khai.

## Sau thiết kế

- Thiết kế cuối cùng (Lock, giả định, phương án, Decision Log) nằm trong file plan.
- Nếu dùng trong `plan` → quay lại quy trình của `plan` (checklist, Pha 2).
- Nếu dùng độc lập → hỏi: *"Sẵn sàng chuyển sang triển khai chưa?"* và chỉ làm tiếp khi người dùng đồng ý.
- Thiết kế rủi ro cao (bảo mật, dữ liệu, thanh toán, thay đổi không thể hoàn tác) → nhờ người dùng hoặc người có chuyên môn xem lại trước khi code.

## Nguyên tắc

- Nêu giả định rõ ràng, không ngầm hiểu.
- Khám phá phương án thay thế trước khi chốt.
- Xác nhận từng bước, không đoán là đã đồng ý.
- Ưu tiên rõ ràng hơn thông minh.
- Sẵn sàng quay lại sửa Lock khi phát hiện hiểu sai.
