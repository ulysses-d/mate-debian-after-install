#!/bin/sh
cd $HOME
# Скрипт по установке среды Mate и дополнительного программного
# обеспечения в свежеустановленный Debian Jessie
# Создаем sources_after_mate.list и добавляем в него дополнительные репозитории
# Кодеки и прочая
echo 'deb http://www.deb-multimedia.org/ jessie main non-free'  >> /etc/apt/sources.list.d/sources_after_mate.list
# Здесь есть некоторые полезные утилиты, а также FireFox это репозиторий LMDE2
echo 'deb http://packages.linuxmint.com/ debian main upstream import'  >> /etc/apt/sources.list.d/sources_after_mate.list
# TLP Исключительно полезно для нетбуков и ноутбуков (в Stertch и Sid уже находится в основных репозиториях)
echo 'deb http://repo.linrunner.de/debian jessie main'  >> /etc/apt/sources.list.d/sources_after_mate.list
# На этом этапе еще неплохобы проверить оригинальный sources.list дописать в некоторых строчках non-free contrib но я вот пока неготов сказать как это правильно сделать, предлагаю вот такое решение (могут возникнуть дубликаты)
echo 'deb http://ftp.ru.debian.org/debian/ jessie non-free contrib'  >> /etc/apt/sources.list.d/sources_after_mate.list
echo 'deb http://security.debian.org/ jessie/updates contrib non-free'  >> /etc/apt/sources.list.d/sources_after_mate.list
echo 'deb http://ftp.ru.debian.org/debian/ jessie-updates contrib non-free'  >> /etc/apt/sources.list.d/sources_after_mate.list
echo 'deb http://ftp.ru.debian.org/debian/ jessie-backports contrib non-free'  >> /etc/apt/sources.list.d/sources_after_mate.list
# Обновляем кэш, в результате работы команды вылезет несколько
# строк с ошибками о том что нет доверительных ключей
apt-get update
# Копируем и устанавливаем ключи
apt-get -y install deb-multimedia-keyring linuxmint-keyring
apt-key adv --keyserver pool.sks-keyservers.net --recv-keys CD4E8809
# и опять обновим кэш 
apt-get update; apt-get upgrade
# Далее все разбито на отдельные команды, дабы было понимание что и зачем ставится, это можно все объеденить в одну команду
# Iceweasel + Flash
apt-get -y install flashplugin-nonfree
# Libre Office -  шрифты, внешний вид, тема значков
apt-get -y install ttf-mscorefonts-installer ttf-liberation libreoffice-style-sifr libreoffice-gtk libreoffice-gnome
# Mate Tools
apt-get -y install mate-system-tools caja-extensions-common caja-gksu caja-open-terminal caja-sendto dconf-editor dconf-tools mate-gnome-main-menu-applet mate-netbook mate-netspeed
# System Tools
apt-get -y install mc gksu unrar ntp gdebi bleachbit
# Устанавливаем TLP
apt-get -y install tlp tlp-rdw
# Launchpad PPA (позволяет их использовать)
apt-get -y install software-properties-common python-software-properties
# Устанавливаем строку быстрого поиска Synaptic и ускоряет поиск (на совсем слабых машинах лучше не устанавливать)
apt-get -y install synaptic apt-xapian-index
# Почтовик Geary (Здесь можно построить меню с возможностью выбора из нескольких вариантов)
apt-get -y install geary
# Видео и музыка (Здесь можно построить меню с возможностью выбора из нескольких вариантов)
apt-get -y install vlc rhythmbox
# Создание загрузочной флешки и ее форматирование (части от LMDE2)
apt-get -y install mintstick
# Скачиваем mate-menu и mate-tweak из репозиториев Streatch, они не зависят от архитектуры (если кто знает как скачать deb без привязки к номеру версии, за подсказку буду благодарен)
wget http://ftp.ru.debian.org/debian/pool/main/m/mate-menu/mate-menu_5.6.5a-1_all.deb
wget http://ftp.ru.debian.org/debian/pool/main/m/mate-tweak/mate-tweak_3.4.9-1_all.deb
# конфигурация внешнего вида программ Qt (не очень актуально, т.к. и VLC и Skype настраиваются нормально уже своими штатными средствами через выбор средства отображения GTK+)
apt-get -y install qt4-qtconfig
# Скачиваем Skype
wget -O skype-install.deb http://www.skype.com/go/getskype-linux-deb
# Устанавливаем скачанные пакеты и удовлетворяем зависимости
dpkg -i *.deb
apt-get -f install
# Удаляем ненужное (ИМХО)
apt-get purge gnome-orca
# Чистим после себя 
apt-get autoremove; apt-get clean; apt-get autoclean

