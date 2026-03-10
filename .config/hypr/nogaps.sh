#!/bin/bash

# Проверяем текущий размер границ
if [ "$(hyprctl getoption general:border_size | awk 'NR==1{print $2}')" -gt 0 ]; then
    # --- РЕЖИМ MINIMAL ---
    # Убираем границы (border), зазоры (gaps) и скругления (rounding)
    hyprctl --batch "\
        keyword general:border_size 0; \
        keyword general:gaps_in 0; \
        keyword general:gaps_out 0; \
        keyword decoration:rounding 0"

    # Скрываем Quickshell через IPC
    killall waybar
else
    # --- РЕЖИМ NORMAL ---
    # Возвращаем всё к значениям из hyprland.conf
    hyprctl reload

    # Показываем Quickshell обратно
    hyprctl dispatch exec waybar
fi
