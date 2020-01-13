cmake_minimum_required (VERSION 3.7)
project ("jenkinstest" VERSION 0.1.0)
set(APPLICATION_NAME "Jenkins test project")

# configuration
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/tools/cmake)

if(NOT DEFINED CMAKE_TOOLCHAIN_FILE OR CMAKE_TOOLCHAIN_FILE STREQUAL "")
    # load default toolchain
    include(toolchain-gcc-gcov)
endif()

if(NOT DEFINED CMAKE_BUILD_TYPE OR CMAKE_BUILD_TYPE STREQUAL "")
    set(CMAKE_BUILD_TYPE DEBUG)
endif()

option(BUILD_TESTS "Build tests and switch on gcov coverage" ON)
# option(EXTENDED "Switch for extended variant" OFF)

# if(EXTENDED)
# add_definitions(-DPRJCFG_VARIANT=1)
# endif()

set(PROJECT_SOURCE_DIR ${CMAKE_SOURCE_DIR})
set(SRC_DIR ${CMAKE_SOURCE_DIR}/src)
set(INCLUDE_DIR ${CMAKE_SOURCE_DIR}/include)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# includes
include(install)
include(doxygen)

# define name of the lib
set(LIB "jenkinstest")

# test
if(BUILD_TESTS)

set(CMAKE_C_FLAGS          "${CMAKE_C_FLAGS} ${COVERAGE_COMPILE_FLAGS}")
set(CMAKE_CXX_FLAGS        "${CMAKE_CXX_FLAGS} ${COVERAGE_COMPILE_FLAGS}")

enable_testing()

add_subdirectory(test)

endif()

# build
add_subdirectory(src)
