if (POLICY CMP0114)
    cmake_policy(SET CMP0114 NEW) # 'ExternalProject' step targets fully adopt their steps, support new CMake build system
endif()

set(TARGET SPIRV)

include(ExternalProject)

if (WIN32)

    set(BINARIES_MD5 6c989bbc6100b8b2c60470dc30cd4001)
    set(BINARIES_DIR ${CMAKE_CURRENT_SOURCE_DIR}/binaries/Windows)

elseif(APPLE)

    set(BINARIES_MD5 f7fc05c7e0eccca52fd88be047d08335)
    set(BINARIES_DIR ${CMAKE_CURRENT_SOURCE_DIR}/binaries/MacOS)

endif()

ExternalProject_Add(${TARGET}
    URL ${BINARIES_DIR}.zip
    URL_MD5 ${BINARIES_MD5}
    SOURCE_DIR ${BINARIES_DIR}
    BUILD_IN_SOURCE TRUE
    EXCLUDE_FROM_ALL TRUE
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    STEP_TARGETS build
)