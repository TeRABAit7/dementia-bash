#!/bin/bash

# Цвета для красивого вывода в терминале
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}==============================================${NC}"
echo -e "${GREEN}    🧠 УСТАНОВКА ПРОЕКТА \"БАШ С ДЕМЕНЦИЕЙ\"    ${NC}"
echo -e "${BLUE}==============================================${NC}"
echo "Меняем дедовские команды UNIX"
echo ""

# 1. Определяем, какой конфиг у пользователя (.bashrc или .zshrc)
if [ -n "$ZSH_VERSION" ] || [ -f "$HOME/.zshrc" ]; then
    CONF_FILE="$HOME/.zshrc"
else
    CONF_FILE="$HOME/.bashrc"
fi

echo -e "Найдена конфигурация: ${YELLOW}$CONF_FILE${NC}"

# Проверяем, не ставили ли мы этот конфиг ранее, чтобы не дублировать
if grep -q "BASH С ДЕМЕНЦИЕЙ" "$CONF_FILE"; then
    echo -e "${YELLOW}Предупреждение:${NC} Похоже, конфиг уже установлен в этот файл!"
    exit 0
fi

# 2. Дописываем код «Баша с деменцией» в самый конец файла
echo -e "Добавляю ультра-короткие команды... "

cat << 'EOF' >> "$CONF_FILE"

# ==========================================
#         BASH С ДЕМЕНЦИЕЙ (DEMENTIA BASH)
# ==========================================

# --- НАВИГАЦИЯ И ОБЗОР ---
alias go='cd'
alias back='cd ..'
alias ..='cd ..'
alias w='pwd'
alias where='pwd'
alias l='ls -la --color=auto'

# --- ФАЙЛЫ И ПАПКИ ---
n() {
    if [ -z "$1" ]; then echo "Name it, dummy!"; return 1; fi
    for f in "$@"; do [[ "$f" == *.* ]] && touch "$f" || touch "$f.txt"; done
}
alias new='n'
alias dir='mkdir -p'
alias del='rm'
alias delf='rm -rf'
alias copy='cp -r'
alias move='mv'

# --- УМНОЕ РЕДАКТИРОВАНИЕ ТЕКСТА ---
edit() {
    if [ -z "$1" ]; then echo "What should I edit, dummy?"; return 1; fi
    if [ -n "$DISPLAY" ] || [ -n "$WAYLAND_DISPLAY" ]; then
        if command -v mousepad >/dev/null 2>&1; then
            mousepad "$1" > /dev/null 2>&1 &
        else
            nano "$1"
        fi
    else
        nano "$1"
    fi
}
alias e='edit'
alias show='cat'
alias page='less'
alias logs='tail -f'

# --- СИСТЕМА И ПРАВА ---
alias x='chmod +x'
alias own='sudo chown -R $USER:$USER'
alias owner='sudo chown -R $USER:$USER'
alias tasks='ps aux'
alias c='clear'

# --- ЖЕЛЕЗО И ДИСКИ ---
alias disk='df -h'
alias size='du -sh'
alias ram='free -h'

# --- УТИЛИТЫ ---
alias q='exit'
alias me='whoami'

# --- МУЛЬТИДИСТРО ПАКЕТНЫЙ МЕНЕДЖЕР ---
_pkg_manager() {
    local action=$1
    local pkg=$2
    if [ -f /etc/void-release ]; then
        case $action in
            up)  sudo xbps-install -Su ;;
            in)  sudo xbps-install "$pkg" ;;
            out) sudo xbps-remove -R "$pkg" ;;
        esac
    elif [ -f /etc/arch-release ]; then
        case $action in
            up)  sudo pacman -Syu ;;
            in)  sudo pacman -S "$pkg" ;;
            out) sudo pacman -Rns "$pkg" ;;
        esac
    elif [ -f /etc/debian_version ]; then
        case $action in
            up)  sudo apt update && sudo apt upgrade -y ;;
            in)  sudo apt install -y "$pkg" ;;
            out) sudo apt purge -y "$pkg" && sudo apt autoremove -y ;;
        esac
    elif [ -f /etc/fedora-release ]; then
        case $action in
            up)  sudo dnf upgrade -y ;;
            in)  sudo dnf install -y "$pkg" ;;
            out) sudo dnf remove -y "$pkg" ;;
        esac
    else
        echo "Дистрибутив не поддерживается деменцией!"
        return 1
    fi
}
alias up='_pkg_manager up'
alias update='_pkg_manager up'
alias in='_pkg_manager in'
alias install='_pkg_manager in'
alias remove='_pkg_manager out'
alias delp='_pkg_manager out'
EOF

# 3. Накатываем кастомную бирюзовую тему для Mousepad, если скрипт запущен локально с файлами репозитория
THEME_DIR_4="$HOME/.local/share/gtksourceview-4/styles"
THEME_DIR_3="$HOME/.local/share/gtksourceview-3.0/styles"

mkdir -p "$THEME_DIR_4" "$THEME_DIR_3"

echo ""
echo -e "${GREEN}✔ Готово! Конфиг успешно установлен.${NC}"
echo -e "Чтобы всё заработало, перезапусти терминал или введи команду:"
echo -e "${YELLOW}source $CONF_FILE${NC}"
echo ""
