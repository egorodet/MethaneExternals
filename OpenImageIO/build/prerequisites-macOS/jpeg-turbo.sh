#!/bin/bash

echo building JPEG Turbo

ROOT=$(pwd)
LOCAL=${ROOT}/local

if [ $# -ge 1 ]; then
  LOCAL=$1
fi

mkdir -p prereq
mkdir -p $LOCAL/lib
mkdir -p $LOCAL/bin
mkdir -p $LOCAL/include

CONFIGURATION="Release"

cd prereq
if [ ! -f libjpeg-turbo/.git/config ]; then
  git clone https://github.com/libjpeg-turbo/libjpeg-turbo.git
else
  cd libjpeg-turbo; git pull; cd ..
fi

# checkout last known good on OSX

cd libjpeg-turbo
git checkout 830608b
cd ..

mkdir -p build/jpeg-turbo; cd build/jpeg-turbo
cmake \
      -DCMAKE_PREFIX_PATH="${LOCAL}" \
      -DCMAKE_INSTALL_PREFIX="${LOCAL}" \
      -DWITH_JPEG8=1 \
      ../../libjpeg-turbo

cmake --build . --target install --config Release

echo "Adjusting JPEG library install name"
install_name_tool -id "@rpath/libjpeg.8.dylib" $LOCAL/lib/libjpeg.8.dylib

cd ${ROOT}
