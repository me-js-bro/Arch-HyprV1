#!/bin/bash

#----Defining Colorful Actions----#
ATTENTION="\e[1;33m[ ATTENTION ]\e[0m"
ACTION="\e[1;32m[ ACTION ]\e[0m"
NOTE="\e[1;36m[ NOTE ]\e[0m"
DONE="\e[1;92m[ DONE ]\e[0m"
ERROR="\e[1;31m[ ERROR ]\e[0m"


printf "${ATTENTION} - This script for installing zsh, oh-my-zsh and configuring theme has been executed.\nThis may ask for your sudo password to change shell... Would you like to install \e[36m' zsh '\e[0m first? ( y/n )\n"
sleep 1

read -n1 -rep "Select: " user_agreed

sleep 1

clear

if [[ $user_agreed == "y" || $user_agreed == "Y" ]]; then

    printf "${NOTE} - Please choose your distro...\nDebian/Ububtu: ( D/d )\nArch/Arch based: ( A/a )\nFedora/Fedora based: ( F/f )\nOpenSuse: ( O/o )\nVoid Linux: ( V/v )\nOpenBSD: ( OB/Ob/ob )\nFreeBSD: ( FB/Fb/fb )\nCentOs/RHEL: ( R/r )\n"
    read -n1 -rep "Select: " distro

    sleep 1

    case "$distro" in
        D|d) read "${ACTION} - Installing zsh in your distro\n"
            package_man="apt install"
            ;;
        A|a) read "${ACTION} - Installing zsh in your distro\n"
            package_man="pacman -S"
            ;;
        F|f) read "${ACTION} - Installing zsh in your distro\n"
            package_man="dnf install"
            ;;
        O|o) read "${ACTION} - Installing zsh in your distro\n"
            package_man="zypper install"
            ;;
        V|v) read "${ACTION} - Installing zsh in your distro\n"
            package_man="xbps-install"
            ;;
        OB|Ob|ob) read "${ACTION} - Installing zsh in your distro\n"
            package_man="pkg_add"
            ;;
        FB|Fb|fb) read "${ACTION} - Installing zsh in your distro\n"
            package_man="pkg install"
            ;;
        R|r) read "${ACTION} - Installing zsh in your distro\n"
            package_man="yum -y install"
            ;;
        *) printf "${ERROR} - Please choose a valid option\n"
    esac
    sleep 1

    # Installation process
    printf "sudo $package_man zsh\n"

else
    printf "${ATTENTION} - Proceeding to the next step \e[33m[ oh-my-zsh installation ]\e[0m\n"

fi


#---- Installing zsh ----#
# sudo pacman -S zsh || # Arch & Arch based distro
# sudo apt install zsh || # Debian & Ubuntu based distro
# sudo dnf install zsh || # Fedora & Fedora based distro
# sudo zypper install zsh || # Opensuse
# sudo xbps-install zsh || # void linux
# sudo pkg_add zsh || # OpenBSD
# sudo pkg install zsh # FreeBSD
# sudo yum update && sudo yum -y install zsh # CentOs/RHEL
