#!/bin/bash

options="  Shutdown\n  Reboot\n  Suspend\n  Logout"

chosen=$(echo -e "$options" | rofi -dmenu -i -p "Power Menu" -selected-row 1)

action="${chosen:3}"

case "$action" in
    "Shutdown")
        systemctl poweroff
        ;;
    "Reboot")
        systemctl reboot
        ;;
    "Suspend")
        systemctl suspend
        ;;
    "Logout")
        # Попробуем разные варианты в зависимости от окружения
        if [[ "$XDG_SESSION_DESKTOP" =~ "sway" ]]; then
            swaymsg exit
        elif [[ "$XDG_SESSION_DESKTOP" =~ "GNOME" ]]; then
            gnome-session-quit --logout --no-prompt
        elif [[ "$XDG_SESSION_DESKTOP" =~ "KDE" ]]; then
            qdbus org.kde.ksmserver /KSMServer logout 0 0 0
        fi
        ;;
esac
