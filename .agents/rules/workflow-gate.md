---
description: Cổng kiểm soát quy trình cho mọi task lập trình (phân loại, Gate 1, Gate 2, learnings)
globs: **/*
trigger: always_on
---
# Workflow Gate

Rule này luôn có hiệu lực. Chi tiết từng bước nằm ở skill `plan`; rule này chỉ giữ các cổng.

## 1. Phân loại task (làm ngay khi nhận yêu cầu)

| Cỡ | Dấu hiệu | Hành động |
|---|---|---|
| **Nhỏ** | Sửa chữ/chính tả, đổi tên biến, chỉnh style 1 chỗ, không đổi hành vi, chỉ đụng 1 file | Làm thẳng, không cần `plan` |
| **Vừa** | Tính năng nhỏ, bug đã biết nguyên nhân, đụng 2–5 file | BẮT BUỘC dùng skill `plan` (chế độ gọn) |
| **Lớn** | Tính năng mới, refactor, đổi kiến trúc/dữ liệu/bảo mật, bug chưa rõ nguyên nhân, đụng >5 file | BẮT BUỘC dùng skill `plan` (chế độ đầy đủ) |

- Nghi ngờ giữa hai cỡ → chọn cỡ cao hơn.
- Dòng đầu tiên của phản hồi PHẢI là: `Phân loại: Nhỏ | Vừa | Lớn — <lý do 1 câu>`.
- Nếu đang làm dở mà phát hiện task to hơn dự kiến → dừng, phân loại lại, báo người dùng.

## 2. Gate 1: chưa duyệt thì chưa được code

Với task Vừa/Lớn, khi file `.agents/plans/<slug>.md` chưa có `gate1: approved` hoặc `gate1: waived`:
- KHÔNG tạo, sửa, xóa file nào ngoài `.agents/plans/`.
- KHÔNG chạy lệnh cài đặt, migrate, hay lệnh làm thay đổi dự án.
- Sau khi trình bày Understanding Lock, KẾT THÚC lượt trả lời và chờ người dùng. Không đoán là họ đã đồng ý.
- Chỉ được chuyển sang `approved` ở một lượt SAU lượt trình bày, và phải chép NGUYÊN VĂN câu duyệt của người dùng vào `gate1_quote`.
- Câu như "làm đi", "ok làm luôn" khi chưa thấy Understanding Lock KHÔNG phải là duyệt. Hãy trình bày Lock ngắn rồi hỏi lại. Nếu người dùng nói rõ muốn bỏ qua brainstorming → ghi `gate1: waived` kèm câu nói của họ.

## 3. Gate 2: chưa verify thì chưa được báo xong

Chỉ được nói "hoàn thành" khi file plan có `gate2: passed` và `gate2_evidence` ghi rõ lệnh đã chạy cùng kết quả thật. Không có test/lint thì ghi đúng như vậy và báo cho người dùng; không được viết "đã pass".

## 4. Learnings

Trước khi kết thúc task Vừa/Lớn PHẢI hỏi người dùng có muốn lưu learnings không và ghi kết quả vào `learnings:` trong file plan (`saved` / `declined`). Chưa hỏi = chưa xong.

## 5. Dấu hiệu đang tự bào chữa → dừng lại, làm đúng quy trình

- "Task này đơn giản nên bỏ brainstorming"
- "Người dùng đang vội, làm trước hỏi sau"
- "Mình hiểu ý rồi, không cần xác nhận"
- "Chạy test chắc sẽ pass, khỏi chạy"
- "Chưa cần hỏi lưu learnings, lần sau hỏi"
