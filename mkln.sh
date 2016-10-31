#!/bin/bash
#################################################
#### author: Dongwon Kim <dkim010@gmail.com>
#### created at 2016.05.01
#################################################

USER_HOME=~/.
USER_HOME=~/users/dwkim

### conf files
FILES='.vimrc .tmux.conf .gitconfig'
for f in $FILES; do
    ln -s $PWD/$f $USER_HOME/$f
done

### scripts
mkdir -p $USER_HOME/bin
FILES='gfind nfind xfind ofind atx uenv adb_conn'
for f in $FILES; do
    ln -s $PWD/bin/$f $USER_HOME/bin/$f
done
