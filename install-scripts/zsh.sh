#!/bin/bash

###### Hyprland Installation Script for Arch Linux ######
#                                                       #
#       ███╗   ███╗ █████╗ ██╗  ██╗██╗███╗   ██╗        #
#       ████╗ ████║██╔══██╗██║  ██║██║████╗  ██║        #
#       ██╔████╔██║███████║███████║██║██╔██╗ ██║        #
#       ██║╚██╔╝██║██╔══██║██╔══██║██║██║╚██╗██║        #
#       ██║ ╚═╝ ██║██║  ██║██║  ██║██║██║ ╚████║        #
#       ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝        #
#                                                       #
#########################################################

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

log="Install-Logs/zsh.log"

# install script dir
ScrDir=`dirname "$(realpath "$0")"`
source $ScrDir/1-global.sh

# install zsh
install_package zsh "$log"

# ---- oh-my-zsh installation ---- #
printf "${action} - Now installing ${yellow}' oh-my-zsh, zsh-autosuggestions, zsh-syntax-highlighting, powerlevel10k theme '${end}...\n"
sleep 2

oh_my_zsh_dir="$HOME/.oh-my-zsh"

# if the .oh-my-zsh dir is available, then backup it first
if [ -d "$oh_my_zsh_dir" ]; then
    printf "${attention} - $oh_my_zsh_dir located, it is necessary to remove or rename it for the installation process. So renaming the directory...\n"
    printf "[ ATTENTION ] - $oh_my_zsh_dir located, it is necessary to remove or rename it for the installation process. So renaming the directory.\n" 2>&1 | tee -a "$log" &>> /dev/null
    mv $oh_my_zsh_dir "$oh_my_zsh_dir-back"
fi

  # installing plugins
 	  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && \
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k && \

printf "${done} - Installation completed...\n"
printf "[ DONE ] - Installation completed.\n" 2>&1 | tee -a "$log" &>> /dev/null

  # changing user shell
  user_shell=$(echo $SHELL)

  if [[ $user_shell == "/usr/bin/zsh" ]]; then
    printf "${note} - Your shell is already zsh. No need to change it.\n"
    printf "[ NOTE ] - Shell is already zsh. No need to change it.\n" 2>&1 | tee -a "$log" &>> /dev/null
  else
    printf "${action} - Changing shell to ${cyan}zsh ${end}\n"
    printf "[ ACTION ] - Changing shell to zsh\n" 2>&1 | tee -a "$log" &>> /dev/null
    chsh -s $(which zsh)
  fi
sleep 1

printf "${action} - Now proceeding to the next step, Configuring $HOME/.zshrc file\n"
sleep 2

  # backing up and copying files for zsh and p10k theme
  if [ -f ~/.zshrc ]; then
    printf "${action} - Backing up the .zshrc to .zshrc.back\n"
        mv ~/.zshrc ~/.zshrc.back
    sleep 1

    printf "${done} - Backup done\n"
  fi

  if [ -f ~/.p10k.zsh ]; then
    printf "${action} - Backing up the .p10k.zsh file to .p10k.zsh.back\n"
        mv ~/.p10k.zsh ~/.p10k.zsh.back
  fi
  sleep 1


zshrc_file='extras/.zshrc'
p10k_file='extras/.p10k.zsh'

printf "${action} - Copying '$zshrc_file' and '$p10k_file' to the '$HOME/' directory\n"
sleep 1

cp $zshrc_file $p10k_file "$HOME/"

printf "${done} - Installation and configuration of ${yellow}zsh and oh-my-zsh${end} finished!\n"
printf "${done} - Installation and configuration of " zsh and oh-my-zsh " finished!\n" 2>&1 | tee -a "$log" &>> /dev/null
printf "${note} - You can always configure the powerlevel10k theme with the ${megenta} p10k configure${end} command in your termianal.\n"
printf "[ NOTE ]} - You can always configure the powerlevel10k theme with the " p10k configure " command in your termianal.\n" 2>&1 | tee -a "$log" &>> /dev/null

sleep 1
clear