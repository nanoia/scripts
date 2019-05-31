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
