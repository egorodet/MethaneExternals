cmake_minimum_required(VERSION 3.11.0)

list(APPEND CMAKE_MODULE_PATH
    "${CMAKE_CURRENT_SOURCE_DIR}/CMakeModules"
    "${CMAKE_CURRENT_SOURCE_DIR}/CMRC"
)

# Common libraries
add_subdirectory(FMT)
add_subdirectory(Catch2)
add_subdirectory(SPIRV)
add_subdirectory(DirectXCompiler)
add_subdirectory(D3DCompilerToDXC)
add_subdirectory(PerlinNoise)
add_subdirectory(CLI11)
add_subdirectory(IttApi)
add_subdirectory(MagicEnum)

# FreeType library
include(FindPkgConfig)
set(FT_DISABLE_ZLIB ON CACHE BOOL "Disable Freetype ZLib support")
set(FT_DISABLE_BZIP2 ON CACHE BOOL "Disable Freetype BZip2 support")
set(FT_DISABLE_PNG ON CACHE BOOL "Disable Freetype PNG support")
set(FT_DISABLE_HARFBUZZ ON CACHE BOOL "Disable Freetype HarfBuzz support")
set(FT_DISABLE_BROTLI ON CACHE BOOL "Disable Freetype Brotli support")
add_subdirectory(FreeType2)

if(MSVC)
    target_compile_options(freetype PRIVATE /wd4267 /wd4244 /wd4018 /wd4312)
else()
    target_compile_options(freetype PRIVATE -Wno-everything)
endif()

# Nowide library
set(BUILD_SHARED_LIBS OFF CACHE BOOL "Disable BoostNowide shared libs")
set(BUILD_TESTING OFF CACHE BOOL "Disable BoostNowide tests")
set(NOWIDE_INSTALL OFF CACHE BOOL "Disable nowide library installation")
add_subdirectory(BoostNowide)

# TaskFlow library
set(TF_BUILD_BENCHMARKS OFF CACHE BOOL "Disable TaskFlow benchmarks build")
set(TF_BUILD_CUDA       OFF CACHE BOOL "Disable TaskFlow CUDA support")
set(TF_BUILD_TESTS      OFF CACHE BOOL "Disable TaskFlow tests build")
set(TF_BUILD_EXAMPLES   OFF CACHE BOOL "Disable TaskFlow examples build")
add_subdirectory(TaskFlow)
add_library(TaskFlow ALIAS Taskflow)
if(MSVC)
    target_compile_options(Taskflow INTERFACE
        /wd4456 # declaration of 'lock' hides previous local declaration (taskflow/core/executor.hpp:1842)
    )
endif()

# Image loader library: STB or OIIO
if (METHANE_OPEN_IMAGE_IO_ENABLED)
    add_subdirectory(OpenImageIO)
else()
    add_subdirectory(STB)
endif()

# Vulkan graphics API specific libraries
if (METHANE_GFX_API EQUAL METHANE_GFX_VULKAN)
    # Vulkan Headers library
    add_subdirectory(Vulkan-Headers)

    # SPIRV-Cross library
    set(SPIRV_CROSS_STATIC         ON  CACHE BOOL "Build the C and C++ API as static libraries.")
    set(SPIRV_CROSS_SHARED         OFF CACHE BOOL "Build the C API as a single shared library.")
    set(SPIRV_CROSS_CLI            OFF CACHE BOOL "Build the CLI binary. Requires SPIRV_CROSS_STATIC.")
    set(SPIRV_CROSS_ENABLE_TESTS   OFF CACHE BOOL "Enable SPIRV-Cross tests.")
    set(SPIRV_CROSS_ENABLE_HLSL    ON  CACHE BOOL "Enable HLSL target support.")
    set(SPIRV_CROSS_ENABLE_GLSL    ON  CACHE BOOL "Enable GLSL support.") # required for HLSL support
    set(SPIRV_CROSS_ENABLE_MSL     OFF CACHE BOOL "Enable MSL target support.")
    set(SPIRV_CROSS_ENABLE_CPP     OFF CACHE BOOL "Enable C++ target support.")
    set(SPIRV_CROSS_ENABLE_REFLECT OFF CACHE BOOL "Enable JSON reflection target support.")
    set(SPIRV_CROSS_ENABLE_C_API   OFF CACHE BOOL "Enable C API wrapper support in static library.")
    set(SPIRV_CROSS_ENABLE_UTIL    OFF CACHE BOOL "Enable util module support.")
    add_subdirectory(SPIRV-Cross)

    set_target_properties(spirv-cross-core spirv-cross-hlsl spirv-cross-glsl uninstall
        PROPERTIES
        FOLDER Externals
    )
endif()

# DirectX graphics API dependent libraries
if (METHANE_GFX_API EQUAL METHANE_GFX_DIRECTX)
    add_subdirectory(DirectXLibs/D3DX12)

    # DirectXTex library
    set(DIRECTXTEX_BUILD_TOOLS        OFF CACHE BOOL "Disable DirectXTex tools build")
    set(DIRECTXTEX_STANDALONE_ENABLED OFF CACHE BOOL "Disable DirectXTex standalone build")
    set(BUILD_DX11                    OFF CACHE BOOL "Disable DirectXTex DirectX11 Runtime support")
    set(BUILD_DX12                    ON  CACHE BOOL "Enabled DirectXTex DirectX12 Runtime support")
    add_subdirectory(DirectXTex)
    set_target_properties(DirectXTex
        PROPERTIES
        FOLDER Externals
    )
endif()

# Tracy client interface library
add_library(TracyClient INTERFACE)
target_sources(TracyClient INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}/Tracy/TracyClient.cpp)
if(MSVC)
    target_compile_options(TracyClient INTERFACE /wd4702)
else()
    target_compile_options(TracyClient INTERFACE -Wno-error -Wno-unused-parameter -Wno-sign-compare)
endif()

if(NOT WIN32 AND NOT APPLE AND UNIX) # Linux
    # Do not use -pthread compiler flag cause it breaks precompiled headers in incremental build
    set(THREADS_PREFER_PTHREAD_FLAG OFF)
    find_package(Threads REQUIRED)
    target_link_libraries(TracyClient INTERFACE Threads::Threads)
endif()

# Tracy instrumentation interface library
add_library(TracyInstrumentation INTERFACE)
target_include_directories(TracyInstrumentation INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}/Tracy)

# HLSL++ library
add_library(HLSLpp INTERFACE)
target_include_directories(HLSLpp INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}/HLSLpp/include)
target_compile_definitions(HLSLpp INTERFACE
    HLSLPP_FEATURE_TRANSFORM # Enable transformation matrices
    HLSLPP_LOGICAL_LAYOUT=0  # Set row-major logical layout
    HLSLPP_COORDINATES=0     # Set left-handed coordinate system
)
if(MSVC)
    target_sources(HLSLpp INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}/HLSLpp/include/hlsl++.natvis)
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU") # GCC
    target_compile_options(HLSLpp INTERFACE -Wno-deprecated-copy)
endif()

set_target_properties(nowide fmt freetype ittnotify
    PROPERTIES
    FOLDER Externals
)