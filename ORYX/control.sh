#!/bin/bash

if [[ $1 =~ "stop" ]] ; then
  for filename in bin/oryxcoin-cli_*.sh; do
    sh $filename stop
  done
fi

if [[ $1 =~ "status" ]] ; then
  for filename in bin/oryxcoin-cli_*.sh; do
    sh $filename masternode status
  done
fi

if [[ $1 =~ "start" ]] ; then
  for filename in bin/oryxcoind_*.sh; do
    sh $filename
  done
fi