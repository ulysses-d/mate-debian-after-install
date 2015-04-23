#!/bin/sh
# Скрипт по установке среды Mate и дополнительного программного
# обеспечения в свежеустановленный Debian 8
# Копируем заранее подготовленный файл sources.list с dropbox
wget -O sources.list http://goo.gl/nFmLwS
# копируем наш файл sources.list в каталог /etc/apt/sources.list.d/
cp sources.list /etc/apt/sources.list.d/
# Обновляем кэш, в результате работы команды вылезет несколько
# строк с ошибками о том что нет доверительных ключей
apt-get update
# Копируем и устанавливаем ключи
apt-get install deb-multimedia-keyring
apt-get install debian-keyring
wget -O- -q http://mozilla.debian.net/archive.asc | gpg --import
gpg --check-sigs --fingerprint --keyring /usr/share/keyrings/debian-keyring.gpg 06C4AE2A
gpg --export -a 06C4AE2A | apt-key add -
# и опять обновим кэш 
apt-get update
# Теперь вспомним про наш Broadcom, установим его и активуруем 
apt-get install linux-headers-$(uname -r|sed 's,[^-]*-[^-]*-,,') broadcom-sta-dkms
modprobe -r b44 b43 b43legacy ssb brcmsmac
modprobe wl
# Перед установкой Mate полностью обновим систему
apt-get upgrade
# Устанавливаем основные пакеты (полезет много зависимостей, соглашаемся,
# т.к. это практически все необходимый софт)
apt-get install xorg lightdm xdg-user-dirs xdg-user-dirs-gtk xdg-utils pulseaudio pavucontrol mate-desktop-environment-extra network-manager network-manager-gnome iceweasel mc iceweasel-l10n-ru flashplugin-nonfree mplayer2 smplayer gksu unrar
# Устанавливаем пакеты из Backports (полезет много зависимостей, соглашаемся,
# т.к. это практически все необходимый софт)
apt-get -t wheezy-backports install grub lightdm synaptic libreoffice libreoffice-l10n-ru ttf-mscorefonts-installer ttf-liberation libreoffice-style-sifr libreoffice-gtk libreoffice-gnome qt4-qtconfig transmission
# Устанавливаем строку быстрого поиска Synaptic
apt-get -t wheezy-backports install synaptic apt-xapian-index
# Ставим некоторые инструменты Gnome 3 без установки рекомендованых пакетов
apt-get install gnome-system-tools --no-install-recommends
# Скачиваем и устанавлимаем Skype
wget -O skype-install.deb http://www.skype.com/go/getskype-linux-deb
dpkg -i skype-install.deb
# Скачиваем и устанавливаем утилиту по настройке lightdm
wget -O lightdmcfg_0.1.1-2_all.deb http://goo.gl/LNN1zu
dpkg -i lightdmcfg_0.1.1-2_all.deb
# Удовлетворяем зависимости после Skype и lightdmcfg
apt-get -f install
# ----------------
# Не обязательный раздел - Работа напильником
# Перемещаем кнопки влево
dconf write /org/mate/marco/general/button-layout "'close,minimize,maximize:'"
# Сворочиваем/Разворачиваем все окна по комбинации клавишь <Win>+<d>
dconf write /org/mate/marco/global-keybindings/show-desktop "'<Mod4>d'"
# Запускаем терминал стандартной командой <Control>+<Alt>+<t> - по умолчанию ваще ничего не стоит
dconf write /org/mate/marco/global-keybindings/run-command-terminal "'<Control><Alt>t'"
# Разбираемся со шрифтами
dconf write /org/mate/interface/document-font-name "'Droid Sans 10'"
dconf write /org/mate/interface/font-name "'Droid Sans 10'"
dconf write /org/mate/interface/monospace-font-name "'Droid Sans Mono 10'"
dconf write /org/mate/marco/general/titlebar-font "'Droid Sans Bold 10'"
# Ставим свою тему окон
dconf write /org/mate/marco/general/theme "'BlueMenta'"
dconf write /org/mate/interface/gtk-theme "'BlueMenta'"
# Ставим свои иконки
dconf write /org/mate/interface/icon-theme "'matefaenza'"
# ----------------
echo "ПОЗДРАВЛЯЮ!"
echo "установка системы закончены"
echo "теперь необходимо выйти из сеанса root"
echo "командой exit"
echo "и перегрузить компьютер"
echo "можно даже c помощью Ctrl+Alt+Del"
