
ECHO building ptex
SET current=%cd%

if not exist "prereq" ^
mkdir prereq

cd prereq

if not exist "ptex\CMakeLists.txt" ^
git clone https://github.com/wdas/ptex.git

cd ptex
git pull
cd ..

if not exist "build\ptex" ^
mkdir build\ptex

cd build\ptex

cmake -G "Visual Studio 15 2017 Win64"^
      -DCMAKE_PREFIX_PATH="%current%\local"^
      -DCMAKE_INSTALL_PREFIX="%current%\local"^
      ..\..\ptex

cmake --build . --target install --config Release -- /maxcpucount:8

copy ptex.* ..\..\..\local\lib\
copy ptex.dll ..\..\..\local\dll\
cd ..\..\..

copy prereq\ptex\src\ptex\PtexHalf.h local\include\PtexHalf.h
copy prereq\ptex\src\ptex\PtexInt.h local\include\PtexInt.h
copy prereq\ptex\src\ptex\Ptexture.h local\include\Ptexture.h
copy prereq\ptex\src\ptex\PtexUtils.h local\include\PtexUtils.h
copy prereq\ptex\src\ptex\PtexVersion.h local\include\PtexVersion.h

