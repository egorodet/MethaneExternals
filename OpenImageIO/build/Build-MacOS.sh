#!/bin/bash

PREREQ_SCRIPTDIR=`dirname $0`

ROOT=$(pwd)
LOCAL=${ROOT}/local

if [ $# -ge 1 ]; then
  LOCAL=$1
fi

source ${PREREQ_SCRIPTDIR}/prerequisites-macOS/jinja2.sh $LOCAL

echo --- boost ---
source ${PREREQ_SCRIPTDIR}/prerequisites-macOS/boost.sh $LOCAL

# $? is the result of the most recent command
rc=$?
if [ $rc -ne 0 ]; then
  exit $rc
fi

echo --- double-conversion ---
source ${PREREQ_SCRIPTDIR}/prerequisites-macOS/double-conversion.sh $LOCAL
rc=$?
if [ $rc -ne 0 ]; then
  exit $rc
fi

echo --- glew ---
source ${PREREQ_SCRIPTDIR}/prerequisites-macOS/glew.sh $LOCAL
rc=$?
if [ $rc -ne 0 ]; then
  exit $rc
fi

echo --- glfw ---
source ${PREREQ_SCRIPTDIR}/prerequisites-macOS/glfw.sh $LOCAL
rc=$?
if [ $rc -ne 0 ]; then
  exit $rc
fi

echo --- OpenEXR ---
source ${PREREQ_SCRIPTDIR}/prerequisites-macOS/OpenEXR.sh $LOCAL
rc=$?
if [ $rc -ne 0 ]; then
  echo OpenEXR build did not finish with a clean exit code, stopping
  exit $rc
fi

echo --- tbb ---
source ${PREREQ_SCRIPTDIR}/prerequisites-macOS/tbb.sh $LOCAL
rc=$?
if [ $rc -ne 0 ]; then
  exit $rc
fi

echo --- OpenSubdiv ---
source ${PREREQ_SCRIPTDIR}/prerequisites-macOS/OpenSubdiv.sh $LOCAL
rc=$?
if [ $rc -ne 0 ]; then
  exit $rc
fi

echo --- jpeg ---
source ${PREREQ_SCRIPTDIR}/prerequisites-macOS/jpeg.sh $LOCAL
rc=$?
if [ $rc -ne 0 ]; then
  echo jpeg build did not finish with a clean exit code, continuing nonetheless
fi

echo --- jpeg-turbo ---
source ${PREREQ_SCRIPTDIR}/prerequisites-macOS/jpeg-turbo.sh $LOCAL
rc=$?
if [ $rc -ne 0 ]; then
  echo jpeg-turbo build did not finish with a clean exit code, continuing nonetheless
fi

echo --- png ---
source ${PREREQ_SCRIPTDIR}/prerequisites-macOS/png.sh $LOCAL
rc=$?
if [ $rc -ne 0 ]; then
  echo png build did not finish with a clean exit code, continuing nonetheless
fi

echo --- ptex ---
source ${PREREQ_SCRIPTDIR}/prerequisites-macOS/ptex.sh $LOCAL
rc=$?
if [ $rc -ne 0 ]; then
  exit $rc
fi

echo --- tiff ---
source ${PREREQ_SCRIPTDIR}/prerequisites-macOS/tiff.sh $LOCAL
rc=$?
if [ $rc -ne 0 ]; then
  echo tiff build did not finish with a clean exit code, continuing nonetheless
fi

echo --- hdf5 ---
source ${PREREQ_SCRIPTDIR}/prerequisites-macOS/hdf5.sh $LOCAL
rc=$?
if [ $rc -ne 0 ]; then
  echo HDF5 build did not finish with a clean exit code, continuing nonetheless
fi

echo --- OpenImageIO ---
source ${PREREQ_SCRIPTDIR}/prerequisites-macOS/OpenImageIO.sh $LOCAL
rc=$?
if [ $rc -ne 0 ]; then
  echo OpenImageIO build did not finish with a clean exit code, continuing nonetheless
fi
