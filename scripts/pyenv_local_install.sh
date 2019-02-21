#!/bin/bash
# exit on error
set -e

PYENV=https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer
curl -L $PYENV | bash

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

if [[ $OSTYPE == *'darwin'* ]]; then
    CFLAGS="-I$(brew --prefix readline)/include -I$(brew --prefix openssl)/include -I$(xcrun --show-sdk-path)/usr/include" \
        LDFLAGS="-L$(brew --prefix readline)/lib -L$(brew --prefix openssl)/lib" \
        CONFIGURE_OPTS=--enable-shared pyenv install 3.7.1
else
    # sudo yum install openssl-devel readline-devel zlib-devel libffi-devel libsasl2-devel openldap-devel sqlite-devel bzip2-devel -y
    CONFIGURE_OPTS=--enable-shared pyenv install 3.7.1
fi
