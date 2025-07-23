#!/bin/bash

# Использование
if [ -z "$1" ]; then
    echo "Usage: $0 <PID or process name> [sleep_interval_seconds]"
    exit 1
fi

TARGET="$1"
SLEEP_INTERVAL="${2:-5}"

# Проверка, что интервал — положительное число
if ! [[ "$SLEEP_INTERVAL" =~ ^[0-9]+$ ]] || [ "$SLEEP_INTERVAL" -le 0 ]; then
    echo "Error: sleep interval must be a positive integer."
    exit 2
fi

# Функция: ждать по PID через /proc
wait_by_pid() {
    PID="$1"
    while [ -d "/proc/$PID" ]; do
        echo "$(date) : Waiting for PID $PID to exit..."
        sleep "$SLEEP_INTERVAL"
    done
}

# Функция: ждать по имени процесса
wait_by_name() {
    NAME="$1"
    while pgrep -x "$NAME" > /dev/null; do
        echo "$(date) : Waiting for process '$NAME' to exit..."
        sleep "$SLEEP_INTERVAL"
    done
}

# Определяем, PID это или имя
if [[ "$TARGET" =~ ^[0-9]+$ ]]; then
    wait_by_pid "$TARGET"
else
    wait_by_name "$TARGET"
fi

echo "Process exited."
exit 0
