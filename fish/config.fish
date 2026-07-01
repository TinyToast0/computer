if status is-interactive
    # Commands to run in interactive sessions can go here
end
zoxide init fish | source
set -Ux QML2_IMPORT_PATH "/usr/lib/qt6/qml:$HOME/.config/quickshell/modules"
alias n="nvim"
alias nas="n ~/.config/fish/config.fish"
alias pacs="sudo pacman -S"
alias pacr="sudo pacman -R"
alias pacu="sudo pacman -Syu"
alias ffmp4="~/.config/bash/scripts/ffmpeg_mp4_png.sh"
alias myGit="git clone https://github.com/TinyToast0/computer"
alias Script="cd ~/.config/dev/"
alias bScript="cd ~/.config/dev/bash/scripts/"
alias gitignore="nvim /home/toast/.config/.gitignore"

# Created by `pipx` on 2026-06-04 13:41:09
set PATH $PATH /home/toast/.local/bin

fastfetch
