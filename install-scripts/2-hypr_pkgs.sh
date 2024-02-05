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

log="Install-Logs/hypr_packages.log"

# install script dir
ScrDir=`dirname "$(realpath "$0")"`
source $ScrDir/1-global.sh

# Main Hyprland packages
hypr_packages=(
cliphist
dolphin
dunst
hyprland
kitty
polkit-kde-agent
swappy
waybar
wofi
xdg-desktop-portal-hyprland
)

# thunar file manager
thunar=(
thunar 
thunar-volman 
tumbler
ffmpegthumbnailer 
thunar-archive-plugin
)


# Instlling main packages...
printf "${note} - Installing main packages, this may take a while...\n" && sleep 1

    for hypr_pkgs in "${hypr_packages[@]}"; do
        install_package "$hypr_pkgs" "$log"
    done

sleep 1

clear

printf "${attention} - Would you like to install thunar file manager? \n"
read -n1 -rep "Select: " thunar_file

# installing thunar file manager
if [[ "$thunar_file" == "Y" || "$thunar_file" == "y" ]]; then
    printf "${note} - Installing Thunar file manager. \n"
        
        for thunar in "${thunar[@]}"; do
            install_package "$thunar" "$log"
        done
fi

clear