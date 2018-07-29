#!/bin/bash



echo "BEFORE YOU PROCEED MAKE SURE YOUR GUI WALLET (WIN/MAC) IS UPDATED ALREADY!"
echo "Enter 1 to update, enter 2 to check status (Press enter after) ONLY UPDATE ONCE!!!!!"
read UPDATE


if [[ $UPDATE =~ "1" ]] ; then
    echo "You have to go to your GUI Wallet now and restart ALL nodes on it! before you continue! Type yes to proceed"
    read OK
    if [[ $OK =~ "yes" ]]; then

      for filename in bin/bitcoingreen-cli_*.sh; do
        sh $filename stop
      done

      # update wallet
      wget https://github.com/bitcoingreen/bitcoingreen/releases/download/1.2.1/bitcoingreen-1.2.1-x86_64-linux-gnu.tar.gz
      tar -xzf bitcoingreen-1.2.1-x86_64-linux-gnu.tar.gz
      chmod 755 bitcoingreen-1.2.1/bin/*
      rm /usr/bin/bitcoingreen*
      mv bitcoingreen-1.2.1/bin/bitcoingreen* /usr/bin
      rm -r bitcoingreen-1.2.1

      rm .bitcoingreen_*/mn*

      echo "Wait for shutdowns..."
      sleep 60

      for filename in bin/bitcoingreend_*.sh; do
        sh $filename -resync
      done
      echo "Wait for blockchain to restart... (ca 3 mins)"

      sleep 180

      for filename in bin/bitcoingreen-cli_*.sh; do
        sh $filename masternode status
      done
      echo "Your nodes have been updated and restarted. Please wait 5 minutes and check the status if not active already!"
    else
      echo "SCRIPT WAS BROKEN BECAUSE YOU DID NOT READ OR TYPED yes ! Start again and follow instructions"
    fi
else
  for filename in bin/bitcoingreen-cli_*.sh; do
    sh $filename masternode status
  done
fi
