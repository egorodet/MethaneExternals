# Methane Externals

> **Warning**
> This is an **archived repository**, which was previously used for external dependencies of [Methane Kit](https://github.com/MethanePowered/MethaneKit) project in form of submodules, currently migrated to [CPM.cmake](https://github.com/cpm-cmake/CPM.cmake).

[Methane Kit](https://github.com/egorodet/MethaneKit) external libraries and tools in form of:
- :blue_book: static library sources in Git submodule
- :green_book: header-only library in Git submodule
- :orange_book: static library sources copy
- :closed_book: pre-built dynamic library binaries
- :scroll: small static or header-only library sources copy
- :hammer: build tool binaries

## CMake Modules
- :green_book: [CMRC](https://github.com/vector-of-bool/cmrc) - resource compiler in a single CMake script
- :green_book: [CMakeModules](https://github.com/rpavlik/cmake-modules) - RPavlik collection of CMake modules
- :scroll: [CMakeExtraModules](https://github.com/bilke/cmake-modules/) - additional CMake modules

## Shader Build Tools & Libraries
- :hammer: [SPIRV-Cross](https://github.com/KhronosGroup/SPIRV-Cross) - tool binary for performing reflection on SPIR-V from bytecode to Metal shaders (prebuilt executable)
- :hammer: [DirectXCompiler](https://github.com/microsoft/DirectXShaderCompiler) - cross-platform DirectX Shader Compiler to convert HLSL to DXIL on Windows and HLSL to SPIRV on MacOS (prebuilt command line executables and libraries)
- :scroll: [D3DCompilerToDXC](https://github.com/microsoft/DirectXShaderCompiler/blob/master/tools/clang/tools/d3dcomp/) - static library from DirectXShaderCompiler providing functions to bridge from d3dcompiler_47 to dxcompiler

## Math Libraries

- :green_book: [HLSL++](https://github.com/redorav/hlslpp) - math library using HLSL syntax with SSE/NEON support
- :orange_book: [PerlinNoise](http://staffwww.itn.liu.se/~stegu/aqsis/aqsis-newnoise/) - improved Perlin Noise implementation by Stefan Gustavson

## Parallel Execution

- :green_book: [TaskFlow](https://github.com/taskflow/taskflow) - modern C++ parallel task programming library

## Common Utilities

- :blue_book: [BoostNowide](https://github.com/boostorg/nowide) - standard library functions with UTF-8 API on Windows (does not require Boost dependency)
- :blue_book: [FMT](https://github.com/fmtlib/fmt) - modern string formatting library
- :green_book: [MagicEnum](https://github.com/Neargye/magic_enum) - static reflection for enums for modern C++
- :green_book: [CLI11](https://github.com/CLIUtils/CLI11) - header only command line parser for C++11 and beyond
  
## Resources Loading Libraries

- :blue_book: [FreeType2](https://www.freetype.org/) - software library to render fonts
- :green_book: [STB](https://github.com/nothings/stb) - stb_image header is used for loading JPEG images to textures
- :closed_book: [OpenImageIO](https://github.com/OpenImageIO/oiio) - additional library used for loading of wide range of image formats via native loaders (optional dependency)
  - :scroll: [USD Build Club](https://github.com/vfxpro99/usd-build-club) - was used for [Open Image IO build scripts](OpenImageIO/build) with some modifications

## DirectX Libraries

- :scroll: [DirectXLibs/D3DX12](https://github.com/Microsoft/DirectX-Graphics-Samples/tree/master/Libraries/D3DX12) - DirectX 12 helpers library
- :blue_book: [DirectXTex](https://github.com/microsoft/DirectXTex) - DirectX texture processing library

## Vulkan Libraries

- :green_book: [Vulkan-Headers](https://github.com/KhronosGroup/Vulkan-Headers) - Vulkan Header files and API registry
- :blue_book: [SPIRV-Cross](https://github.com/KhronosGroup/SPIRV-Cross) - tool and library for performing reflection on SPIR-V and disassembling SPIR-V back to high level languages.

## Testing, Profiling and Instrumentation

- :green_book: [Catch2](https://github.com/catchorg/Catch2) - header only unit-testing framework
- :green_book: [IttApi](https://github.com/intel/ittapi) - Intel Instrumentation and Tracing Technology (ITT) and Just-In-Time (JIT) API
- :blue_book: [Tracy](https://github.com/wolfpld/tracy) - Tracy realtime frame profiler
- :hammer: [Tools/OpenCppCoverage](https://github.com/OpenCppCoverage/OpenCppCoverage) - open source code coverage tool for C++ under Windows (binaries archive)

