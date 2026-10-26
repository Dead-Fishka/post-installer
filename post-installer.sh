#!/bin/bash
#-------------------------------------------------------
apk add mc wget
#-------------------------------------------------------
# Repositories (vX.XX or edge or latest-stable)
#-------------------------------------------------------
{
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
}
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
apk add xdg-user-dirs xdg-utils elogind polkit polkit-elogind apk-polkit-rs apk-polkit-rs-dbg apk-polkit-rs-dev apk-polkit-rs-openrc gvfs gvfs-afc gvfs-mtp gvfs-smb acpid avahi wsdd cronie gcompat
#-------------------------------------------------------
# Home dirs
#-------------------------------------------------------
{
	echo "# This file is written by xdg-user-dirs-update"
	echo "# If you want to change or add directories, just edit the line you're"
	echo "# interested in. All local changes will be retained on the next run."
	echo "# Format is XDG_xxx_DIR="$HOME/yyy", where yyy is a shell-escaped"
	echo "# homedir-relative path, or XDG_xxx_DIR="/yyy", where /yyy is an"
	echo "# absolute path. No other format is supported."
	echo "# "
	echo "XDG_DESKTOP_DIR="$HOME/Рабочий стол""
	echo "XDG_DOWNLOAD_DIR="$HOME/Загрузки""
	echo "XDG_TEMPLATES_DIR="$HOME/Шаблоны""
	echo "XDG_PUBLICSHARE_DIR="$HOME/Общие""
	echo "XDG_DOCUMENTS_DIR="$HOME/Документы""
	echo "XDG_MUSIC_DIR="$HOME/Музыка""
	echo "XDG_PICTURES_DIR="$HOME/Изображения""
	echo "XDG_VIDEOS_DIR="$HOME/Видео""
	echo "XDG_PROJECTS_DIR="$HOME/Проекты""
} > /home/user/.config/user-dirs.dirs
#-------------------------------------------------------
# On/Off services
#-------------------------------------------------------
rc-service networking stop
rc-service networkmanager start
rc-service wsdd start
rc-service apk-polkit-server start
#-------------------------------------------------------
rc-update add networkmanager default
rc-update add wsdd boot
rc-update add apk-polkit-server default
rc-update del networking boot
#-------------------------------------------------------
