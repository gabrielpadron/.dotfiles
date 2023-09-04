#!/bin/bash

# Função que exibe o menu e retorna a opção selecionada
show_menu() {
    options=("Shutdown" "Reboot" "Logout" "Suspend")

    selected_option=$(printf '%s\n' "${options[@]}" | dmenu -l 4 -i)
    echo "$selected_option"
}

# Função para desligar o PC
shutdown_pc() {
    systemctl poweroff
}

# Função para reiniciar o PC
reboot_pc() {
    systemctl reboot
}

# Função para suspender o PC
suspend_pc() {
    systemctl suspend
}

logout_pc() {
    i3-msg exit
}

# Mostrar o menu e executar a opção selecionada
selected=$(show_menu)

case "$selected" in
    "Shutdown")
        shutdown_pc
        ;;
    "Reboot")
        reboot_pc
        ;;
    "Logout")
        logout_pc
        ;;
    "Suspend")
        suspend_pc
        ;;
    *)
        echo "Invalid option."
        ;;
esac
