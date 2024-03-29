#!/bin/bash

# Gnome Installtion
yes | sudo apt-get install xorg xterm menu synaptic gnome-session gnome-panel metacity gnome-terminal gnome-control-center --no-install-recommends
yes | sudo   apt install gnome-shell-extension-dash-to-panel gnome-shell-extension-desktop-icons gnome-shell-extension-gamemode nemo xinit git wget papirus-icon-theme firefox gnome-shell-extension-top-icons-plus gedit pulseaudio network-manager gnome-system-monitor

gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close" 
gnome-extensions enable dash-to-panel@jderose9.github.com
gnome-extensions enable desktop-icons@csoriano
gnome-extensions enable gamemode@christian.kellner.me
gnome-extensions enable TopIcons@phocean.net

# Snap + flatpak
sudo apt install snap flatpak -y


# nala
sudo apt install nala -y

# installing git
sudo  apt install git -y

# Gnome Extensions
sudo nala install gnome-shell-extension-manager gnome-shell-extensions -y 

#zsh
sudo nala install zsh zsh-syntax-highlighting autojump zsh-autosuggestions -y
touch "~/.cache/zshhistory"
#-- Setup Alias in $HOME/zsh/aliasrc
mkdir ~/.zsh
mkdir ~/.zsh/plugins/
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/plugins/powerlevel10k
echo 'source ~/.zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ~/.zsh/plugins/zsh-autocomplete
echo 'source ~/.zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh' >> ~/.zshrc
echo 'skip_global_compinit=1' >> ~/.zshenv

# make zsh default
chsh -s $(which zsh)

# fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
sudo unzip FiraCode.zip -d "/usr/share/fonts"
sudo unzip Meslo.zip -d "/usr/share/fonts"
sudo fc-cache -vf
rm ./FiraCode.zip ./Meslo.zip

# theme
sudo git clone https://github.com/EliverLara/Nordic.git /usr/share/themes/Nordic
gsettings set org.gnome.desktop.interface gtk-theme Nordic
gsettings set org.gnome.desktop.wm.preferences theme Nordic

# gtk 4 support
wget https://github.com/odziom91/libadwaita-themes/raw/main/nordic/nordic-v42.zip
sudo unzip nordic-v42.zip -d /root/.config/
unzip nordic-v42.zip -d ~/.config/

# snap theme support
sudo snap install gtk-theme-nordic --edge
for i in $(snap connections | grep gtk-common-themes:gtk-3-themes | awk '{print $2}'); do sudo snap connect $i gtk-theme-nordic:gtk-3-themes; done
for i in $(snap connections | grep gtk-common-themes:gtk-4-themes | awk '{print $2}'); do sudo snap connect $i gtk-theme-nordic:gtk-4-themes; done

# icon theme
sudo nala install papirus-icon-theme -y
gsettings set org.gnome.desktop.interface icon-theme Papirus-Dark

# Install brave-browser
sudo nala install apt-transport-https curl -y
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo nala update
sudo nala install brave-browser -y

# remove firefox
sudo snap remove firefox

# ubuntu spyware remover
sudo apt purge ubuntu-report popularity-contest apport whoopsie -y
sudo apt autoremove --purge -y

# installing vlc
sudo nala install vlc -y

# power managment
sudo apt purge -y power-profiles-daemon
sudo snap install auto-cpufreq
sudo auto-cpufreq --install

# install neofetch
sudo nala install neofetch -y

# preload
sudo nala install preload -y
sudo systemctl enable preload
sudo systemctl start preload

# make english default
echo "LC_ALL=en_US.UTF-8" | sudo tee -a /etc/environment
