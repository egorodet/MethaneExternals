set(TARGET DirectXCompiler)

include(MethaneModules)
include(ExternalProject)

get_platform_dir()

add_library(${TARGET} STATIC
    DirectXCompiler.cpp
)

set(BINARIES_DIR ${CMAKE_CURRENT_SOURCE_DIR}/binaries/${PLATFORM_DIR})
set(LIB_DIR ${BINARIES_DIR}/lib)
set(BIN_DIR ${BINARIES_DIR}/bin)

if(WIN32)

    set(BINARIES_MD5 95576ef7923bf3e4b5ee6f14359ee830)
    set(LIBRARIES
        "${LIB_DIR}/dxcompiler.lib"
        "${LIB_DIR}/d3dcompiler_dxc_bridge.lib")
    set(PREREQUISITE_BINARIES_LIST 
        "${BIN_DIR}/dxcompiler.dll"
        "${BIN_DIR}/d3dcompiler_dxc_bridge.dll")

elseif(APPLE)

    set(BINARIES_MD5 6f647d917debb826fef66c86f7bfdbf4)

endif()

if(WIN32 OR APPLE)

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

endif()

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
