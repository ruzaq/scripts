#/bin/bash

cd ~
echo "****************************************************************************"
echo "* Ubuntu 16.04 is the recommended opearting system for this install.       *"
echo "*                                                                          *"
echo "* This script will install and configure your Omega Coin masternodes.      *"
echo "****************************************************************************"
echo && echo && echo
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "!                                                 !"
echo "! Make sure you double check before hitting enter !"
echo "!                                                 !"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo && echo && echo

echo "Do you want to install all needed dependencies (no if you did it before)? [y/n]"
read DOSETUP

if [[ $DOSETUP =~ "y" ]] ; then
  sudo apt-get update
  sudo apt-get -y upgrade
  sudo apt-get -y dist-upgrade
  sudo apt-get install -y nano htop git
  sudo apt-get install -y software-properties-common
  sudo apt-get install -y build-essential libtool autotools-dev pkg-config libssl-dev
  sudo apt-get install -y libboost-all-dev
  sudo apt-get install -y libevent-dev
  sudo apt-get install -y libminiupnpc-dev
  sudo apt-get install -y autoconf
  sudo apt-get install -y automake unzip
  sudo add-apt-repository  -y  ppa:bitcoin/bitcoin
  sudo apt-get update
  sudo apt-get install -y libdb4.8-dev libdb4.8++-dev

  cd /var
  sudo touch swap.img
  sudo chmod 600 swap.img
  sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=2000
  sudo mkswap /var/swap.img
  sudo swapon /var/swap.img
  sudo free
  sudo echo "/var/swap.img none swap sw 0 0" >> /etc/fstab
  cd

  wget https://github.com/omegacoinnetwork/omegacoin/releases/download/0.12.5/omegacoincore-0.12.5-linux64.tar.gz
  tar -xzf *.tar.gz
  sudo mv  omegacoincore*/bin/* /usr/bin

  sudo apt-get install -y ufw
  sudo ufw allow ssh/tcp
  sudo ufw limit ssh/tcp
  sudo ufw logging on
  sudo ufw enable
  sudo ufw status

  mkdir -p ~/bin
  echo 'export PATH=~/bin:$PATH' > ~/.bash_aliases
  source ~/.bashrc
fi

## Setup conf
mkdir -p ~/bin
echo ""
echo "Configure your masternodes now!"
echo "Type the IP of this server, followed by [ENTER]:"
read IP

echo ""
echo "Enter masternode private key for node $ALIAS"
read PRIVKEY

CONF_DIR=~/.Omega
PORT=7777

mkdir -p $CONF_DIR
echo "rpcuser=longrando312musername" >> $CONF_DIR/omega.conf
echo "rpcpassword=longerdarandompassword" >> $CONF_DIR/omega.conf
echo "rpcallowip=127.0.0.1" >> $CONF_DIR/omega.conf
echo "rpcport=$RPCPORT" >> $CONF_DIR/omega.conf
echo "listen=1" >> $CONF_DIR/omega.conf
echo "server=1" >> $CONF_DIR/omega.conf
echo "daemon=1" >> $CONF_DIR/omega.conf
echo "logtimestamps=1" >> $CONF_DIR/omega.conf
echo "maxconnections=256" >> $CONF_DIR/omega.conf
echo "masternode=1" >> $CONF_DIR/omega.conf
echo "" >> $CONF_DIR/omega.conf

echo "addnode=142.208.127.121" >> $CONF_DIR/omega.conf
echo "addnode==154.208.127.121" >> $CONF_DIR/omega.conf
echo "addnode=142.208.122.127" >> $CONF_DIR/omega.conf

echo "" >> $CONF_DIR/omega.conf
echo "port=$PORT" >> $CONF_DIR/omega.conf
echo "masternodeaddress=$IP:$PORT" >> $CONF_DIR/omega.conf
echo "masternodeprivkey=$PRIVKEY" >> $CONF_DIR/omega.conf
sudo ufw allow $PORT/tcp

omegacoind