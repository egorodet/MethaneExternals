
ECHO building OpenImageIO

SET current=%cd%

if not exist "prereq" ^
mkdir prereq
cd prereq

if not exist "oiio" ^
git clone https://github.com/OpenImageIO/oiio.git

cd oiio
git pull
REM following checkout is safe
REM git checkout 0b5df2944e0b772af88efa7180ff6e7c88804908
REM following checkout deadlocks
REM git checkout 7c0f2bed640ddc3ee324b703722517cd44dc953b
REM use the stable release branch
git checkout release
cd ..

if not exist "build\oiio" mkdir build\oiio
cd build\oiio

REM -DUSE_PTEX=0 because ptex was recently changed and doesn't work with several projects
cmake -G "Visual Studio 15 2017 Win64"^
    -DCMAKE_PREFIX_PATH="%current%\local"^
    -DCMAKE_INSTALL_PREFIX="%current%\local" ^
    -DCMAKE_CXX_COMPILER_WORKS:INT=1 ^
    -DOPENEXR_HOME="%current%\local" ^
    -DOPENEXR_CUSTOM_INCLUDE_DIR:STRING="%current%\local\include" ^
    -DOPENEXR_CUSTOM_LIB_DIR="%current%\local\lib" ^
    -DBOOST_ROOT="%current%\local" ^
    -DBOOST_INCLUDEDIR="%current%\local\include\boost" ^
    -DBOOST_LIBRARYDIR="%current%\local\lib" ^
    -DBoost_USE_MULTITHREADED:INT=1 ^
    -DBoost_COMPILER="-vc141" ^
    -DBoost_NO_SYSTEM_PATHS:INT=1 ^
    -DBoost_LIBRARY_DIR_RELEASE="%current%\local\lib" ^
    -DBoost_LIBRARY_DIR_DEBUG="%current%\local\lib" ^
    -DOCIO_PATH="%current%\local" ^
    -DPTEX_LOCATION="%current%\local" ^
    -DJPEGTURBO_PATH="%current%\local" ^
    -DUSE_JPEGTURBO:INT=1 ^
    -DUSE_PTEX:INT=1 ^
    -DUSE_PYTHON:INT=0 ^
    ..\..\oiio

rem -DBoost_DEBUG:INT=1 ^

cmake --build . --target install --config Release -- /maxcpucount:16
rem msbuild oiio.sln /t:Build /p:Configuration=Release /p:Platform=x64

cd %current%
