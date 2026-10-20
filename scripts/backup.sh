#!/usr/bin/env bash
# Включение строгого режима обработки ошибок
set -e

# Определение путей
SRC_DIR="$HOME/ict_lab2/docs"
DEST_DIR="$HOME/ict_lab2/backup"
LOG_FILE="$HOME/ict_lab2/logs/backup.log"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Проверка существования исходной директории
if [ ! -d "$SRC_DIR" ]; then
    echo "Error: Source directory $SRC_DIR does not exist!" >&2
    exit 1
fi

# Создание архива
tar -czf "$DEST_DIR/docs_$TIMESTAMP.tar.gz" -C "$HOME/ict_lab2" docs
echo "[$(date)] Backup created: docs_$TIMESTAMP.tar.gz" >> "$LOG_FILE"

# Удаление архивов старше 7 дней
find "$DEST_DIR" -name "docs_*.tar.gz" -mtime +7 -exec rm {} \;
echo "[$(date)] Old backups cleaned up." >> "$LOG_FILE"
