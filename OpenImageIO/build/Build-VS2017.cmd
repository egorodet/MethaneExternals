REM ensure a 64 bit development environment using VS2017
IF NOT "%VisualStudioVersion%"=="15.0" call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvars64.bat"

call .\prerequisites-vc150-x64\zlib.cmd
call .\prerequisites-vc150-x64\jpeg.cmd
call .\prerequisites-vc150-x64\png.cmd
call .\prerequisites-vc150-x64\tiff.cmd
call .\prerequisites-vc150-x64\boost_vs2017_5.cmd
call .\prerequisites-vc150-x64\tbb.cmd
call .\prerequisites-vc150-x64\glew.cmd
call .\prerequisites-vc150-x64\glext.cmd
call .\prerequisites-vc150-x64\openexr.cmd
call .\prerequisites-vc150-x64\ptex.cmd
call .\prerequisites-vc150-x64\OpenSubdiv.cmd
call .\prerequisites-vc150-x64\OpenImageIO.cmd
