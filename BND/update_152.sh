#!/bin/bash

wget https://github.com/blocknodetech/blocknode/releases/download/v1.5.2/blocknode-1.5.2-x86_64-linux-gnu.tar.gz
tar -xzf blocknode-1.5.2-x86_64-linux-gnu.tar.gz
chmod 755 blocknode-1.5.2/bin/*
rm bin/blocknode* /usr/bin/blocknode*
mv blocknode-1.5.2/bin/blocknode* /usr/bin
rm -r blocknode-1.5.2*
blocknode-cli stop
sleep 10
cd .blocknode
rm -r backups/ banlist.dat blocks/ budget.dat chainstate/ db.log debug.log fee_estimates.dat masternode.conf mncache.dat mnpayments.dat sporks/ zerocoin/
blocknoded
echo "Wait for blockchain to restart...."
sleep 60
blocknode-cli masternode status
echo "Please restart on gui if status is not 4!"
