
ECHO building OpenEXR

echo zlib is a prerequisite for OpenEXR

SET current=%cd%

if not exist "prereq" ^
mkdir prereq
cd prereq

IF NOT EXIST "openexr\README" ^
git clone https://github.com/openexr/openexr.git

cd openexr
git pull
cd ..

if not exist "build\OpenEXR" mkdir build\OpenEXR
cd build\OpenEXR

cmake -G "Visual Studio 15 2017 Win64"^
      -DCMAKE_PREFIX_PATH="%current%\local"^
      -DCMAKE_INSTALL_PREFIX="%current%\local"^
      -DILMBASE_PACKAGE_PREFIX="%current%\local"^
      -DZLIB_ROOT="%current%\local"^
      -DOPENEXR_BUILD_PYTHON_LIBS=0^
      ..\..\openexr

cmake --build . --target install --config Release

rem msbuild openEXR.sln /t:Build /p:Configuration=Release /p:Platform=x64

cd %current%

copy .\local\lib\Iex-2_3.lib .\local\lib\Iex.lib
copy .\local\lib\IexMath-2_3.lib .\local\lib\IexMath.lib
copy .\local\lib\IlmImf-2_3.lib .\local\lib\IlmImf.lib
copy .\local\lib\IlmImfUtil-2_3.lib .\local\lib\IlmImfUtil.lib
copy .\local\lib\IlmThread-2_3.lib .\local\lib\IlmThread.lib
copy .\local\lib\Imath-2_3.lib .\local\lib\Imath.lib

rem xcopy .\prereq\build\IlmBase\config\*.* .\local\include\OpenEXR\ /s /y
rem xcopy .\prereq\openexr\IlmBase\Half*.h .\local\include\OpenEXR\ /s /y
rem xcopy .\prereq\openexr\IlmBase\Half\*.h .\local\include\OpenEXR\ /s /y
rem xcopy .\prereq\openexr\IlmBase\Iex\*.h .\local\include\OpenEXR\ /s /y
rem xcopy .\prereq\openexr\IlmBase\IexMath\*.h .\local\include\OpenEXR\ /s /y
rem xcopy .\prereq\openexr\IlmBase\IlmThread\*.h .\local\include\OpenEXR\ /s /y
rem xcopy .\prereq\openexr\IlmBase\Imath\*.h .\local\include\OpenEXR\ /s /y

rem xcopy .\prereq\build\OpenEXR\IlmBase\Half\Release\Half.* .\local\lib\ /s /y
rem xcopy .\prereq\build\OpenEXR\IlmBase\Iex\Release\Iex-2_3.* .\local\lib\ /s /y
rem xcopy .\prereq\build\OpenEXR\IlmBase\IexMath\Release\IexMath-2_3.* .\local\lib\ /s /y
rem xcopy .\prereq\build\OpenEXR\IlmBase\IlmThread\Release\IlmThread-2_3.* .\local\lib\ /s /y
rem xcopy .\prereq\build\OpenEXR\IlmBase\Imath\Release\Imath-2_3.* .\local\lib\ /s /y

rem xcopy .\prereq\build\OpenEXR\OpenEXR\IlmImf\Release\IlmImf*.lib .\local\lib\ /s /y
rem xcopy .\prereq\build\OpenEXR\OpenEXR\IlmImf\Release\IlmImf*.dll .\local\bin\ /s /y
rem xcopy .\prereq\build\OpenEXR\exrenvmap\Release\*.exe .\local\bin\ /s /y
rem xcopy .\prereq\build\OpenEXR\exrheader\Release\*.exe .\local\bin\ /s /y
rem xcopy .\prereq\build\OpenEXR\exrmakepreview\Release\*.exe .\local\bin\ /s /y
rem xcopy .\prereq\build\OpenEXR\exrmultipart\Release\*.exe .\local\bin\ /s /y
rem xcopy .\prereq\build\OpenEXR\exrmultiview\Release\*.exe .\local\bin\ /s /y
rem xcopy .\prereq\build\OpenEXR\exrstdattr\Release\*.exe .\local\bin\ /s /y
