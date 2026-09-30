#!/bin/bash

# 1. Kiểm tra tham số đầu vào
if [ -z "$1" ]; then
    echo "Lỗi: Chưa cung cấp thư mục cần sao lưu!"
    exit 1
fi

TARGET_DIR="$1"

# 2. Kiểm tra sự tồn tại của thư mục
if [ ! -d "$TARGET_DIR" ]; then
    echo "Lỗi: Thư mục '$TARGET_DIR' không tồn tại!"
    exit 2
fi

# 3. Tạo thư mục sao lưu ~/backup nếu chưa có
BACKUP_DIR="$HOME/backup"
mkdir -p "$BACKUP_DIR"

# 4. Lấy tên thư mục và thời gian hiện tại
DIR_NAME=$(basename "$(realpath "$TARGET_DIR")")
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="${BACKUP_DIR}/${DIR_NAME}_${TIMESTAMP}.tar.gz"

PROJECT_ROOT=$(cd "$(dirname "$0")/.." && pwd)
LOG_FILE="${PROJECT_ROOT}/logs/backup.log"

# 5. Nén thư mục thành file .tar.gz
tar -czf "$BACKUP_FILE" -C "$(dirname "$(realpath "$TARGET_DIR")")" "$DIR_NAME"

# 6. Ghi nhật ký vào logs/backup.log
if [ $? -eq 0 ]; then
    echo "[$(date +"%Y-%m-%d %H:%M:%S")] Backup thành công: $BACKUP_FILE" >> "$LOG_FILE"
    echo "Sao lưu thành công: $BACKUP_FILE"
    exit 0
else
    echo "Lỗi trong quá trình nén dữ liệu!"
    exit 3
fi
