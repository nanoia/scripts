#!/bin/bash
#
# My seedbox Installer @DDQ

#install flexget
sudo apt-get install python-pip
sudo pip install --upgrade setuptools
sudo pip install flexget
#warning process
sudo python -m easy_install --upgrade pyOpenSSL
sudo pip install --upgrade cryptography

mkdir .flexget && cd .flexget && touch config.yml

#install qBittorrent
sudo add-apt-repository ppa:qbittorrent-team/qbittorrent-stable
sudo apt-get update && sudo apt-get install qbittorrent-nox

cat > /etc/systemd/system/qbittorrent.service<<-EOF
[Unit]
Description=qBittorrent Daemon Service
After=network.target

[Service]
User=root
ExecStart=/usr/bin/qbittorrent-nox
ExecStop=/usr/bin/killall -w qbittorrent-nox

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
systemctl start qbittorrent
sudo systemctl enable qbittorrent

#install Deluge

#install transmission
sudo apt-get install transmission-daemon
sudo service transmission-daemon stop
wget https://github.com/ronggang/transmission-web-control/raw/master/release/install-tr-control-cn.sh && bash install-tr-control-cn.sh
