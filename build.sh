#!/bin/bash
cd /svxlink/src
mkdir -p build
cd build

cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_SYSCONFDIR=/etc \
      -DCMAKE_INSTALL_LOCALSTATEDIR=/var \
      -DCMAKE_BUILD_TYPE=Release -DUSE_QT=NO ..
make

groupadd svxlink
useradd -g daemon svxlink

checkinstall -D -y --pkgname svxlink --pkgversion $(date +%Y%m%d) --pkglicense GPLv3 \
             --addso --gzman $@
cp -v *.deb /package/
cp -v *.deb $DIR/out.deb
