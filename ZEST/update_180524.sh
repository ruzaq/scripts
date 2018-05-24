#!/bin/bash

echo "Enter 1 to update, enter 2 to check status (Press enter after) ONLY UPDATE ONCE!!!!!"
read UPDATE

if [[ $DOSETUP =~ "1" ]] ; then

  for filename in bin/zest-cli_*.sh; do
    sh $filename stop
  done

  # update wallet
  rm zest-*.tar.gz
  wget https://github.com/ZestFoundation/ZestCoin/releases/download/v1.0.0/zest-1.0.0-x86_64-linux-gnu.tar.gz
  tar -xzf zest-*
  sudo chmod 755 zest*/bin/zest*
  sudo mv zest*/bin/zest* /usr/bin

  for filename in bin/zestd_*.sh; do
    sh $filename -reindex
  done

  echo "Your nodes have been updated and restarted. Please wait 5 minutes and check the status!"

else
  for filename in bin/zest-cli_*.sh; do
    sh $filename masternode status
  done
fi