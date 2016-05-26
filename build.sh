#!/bin/bash
cd /

if ([ -n "$1" ] && echo "$1" |egrep -q https?://)
then
    git clone "$1" svxlink || exit 1
    shift 
fi

test -d /builds/hsmade/svxlink && DIR=/builds/hsmade/svxlink || DIR=/svxlink
if (! test -d $DIR/src)
then
  echo Either mount the source as /svxlink or give me a GIT url 
  exit 1
fi

mkdir build
cd build

cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_SYSCONFDIR=/etc \
      -DCMAKE_INSTALL_LOCALSTATEDIR=/var \
      -DCMAKE_BUILD_TYPE=Release $DIR/src
make

useradd -g daemon svxlink

checkinstall -D -y --pkgname svxlink --pkgversion $(date +%Y%m%d) --pkglicense GPLv3 \
             --addso --gzman $@
mv -v *.deb /package/
cp /package/*.deb /package/out.deb
