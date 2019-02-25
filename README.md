# scripts
### [BBR](https://github.com/FunctionClub/YankeeBBR)
    wget -N --no-check-certificate https://raw.githubusercontent.com/nanoia/scripts/master/bbr.sh && bash bbr.sh install
    
Run 

    bash bbr.sh start
    
BBR state

    sysctl net.ipv4.tcp_available_congestion_control
    
### seedbox installer
    wget -N --no-check-certificate https://raw.githubusercontent.com/nanoia/scripts/master/installer.sh && bash installer.sh
    
### install deluge [1](https://ymgblog.com/2017/09/21/106/) | [2](https://ymgblog.com/2017/09/21/106/)
    wget -q --no-check-certificate https://raw.githubusercontent.com/nanoia/scripts/master/install-deluge.sh -O install-deluge.sh && chmod +x install-deluge.sh && ./install-deluge.sh -install

install

    ./install-deluge.sh -install

uninstall

    ./install-deluge.sh -uninstall

control

    /etc/init.d/deluged start
    /etc/init.d/deluged stop
    /etc/init.d/deluged restart    

### [install rtorrent](https://ymgblog.com/2017/09/27/170/)
    sudo bash -c "$(wget --no-check-certificate -qO - https://raw.githubusercontent.com/nanoia/scripts/master/rtsetup)"
    rtinst -t -d
   
### install rssbot   
    wget -q --no-check-certificate https://raw.githubusercontent.com/nanoia/scripts/master/rssbot.sh -O rssbot.sh && chmod +x rssbot.sh && ./rssbot.sh

### 测速脚本
    wget -qO- bench.sh | bash
