#!/bin/bash

echo building tiff

ROOT=$(pwd)
LOCAL=${ROOT}/local

if [ $# -ge 1 ]; then
  LOCAL=$1
fi

mkdir -p prereq
mkdir -p $LOCAL/lib
mkdir -p $LOCAL/bin
mkdir -p $LOCAL/include

cd prereq

if [ ! -f libtiffpic.tar.gz ]; then
  curl -L -o libtiffpic.tar.gz https://download.osgeo.org/libtiff/pics-3.8.0.tar.gz
fi

if [ ! -f libtiffpic/README ]; then
  tar -zxf libtiffpic.tar.gz
fi

if [ ! -f local/lib/libtiff.a ]; then

  if [ ! -f libtiff/.git/config ]; then
    git clone https://github.com/vadz/libtiff
  fi

  cd libtiff
  git pull

  ./configure --disable-dependency-tracking --prefix=${LOCAL} --enable-cxx=0
  make -j 4
  make install

  install_name_tool -id @rpath/libtiff.5.dylib $LOCAL/lib/libtiff.5.dylib

fi

cd ${ROOT}