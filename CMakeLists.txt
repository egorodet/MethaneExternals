cmake_minimum_required(VERSION 3.11.0)

list(APPEND CMAKE_MODULE_PATH
    "${CMAKE_CURRENT_SOURCE_DIR}/Catch2/single_include/cmake"
    "${CMAKE_CURRENT_SOURCE_DIR}/CMRC"
)

add_subdirectory(CML/cml)
add_subdirectory(Catch2/single_include)
add_subdirectory(ITT)
add_subdirectory(SPIRV)

# Nowide library
set(NOWIDE_BUILD_STATIC ON)
set(NOWIDE_BUILD_SHARED OFF)
set(NOWIDE_BUILD_TESTS OFF)
set(NOWIDE_BUILD_DOC_HTML OFF)
set(NOWIDE_BUILD_DOC_CHM OFF)
set(NOWIDE_BUILD_DOC_TEX OFF)
add_subdirectory(Nowide)

# Image loader library: STB or OIIO
if (METHANE_USE_OPEN_IMAGE_IO)
    add_subdirectory(OpenImageIO)
else()
    add_subdirectory(STB)
endif()

# Platform dependent libraries
if (WIN32)
    add_subdirectory(DirectXLibraries/D3DX12)
endif()
