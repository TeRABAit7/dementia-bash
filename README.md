# 🧠 DEMENTIA BASH (или БАШ С ДЕМЕНЦИЕЙ)
Этот проект был создан из внезапной идеи интуитивного bash для новичков
это идеал жаль я не додумался когда только начинал в линукс
надеюсь вам понравится его использовать
все старые команды остаются рабочими
так же при желании вы сами можете изменить команды под себя или добавить свои

## 📝 Как добавить свои команды вручную?
зайди в ~/.bashrc
и напиши в самый низ
alias твоя команда='команда системы'
```bash
## 🛠 Быстрая установка
git clone https://github.com/TeRABAit7/dementia-bash.git
cd dementia-bash
chmod +x install.sh
./install.sh
```
## 📋 Список доступных команд:
# --- НАВИГАЦИЯ И ОБЗОР ---
 go='cd'
 back='cd ..'
 ..='cd ..'
 w='pwd'
 where='pwd'

# --- ФАЙЛЫ И ПАПКИ ---
 new='touch'
 n='touch'
 dir='mkdir -p'
 del='rm'
 delf='rm -rf'
 copy='cp -r'
 move='mv'

# --- РАБОТА С ТЕКСТОМ ---
 show='cat'
 page='less'
 logs='tail -f'
 edit='nano'

# --- СИСТЕМА И ПРАВА ---
 x='chmod +x'
 own='sudo chown -R $USER:$USER'
 owner='sudo chown -R $USER:$USER'
 tasks='ps aux'

# --- ЖЕЛЕЗО И ДИСКИ ---
 disk='df -h'
 size='du -sh'
 ram='free -h'

# --- УТИЛИТЫ ---
 q='exit'
 me='whoami'

# --- ПАКЕТНЫЙ МЕНЕДЖЕР ---
*Эти команды сами определят ваш дистрибутив (Void, Arch, Ubuntu или Fedora) и запустят нужный менеджер пакетов:*
* `up` или `update` = Обновить всю систему (`xbps-install -Su`, `pacman -Syu`, `apt upgrade`...)
* `in` или `install` = Установить программу
* `remove` или `delp` = Удалить программу со всеми зависимостями
