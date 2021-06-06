if (POLICY CMP0114)
    cmake_policy(SET CMP0114 NEW) # 'ExternalProject' step targets fully adopt their steps, support new CMake build system
endif()

set(TARGET DirectXCompiler)

include(MethaneModules)
include(ExternalProject)

get_platform_arch_dir(PLATFORM_ARCH_DIR CPP_EXT)

add_library(${TARGET} STATIC
    DirectXCompiler.cpp
)

set(BINARIES_DIR ${CMAKE_CURRENT_SOURCE_DIR}/binaries/${PLATFORM_ARCH_DIR})
set(LIB_DIR ${BINARIES_DIR}/lib)
set(BIN_DIR ${BINARIES_DIR}/bin)

if(WIN32)

    get_target_arch(WIN_ARCH)
    if(${WIN_ARCH} STREQUAL "x64")
       set(BINARIES_MD5 b021edca36b29b2b4a1b770ceac840a6)
    elseif(${WIN_ARCH} STREQUAL "x86")
       set(BINARIES_MD5 126d272b93bf866d2752e0dab9cef5a8)
    endif()

    set(LIBRARIES
        "${LIB_DIR}/dxcompiler.lib")
    set(PREREQUISITE_BINARIES_LIST 
        "${BIN_DIR}/dxcompiler.dll")

elseif(APPLE)

    set(BINARIES_MD5 bac6f20868b8026db11545bb7af5a514)

else() # Linux

    set(BINARIES_MD5 267c9e7efece17b931826fb5cc287e3a)

endif()

ExternalProject_Add(${TARGET}Unpack
    URL ${BINARIES_DIR}.zip
    URL_MD5 ${BINARIES_MD5}
    SOURCE_DIR ${BINARIES_DIR}
    BUILD_BYPRODUCTS ${LIBRARIES}
    BUILD_IN_SOURCE TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    STEP_TARGETS build
)

add_dependencies(${TARGET} ${TARGET}Unpack-build)

set_target_properties(${TARGET} PROPERTIES PREREQUISITE_BINARIES "${PREREQUISITE_BINARIES_LIST}")

target_link_libraries(${TARGET}
    PUBLIC
        ${LIBRARIES}
)

target_include_directories(${TARGET}
    PUBLIC
        ./include
)

set_target_properties(${TARGET}
    PROPERTIES
    FOLDER Externals
)
