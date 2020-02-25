set(TARGET DirectXCompiler)

include(ExternalProject)

if(WIN32)

    set(BINARIES_MD5 d54ff368f738a4b1409b1807ac7baa0b)
    set(BINARIES_DIR ${CMAKE_CURRENT_SOURCE_DIR}/binaries/Windows)

elseif(APPLE)

    set(BINARIES_MD5 6f647d917debb826fef66c86f7bfdbf4)
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