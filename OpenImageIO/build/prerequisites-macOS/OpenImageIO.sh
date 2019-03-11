#!/bin/bash

echo building release branch of OpenImageIO

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

if [ ! -f oiio/.git/config ]; then
  git clone git://github.com/OpenImageIO/oiio.git
fi
if [ ! -f oiio-images/.git/config ]; then
  git clone git://github.com/OpenImageIO/oiio-images.git
fi
if [ ! -f bmpsuite.zip ]; then
  curl -L -o bmpsuite.zip http://entropymine.com/jason/bmpsuite/bmpsuite.zip
fi
if [ ! -f bmpsuite/readme.txt ]; then
  tar -zxf bmpsuite.zip -C bmpsuite
fi
if [ ! -f fits-images/README.html ]; then
  curl -L -o fits-images https://www.cv.nrao.edu/fits/data/tests/
fi

cd oiio
git pull
git checkout release
cd ..

mkdir -p build/oiio
cd build/oiio

cmake \
  -DCMAKE_PREFIX_PATH="${LOCAL}" \
  -DCMAKE_INSTALL_PREFIX="${LOCAL}" \
  -DCMAKE_INSTALL_NAME_DIR=@rpath \
  -DCMAKE_INSTALL_RPATH_USE_LINK_PATH:BOOL=ON \
  -DCMAKE_CXX_COMPILER_WORKS=1 \
  -DCMAKE_CXX_FLAGS="-Wno-deprecated-declarations" \
  -DOPENEXR_CUSTOM_INCLUDE_DIR:STRING="${LOCAL}/include" \
  -DOPENEXR_CUSTOM_LIB_DIR="${LOCAL}/lib" \
  -DBoost_USE_STATIC_LIBS:INT=0 \
  -DBOOST_ROOT="${LOCAL}" \
  -DBOOST_LIBRARYDIR="${LOCAL}/lib" \
  -DBoost_LIBRARY_DIR="${LOCAL}/lib" \
  -DBoost_LIBRARY_DIR_RELEASE="${LOCAL}/lib" \
  -DBoost_LIBRARY_DIR_DEBUG="${LOCAL}/lib" \
  -DBoost_INCLUDE_DIR="${LOCAL}/include" \
  -DOCIO_PATH="%current%\local" \
  -DPTEX_LOCATION="${LOCAL}" \
  -DJPEGTURBO_PATH="${LOCAL}" \
  -DUSE_JPEGTURBO:INT=1 \
  -DUSE_PTEX:INT=1 \
  -DUSE_PYTHON:INT=0 \
  ../../oiio

cmake --build . --target install --config Release

cd ${ROOT}

