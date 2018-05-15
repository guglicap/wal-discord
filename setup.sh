#!/bin/sh
mkdir -p $HOME/.config/wal-discord
cp *.scss $HOME/.config/wal-discord
ln -sf $HOME/.config/wal-discord/master-wal.scss $HOME/.config/wal-discord/master.scss
