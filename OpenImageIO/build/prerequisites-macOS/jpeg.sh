#!/bin/bash

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

if [ ! -f J2KP4files.zip ]; then
  curl -L -o J2KP4files.zip ftp://ftp3.itu.int/t/testsignal/SpeImage/T803/v2002_11/J2KP4files.zip
fi

if [ ! -f j2kp4files_v1_5/README ]; then
  tar -zxf libtiffpic.zip
  mv J2KP4files j2kp4files_v1_5
fi

if [ ! -f $LOCAL/lib/libjpeg.a ]; then
  if [ ! -f jpeg.tgz ]; then
    curl http://www.ijg.org/files/jpegsrc.v8d.tar.gz > jpeg.tgz
  fi
  if [ ! -f jpeg-8d/README ]; then
    tar -xf jpeg.tgz
  fi
  cd jpeg-8d
  ./configure --disable-dependency-tracking --prefix=${LOCAL}
  make install

  echo "Adjusting JPEG library install name"
  install_name_tool -id "@rpath/libjpeg.8.dylib" $LOCAL/lib/libjpeg.8.dylib

fi

cd ${ROOT}