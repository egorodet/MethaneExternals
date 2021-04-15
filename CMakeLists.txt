cmake_minimum_required(VERSION 3.11.0)

list(APPEND CMAKE_MODULE_PATH
    "${CMAKE_CURRENT_SOURCE_DIR}/CMakeModules"
    "${CMAKE_CURRENT_SOURCE_DIR}/CMRC"
)

add_subdirectory(FMT)
add_subdirectory(Catch2)
add_subdirectory(SPIRV)
add_subdirectory(DirectXCompiler)
add_subdirectory(D3DCompilerToDXC)
add_subdirectory(PerlinNoise)
add_subdirectory(CLI11)
add_subdirectory(FreeType2)
add_subdirectory(IttApi)
add_subdirectory(MagicEnum)

# Disable compiler warnings for freetype
if(MSVC)
    target_compile_options(freetype PRIVATE /wd4267 /wd4244 /wd4018 /wd4312)
else()
    target_compile_options(freetype PRIVATE -Wno-everything)
endif()

# Nowide library
set(BUILD_SHARED_LIBS OFF)
set(BUILD_TESTING OFF)
set(NOWIDE_INSTALL OFF CACHE BOOL "Disable nowide library installation")
add_subdirectory(BoostNowide)

# TaskFlow library
set(TF_BUILD_BENCHMARKS OFF CACHE BOOL "Disable TaskFlow benchmarks build")
set(TF_BUILD_CUDA OFF CACHE BOOL "Disable TaskFlow CUDA support")
set(TF_BUILD_TESTS OFF CACHE BOOL "Disable TaskFlow tests build")
set(TF_BUILD_EXAMPLES OFF CACHE BOOL "Disable TaskFlow examples build")
add_subdirectory(TaskFlow)
add_library(TaskFlow ALIAS Taskflow)

# Image loader library: STB or OIIO
if (METHANE_USE_OPEN_IMAGE_IO)
    add_subdirectory(OpenImageIO)
else()
    add_subdirectory(STB)
endif()

# Platform dependent libraries
if (WIN32)
    add_subdirectory(DirectXLibs/D3DX12)

    # DirectXTex library
    set(DIRECTXTEX_BUILD_TOOLS                 OFF CACHE BOOL "Disable DirectXTex tools build")
    set(DIRECTXTEX_STANDALONE_ENABLED          OFF CACHE BOOL "Disable DirectXTex standalone build")
    set(BUILD_DX11                             OFF CACHE BOOL "Disable DirectXTex DirectX11 Runtime support")
    set(BUILD_DX12                             ON  CACHE BOOL "Enabled DirectXTex DirectX12 Runtime support")
    add_subdirectory(DirectXTex)
    set_target_properties(DirectXTex
        PROPERTIES
        FOLDER Externals
    )
endif()

set_target_properties(nowide fmt freetype ittnotify
    PROPERTIES
    FOLDER Externals
)

# Tracy client interface library
add_library(TracyClient INTERFACE)
target_sources(TracyClient INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}/Tracy/TracyClient.cpp)
if(MSVC)
    target_compile_options(TracyClient INTERFACE /wd4456 /wd4189 /wd4100 /wd4505 /wd4244)
else()
    target_compile_options(TracyClient INTERFACE -Wno-error -Wno-unused-parameter -Wno-sign-compare)
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