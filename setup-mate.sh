#! /bin/bash
#-------------------------------------------------------
apk add mc wget htop fastfetch
#-------------------------------------------------------
# Repositories (vX.XX or edge or latest-stable)
#-------------------------------------------------------
{
	echo "# /media/cdrom/apks"
	echo "http://mirror.ps.kz/alpine/v3.24/main"
	echo "http://mirror.ps.kz/alpine/v3.24/community"
	echo "http://mirror.ps.kz/alpine/edge/main"
	echo "http://mirror.ps.kz/alpine/edge/community"
	echo "# http://mirror.ps.kz/alpine/edge/testing"
} > /etc/apk/repositories
#-------------------------------------------------------
# Locales
#-------------------------------------------------------
sed -i 's/#unicode="NO"/#unicode="NO"\nunicode="YES"/' /etc/rc.conf
apk add terminus-font ttf-inconsolata ttf-dejavu font-misc-cyrillic
#-------------------------------------------------------
apk add tzdata musl-locales musl-locales-lang
#-------------------------------------------------------
{
	echo "export CHARSET=ru_RU.UTF-8"
	echo "export LANGUAGE=ru_RU.UTF-8"
	echo "export LANG=ru_RU.UTF-8"
	echo "export LC_ALL=ru_RU.UTF-8"
} > /etc/profile.d/20locale.sh
#-------------------------------------------------------
apk add lang
#-------------------------------------------------------
# xorg and etc
#-------------------------------------------------------
setup-xorg-base
setup-wayland-base
#-------------------------------------------------------
apk add alsa-utils alsa-plugins-pulse pulseaudio pulseaudio-alsa pulseaudio-utils pulseaudio-bluez pavucontrol
#-------------------------------------------------------
# NetworkManager
#-------------------------------------------------------
apk add networkmanager networkmanager-tui networkmanager-cli networkmanager-wifi network-manager-applet
#-------------------------------------------------------
# For Wi-Fi, add user to plugdev group
#-------------------------------------------------------
adduser user plugdev
#-------------------------------------------------------
# Setup Mate and etc
#-------------------------------------------------------
setup-desktop mate
#-------------------------------------------------------
apk add xdg-user-dirs xdg-utils elogind polkit polkit-elogind apk-polkit-rs apk-polkit-rs-dbg apk-polkit-rs-dev apk-polkit-rs-openrc samba samba-client gstreamer gvfs gvfs-afc gvfs-mtp gvfs-smb avahi wsdd cronie gcompat
#-------------------------------------------------------
# Home dirs
#-------------------------------------------------------
{
	echo "ru_RU"
} > $HOME/.config/user-dirs.locale
#-------------------------------------------------------
# xdg-user-dirs-update
#-------------------------------------------------------
# {
#	mv "$HOME/Desktop" "$HOME/Рабочий стол"
#	mv "$HOME/Downloads" "$HOME/Загрузки"
#	mv "$HOME/Templates" "$HOME/Шаблоны"
#	mv "$HOME/Public" "$HOME/Общие"
#	mv "$HOME/Documents" "$HOME/Документы"
#	mv "$HOME/Music" "$HOME/Музыка"
#	mv "$HOME/Pictures" "$HOME/Изображения"
#	mv "$HOME/Videos" "$HOME/Видео"
#	mv "$HOME/Projects" "$HOME/Проекты"
# }
#-------------------------------------------------------
# On/Off services
#-------------------------------------------------------
# rc-service networking stop
# rc-service networkmanager start
# rc-service samba start
# rc-service avahi-daemon start
# rc-service wsdd start
# rc-service apk-polkit-server start
#-------------------------------------------------------
rc-update add networkmanager default
rc-update add samba default
rc-update add avahi-daemon default
rc-update add wsdd default
rc-update add apk-polkit-server default
rc-update del networking boot
#-------------------------------------------------------
# Add apps
#-------------------------------------------------------
apk add mate-tweak eom atril 7zip shotwell pinta transmission evolution parole vlc shotcut gnome-shortwave audacious audacity libreoffice libreoffice-lang-ru
#-------------------------------------------------------
# Add Gnonome software
#-------------------------------------------------------
apk add gnome-software gnome-software-bash-completion gnome-software-dbg gnome-software-dev gnome-software-doc gnome-software-lang gnome-software-lib flatpak gnome-software-plugin-flatpak gnome-software-plugin-sysupdate gnome-software-systemd gnome-software-plugin-apk2 gnome-software-plugin-apk2-dbg
#-------------------------------------------------------
# Flathub repo
#-------------------------------------------------------
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
#-------------------------------------------------------
# Greeters
#-------------------------------------------------------
lightdm-bash-completion lightdm-dev lightdm-doc lightdm-lang slick-greeter slick-greeter-doc slick-greeter-lang lightdm-gtk-greeter lightdm-gtk-greeter-doc lightdm-gtk-greeter-lang lightdm-openrc lightdm-settings lightdm-settings-lang
#-------------------------------------------------------
# exit
reboot
