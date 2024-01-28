#!/bin/bash

# color defination
red="\e[1;31m"
green="\e[1;32m"
yellow="\e[1;33m"
blue="\e[1;34m"
megenta="\e[1;1;35m"
cyan="\e[1;36m"
end="\e[1;0m"

# initial texts
attention="${yellow}[ ATTENTION ]${end}"
action="${green}[ ACTION ]${end}"
note="${megenta}[ NOTE ]${end}"
done="${cyan}[ DONE ]${end}"
error="${red}[ ERROR ]${end}"

log="Install-Logs/install-$(date +%d-%m-%Y_%I:%M-%p)_dotfiles.log"

printf "${note} - Please choose your distro to config the ${green}Neofetch${end}...\nDebian/Ububtu: ( D/d )\nArch/Arch based: ( A/a )\nFedora/Fedora based: ( F/f )\nOpenSuse: ( O/o )\nVoid Linux: ( V/v )\nOpenBSD: ( OB/Ob/ob )\nFreeBSD: ( FB/Fb/fb )\nCentOs/RHEL: ( R/r )\n"
    read -p "Select: " distro

    sleep 1

    case "$distro" in
        D|d) printf "${ACT} - Installing zsh in your distro\n"
            distro="apt install"
            ;;
        A|a) printf "${ACT} - Installing zsh in your distro\n"
            distro="pacman -S"
            ;;
        F|f) printf "${ACT} - Installing zsh in your distro\n"
            distro="dnf install"
            ;;
        O|o) printf "${ACT} - Installing zsh in your distro\n"
            distro="zypper install"
            ;;
        V|v) printf "${ACT} - Installing zsh in your distro\n"
            distro="xbps-install"
            ;;
        OB|Ob|ob) printf "${ACT} - Installing zsh in your distro\n"
            distro="pkg_add"
            ;;
        FB|Fb|fb) printf "${ACT} - Installing zsh in your distro\n"
            distro="pkg install"
            ;;
        R|r) printf "${ACT} - Installing zsh in your distro\n"
            distro="yum -y install"
            ;;
        *) printf "${ERROR} - Please choose a valid option\n"
    esac
    sleep 1


mkdir -p ~/.config

    printf "${note} - Copying config files...\n" 2>&1 | tee -a "$log"
    for DIR in alacritty cava hypr kitty neofetch swaylock waybar wlogout wofi; do
        DIRPATH=~/.config/$DIR
        if [ -d "$DIRPATH" ]; then
            printf "${attention} - Config for $DIR located, backing up.\n" 2>&1 | tee -a "$log"
            mv $DIRPATH $DIRPATH-back
            printf "${done} - Backed up $DIR to $DIRPATH-back.\n" 2>&1 | tee -a "$log"
        fi
    done

    sleep 1

    clear

    printf "${action} - Cloning and copying dotfiles...\n" 2>&1 | tee -a "$log" && sleep 1

    hypr_dir="$HOME/.config/hypr"
    if [ -d $hypr_dir ]; then
    mv ~/.config/hypr ~/.config/hypr-backup
    fi

    git clone https://github.com/me-js-bro/Hyprland-Dots-01.git ~/.config/hypr 2>&1


    cp -r "$dotfiles_dir" "$HOME/.config/"

    ln -sf ~/.config/hypr/kitty ~/.config/kitty
    ln -sf ~/.config/hypr/alacritty ~/.config/alacritty
    ln -sf ~/.config/hypr/cava ~/.config/cava
    ln -sf ~/.config/hypr/neofetch ~/.config/neofetch
    ln -sf ~/.config/hypr/swaylock ~/.config/swaylock
    ln -sf ~/.config/hypr/waybar ~/.config/waybar
    ln -sf ~/.config/hypr/wlogout ~/.config/wlogout
    ln -sf ~/.config/hypr/wofi ~/.config/wofi
    ln -sf ~/.config/hypr/dunst ~/.config/dunst
    sleep 1
    printf "${done} - Copying config files finished...\n" 2>&1 | tee -a "$log"

sleep 1

# Adding all the scripts

SCRIPT_DIR=~/.config/hypr/scripts/
if [ -d $SCRIPT_DIR ]; then
    # make all the scripts executable...
    chmod +x "$SCRIPT_DIR"/*

    printf "${done} - All the necessary scripts have been executable.\n" 2>&1 | tee -a "$log"

    sleep 1
else
    printf "${error} - Could not find necessary scripts\n" 2>&1 | tee -a "$log"
fi

WLDIR=/usr/share/wayland-sessions
if [ -d "$WLDIR" ]; then
    printf "${done} - $WLDIR found\n"
else
    printf "${attention} - $WLDIR NOT found, creating...\n"
    sudo mkdir $WLDIR
    sudo cp extras/hyprland.desktop /usr/share/wayland-sessions/
fi

clear