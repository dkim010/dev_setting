#!/bin/bash

# yum install expat-devel
# yum install pcre-devel


# exit on error
set -e

mkdir -p $HOME/opt
cd $HOME/opt

VERSION=2.4.38
TARGET=httpd-$VERSION
DST=$HOME/opt/$TARGET-bin
APR_VERSION=1.6.5
APR_UTIL_VERSION=1.6.1

function download(){
    curl -LO http://mirror.navercorp.com/apache//httpd/${TARGET}.tar.bz2
    curl -LO http://mirror.navercorp.com/apache/apr/apr-${APR_VERSION}.tar.gz
    curl -LO http://mirror.navercorp.com/apache/apr/apr-util-${APR_UTIL_VERSION}.tar.gz
}

function install(){
    rm -rf ${TARGET}
    tar xf ${TARGET}.tar.bz2
    # install apr
    tar xf apr-${APR_VERSION}.tar.gz
    mv apr-${APR_VERSION} $TARGET/srclib/apr
    # install apr-util
    tar xf apr-util-${APR_UTIL_VERSION}.tar.gz
    mv apr-util-${APR_UTIL_VERSION} $TARGET/srclib/apr-util

    cd $TARGET
    ./configure \
        --with-included-apr \
        --prefix=$DST
    make -j8
    make install
}

download
install

# Configuration
cd $DST/conf
sed -e "s/User daemon/User $LOGIN/" \
    -e "s/Group daemon/Group $LOGIN/" \
    -e "s/Listen 80/Listen 8080/" \
    original/httpd.conf > httpd.conf

echo "------------------- $DST/bin/apachectl is now available.-----------------"
echo "Insert the httpd-bin dirs to PATH."
echo "example)"
echo "export PATH=$DST/bin:\$PATH"
echo "------------------- Configuration -----------------"
echo 'You can change the belows'
echo '* DocumentRoot ...'
echo '* Directory <...>'
