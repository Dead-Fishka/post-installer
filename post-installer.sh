#!/bin/bash
#-------------------------------------------------------
apk add mc wget
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
# setup-wayland-base
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
apk add xdg-user-dirs xdg-utils elogind polkit polkit-elogind apk-polkit-rs apk-polkit-rs-dbg apk-polkit-rs-dev apk-polkit-rs-openrc samba samba-client gvfs gvfs-afc gvfs-mtp gvfs-smb acpid avahi wsdd cronie gcompat
#-------------------------------------------------------
# Home dirs
#-------------------------------------------------------
{
	echo "ru_RU"
} > $HOME/.config/user-dirs.locale
#-------------------------------------------------------
xdg-user-dirs-update
#-------------------------------------------------------
{
	mv "$HOME/Desktop" "$HOME/Рабочий стол"
	mv "$HOME/Downloads" "$HOME/Загрузки"
	mv "$HOME/Templates" "$HOME/Шаблоны"
	mv "$HOME/Public" "$HOME/Общие"
	mv "$HOME/Documents" "$HOME/Документы"
	mv "$HOME/Music" "$HOME/Музыка"
	mv "$HOME/Pictures" "$HOME/Изображения""
	mv "$HOME/Videos" "$HOME/Видео"
	mv "$HOME/Projects" "$HOME/Проекты"
}
#-------------------------------------------------------
# On/Off services
#-------------------------------------------------------
rc-service networking stop
rc-service networkmanager start
rc-service samba start
rc-service wsdd start
rc-service apk-polkit-server start
#-------------------------------------------------------
rc-update add networkmanager default
rc-update add samba default
rc-update add wsdd default
rc-update add apk-polkit-server default
rc-update del networking boot
#-------------------------------------------------------

#-------------------------------------------------------
# exit
reboot

