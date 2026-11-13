---
name: plan
description: "Quy trình thực thi task lập trình toàn diện: Brainstorming → Execution → Tự động lưu Learnings"
---

# Plan & Execute Skill

Quy trình 3 pha chuẩn mực để thực thi bất kỳ task lập trình nào: **Brainstorm → Execute → Save Learnings**.

---

## Khi nào sử dụng
- Khi bắt đầu một task tính năng, refactoring hoặc giải quyết vấn đề kỹ thuật quan trọng.
- Cần lập kế hoạch chặt chẽ, kiểm soát rủi ro và xác thực từng bước trước khi hoàn thành.

---

## Pha 1: BRAINSTORM (Bắt buộc)

Trước khi viết code, AI **PHẢI** thực hiện quy trình brainstorming để làm rõ yêu cầu và thiết kế.

### Bước 1.1: Load Learnings liên quan

1. Đọc danh sách file trong `.agents/learnings/`.
2. Xác định và đọc nội dung các file learnings liên quan đến task hiện tại (ví dụ: `patterns.md`, `architecture.md`, `bugs-solutions.md`, v.v.).
3. Tóm tắt ngắn: "Đã load X learnings liên quan đến task này: [danh sách]".

### Bước 1.2: Kích hoạt Brainstorming

Áp dụng quy trình từ skill `brainstorming` (`.agents/skills/brainstorming/SKILL.md`):

1. **Understand Context**: Đọc các file liên quan trong project, hiểu trạng thái hiện tại.
2. **Ask Questions**: Hỏi từng câu một, ưu tiên câu hỏi trắc nghiệm (multiple-choice) để làm rõ yêu cầu.
3. **Non-Functional Requirements**: Làm rõ hiệu năng, quy mô, bảo mật.
4. **Understanding Lock**: Tổng hợp 5-7 gạch đầu dòng, nêu rõ giả định, yêu cầu người dùng xác nhận.
   - **KHÔNG được tiếp tục nếu chưa có xác nhận từ người dùng.**
5. **Design Approaches**: Đề xuất 2-3 phương án tiếp cận, phân tích ưu nhược điểm (trade-offs).
6. **Present Design**: Trình bày thiết kế chi tiết từng phần nhỏ (200-300 từ) và xác nhận từng phần.
7. **Decision Log**: Ghi lại các quyết định đã thống nhất.

> ⛔ **Cổng kiểm soát (Gate 1)**: Tuyệt đối không chuyển sang Pha 2 nếu chưa hoàn thành Understanding Lock và chưa được người dùng duyệt thiết kế.

---

## Pha 2: EXECUTE

### Bước 2.1: Tạo Task Checklist

Dựa trên thiết kế đã duyệt, lập checklist chi tiết:

```markdown
- [ ] Task 1: Mô tả công việc cụ thể
  - [ ] Sub-task 1.1
  - [ ] Sub-task 1.2
- [ ] Task 2: Mô tả công việc cụ thể
```

### Bước 2.2: Thực thi từng bước

Với mỗi task trong checklist:

1. Đánh dấu `[/]` khi bắt đầu thực hiện.
2. Thực hiện Context Audit:
   - Quét ngữ cảnh code hiện tại
   - Rà soát biến và state
   - Kiểm tra hàm và dependencies
   - Xác minh tác động phụ (impact check)
3. Viết code sạch, đúng quy chuẩn thiết kế và rules của dự án (xem `.agents/rules/`).
4. Đánh dấu `[x]` khi hoàn thành task con.

### Bước 2.3: Verify (Xác thực chất lượng)

Sau khi hoàn thành code, chạy bộ công cụ xác thực tương ứng với công nghệ của dự án:
- Với Node/Web: `npm run lint` / `npm test` / `npm run build`
- Với Python: `pytest` / `flake8` / `ruff`
- Với Go: `go test ./...` / `go vet`
- Với Rust: `cargo check` / `cargo test`
- Với Java/Kotlin: `./gradlew test` / `./gradlew check`

Nếu phát hiện lỗi, quay lại Bước 2.2 để sửa trước khi tiếp tục.

> ⛔ **Cổng kiểm soát (Gate 2)**: Không chuyển sang Pha 3 nếu code build lỗi hoặc tests chưa vượt qua.

---

## Pha 3: SAVE LEARNINGS (Bán tự động)

### Bước 3.1: Hỏi xác nhận

Sau khi verify thành công:
> "Task đã hoàn thành và xác thực thành công. Bạn có muốn lưu learnings từ task này vào `.agents/learnings/` không? (Có/Không)"

- Nếu **Không** → Kết thúc quy trình.
- Nếu **Có** → Tiếp tục Bước 3.2.

### Bước 3.2: Kích hoạt skill `ai-learning`

Sử dụng skill `ai-learning` (`.agents/skills/ai-learning/SKILL.md`) để phân loại thông tin vào 4 nhóm:
- **Architecture**: Quyết định kiến trúc & lý do
- **Bugs & Solutions**: Lỗi gặp phải, root cause và giải pháp
- **How-To**: Quy trình thực hiện cụ thể
- **Patterns**: Coding patterns hoặc conventions mới

---

## Kết thúc Quy trình

Tóm tắt ngắn gọn:
1. Những việc đã hoàn thành
2. Learnings đã lưu (nếu có)
3. Các bước tiếp theo hoặc lưu ý tồn đọng (nếu có)
