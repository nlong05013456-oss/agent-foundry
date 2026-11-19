---
name: plan
description: Dùng khi người dùng yêu cầu thêm tính năng, refactor, đổi kiến trúc, hoặc sửa bug không tầm thường (đụng từ 2 file trở lên hoặc đổi hành vi). Điều phối 3 pha Brainstorm → Execute → Learnings với file trạng thái và hai cổng kiểm soát. Không dùng cho việc nhỏ (sửa chữ, đổi tên biến, chỉnh style 1 chỗ).
---

<!-- 
  Origin Chain:
  1. Upstream: quang26071999/demo_landing_page (.agent/workflows/plan.md) (No license file)
  2. Current: agent-foundry (Converted to modern Antigravity skill, refactored with physical state gate checks)
-->

# Plan & Execute

Quy trình 3 pha cho task cỡ **Vừa** hoặc **Lớn** (phân loại theo rule `workflow-gate`).
Mọi trạng thái được ghi vào **file plan**; các cổng chỉ qua được khi file plan có bằng chứng.

> Nạp learnings do rule `load-learnings` đảm nhiệm. Skill này không lặp lại bước đó.

## File plan: `.agents/plans/<slug>.md`

Tạo ngay khi bắt đầu (`<slug>` là tên ngắn dạng kebab-case, ví dụ `dark-mode-toggle`). Đây là file duy nhất được phép tạo trước Gate 1.

```markdown
---
size: Vừa | Lớn
gate1: pending          # pending | approved | waived
gate1_quote: ""         # nguyên văn câu duyệt của người dùng
gate2: pending          # pending | passed | passed-no-tests
gate2_evidence: ""      # lệnh đã chạy + kết quả thật
learnings: pending      # pending | saved | declined
---
## Understanding Lock
## Giả định
## Phương án đã chọn
## Decision Log
## Checklist
- [ ] ...
- [ ] Verify: ghi lệnh + kết quả vào gate2_evidence
- [ ] Hỏi người dùng có lưu learnings không
```

Quy tắc đổi trạng thái:
- `gate1` chỉ đổi sang `approved` ở lượt trả lời SAU lượt trình bày Understanding Lock, và phải chép nguyên văn câu duyệt vào `gate1_quote`.
- `gate2` chỉ đổi sang `passed` sau khi đã chạy lệnh verify thật và dán kết quả vào `gate2_evidence`.
- Không được tự sửa trạng thái trước khi có bằng chứng tương ứng.

---

## Pha 1: BRAINSTORM

Mục tiêu: hiểu đúng yêu cầu và chốt thiết kế trước khi viết code. Trong pha này không tạo/sửa file nào ngoài file plan.

### Chế độ gọn (task Vừa)
1. Đọc nhanh các file liên quan trong project để nắm hiện trạng.
2. Hỏi tối đa **3 câu một lượt**, ưu tiên trắc nghiệm, chỉ hỏi điều thật sự chưa rõ (mục tiêu, phạm vi, tiêu chí xong). Đã suy ra được thì ghi thành giả định, đừng hỏi.
3. Trình bày **Understanding Lock** (3–5 gạch đầu dòng): làm gì, vì sao, phạm vi, NGOÀI phạm vi, giả định.
4. Nếu có nhiều hướng với đánh đổi thật → nêu phương án khuyến nghị và 1 lựa chọn thay thế, mỗi cái kèm ưu/nhược 1 dòng. Chỉ có một cách hợp lý thì bỏ bước này.

### Chế độ đầy đủ (task Lớn)
Áp dụng skill `brainstorming` với một điều chỉnh: hỏi **tối đa 3 câu một lượt** thay vì từng câu một. Bắt buộc có:
- Yêu cầu phi chức năng: hiệu năng, quy mô, bảo mật (không rõ thì đề xuất mặc định và đánh dấu là giả định).
- 2–3 phương án với đánh đổi.
- Thiết kế chia phần ≤300 từ, xác nhận từng phần.
- Decision Log.

### Gate 1
Ghi Understanding Lock, giả định và (nếu có) phương án vào file plan. Sau đó:

1. Hỏi: *"Điều này có đúng ý bạn không? Xác nhận hoặc sửa trước khi mình bắt đầu."*
2. **Kết thúc lượt trả lời tại đây.** Không gọi tool ghi file nào khác, không chạy lệnh nào.
3. Lượt sau, nếu người dùng duyệt → chép nguyên văn câu của họ vào `gate1_quote`, đặt `gate1: approved`. Nếu họ sửa → cập nhật Lock và hỏi lại.
4. Nếu người dùng nói rõ muốn bỏ qua brainstorming → `gate1: waived` kèm câu nói của họ, rồi tiếp tục.

⛔ **Gate 1 chưa `approved` hoặc `waived` thì không sang Pha 2.**

---

## Pha 2: EXECUTE

### 2.1 Lập checklist
Từ thiết kế đã duyệt, chia thành task nhỏ, mỗi task kiểm chứng được. Ghi vào mục Checklist của file plan. Luôn có hai task cuối: **Verify** và **Hỏi lưu learnings**.

### 2.2 Thực thi từng task
Với mỗi task:
1. Đánh dấu `[/]` khi bắt đầu.
2. **Context audit** ngắn: đọc code liên quan, kiểm tra hàm/biến/dependency sẽ bị ảnh hưởng.
3. Viết code theo rules của dự án (`.agents/rules/`). Làm đúng phạm vi đã duyệt; thấy cần thêm việc ngoài phạm vi → ghi vào cuối plan và hỏi người dùng, không tự làm.
4. Đánh dấu `[x]` khi xong.

Nếu giữa chừng phát hiện thiết kế sai hoặc phạm vi phình to → dừng, báo người dùng, cập nhật Lock rồi xin duyệt lại (quay về Gate 1).

### 2.3 Verify
1. Đọc file cấu hình dự án (`package.json`, `pyproject.toml`, `go.mod`, `Cargo.toml`, `build.gradle`...) để biết lệnh lint/test/build **thực sự có**. Không đoán lệnh.
2. Chạy các lệnh đó (ví dụ Node: `npm run lint`, `npm test`, `npm run build`).
3. Ghi vào `gate2_evidence`: lệnh đã chạy và kết quả thật (pass/fail, số test, lỗi chính).
4. Có lỗi → quay lại 2.2 sửa rồi chạy lại. Không bỏ qua lỗi.
5. Dự án không có test/lint → đặt `gate2: passed-no-tests` và nói rõ với người dùng rằng chưa có kiểm chứng tự động.

⛔ **Gate 2 chưa `passed` hoặc `passed-no-tests` thì không sang Pha 3 và không được báo "hoàn thành".**

---

## Pha 3: LEARNINGS

Đây là task cuối trong checklist, không được bỏ qua.

1. Hỏi: *"Task đã xong và đã verify. Bạn có muốn lưu learnings từ task này vào `.agents/learnings/` không? (Có/Không)"*
2. **Không** → đặt `learnings: declined`, kết thúc.
3. **Có** → dùng skill `ai-learning` để lưu, đặt `learnings: saved`.

---

## Kết thúc

Tóm tắt ngắn gọn cho người dùng:
- Đã làm gì (đối chiếu checklist).
- Kết quả verify (trích `gate2_evidence`).
- Learnings: đã lưu / người dùng từ chối.
- Việc tồn đọng hoặc đề xuất bước tiếp theo (nếu có).
