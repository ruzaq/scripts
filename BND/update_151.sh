#!/bin/bash

wget https://github.com/blocknodetech/blocknode/releases/download/v1.5.1/blocknode-1.5.1-x86_64-linux-gnu.tar.gz
tar -xzf blocknode-1.5.1-x86_64-linux-gnu.tar.gz
chmod 755 blocknode-1.5.1/bin/*
rm bin/blocknode* /usr/bin/blocknode*
mv blocknode-1.5.1/bin/blocknode* /usr/bin
blocknode-cli stop
sleep 10
blocknoded
echo "Wait for blockchain to restart...."
sleep 30
blocknode-cli masternode status
echo "Please restart on gui if status is not 4!"
