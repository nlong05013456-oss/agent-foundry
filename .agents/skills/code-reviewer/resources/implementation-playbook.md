# Code Reviewer Implementation Playbook

Tài liệu hướng dẫn thực tế các bước review mã nguồn hiện đại hỗ trợ bởi AI và công cụ phân tích tĩnh.

---

## 1. Quy trình rà soát nhanh (Quick Pass)
- Kiểm tra tính nhất quán trong naming conventions.
- Đảm bảo không có secret keys / tokens bị commit vào mã nguồn.
- Kiểm tra xử lý ngoại lệ (try/catch) và fallback khi network hoặc API fail.

## 2. Tiêu chuẩn hiệu năng (Performance Checklist)
- Tránh render thừa (memoization, virtualization cho danh sách lớn).
- Tối ưu truy vấn dữ liệu (tránh N+1 query, debouncing cho input tìm kiếm).
- Dọn dẹp event listeners và subscriptions trong hook cleanup.

