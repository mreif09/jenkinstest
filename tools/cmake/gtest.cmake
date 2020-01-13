find_package(Threads REQUIRED)
find_package(GTest)

if(NOT GTest_FOUND)
    message(STATUS "GTest NOT found -> use GTest from tools folder")

    set(GTEST_BASE_DIR ${PROJECT_SOURCE_DIR}/tools/googletest)

    include(ExternalProject)
    ExternalProject_Add(gtest  SOURCE_DIR ${GTEST_BASE_DIR}
                            BINARY_DIR ${CMAKE_BINARY_DIR}/gtest
                            CMAKE_GENERATOR ${CMAKE_GENERATOR}
                            CMAKE_ARGS -DCMAKE_BUILD_TYPE=Release
                            BUILD_COMMAND ${CMAKE_MAKE_PROGRAM}
                            INSTALL_COMMAND ""
                            EXCLUDE_FROM_ALL 1)

    set(GTEST_INCLUDE_DIR  ${GTEST_BASE_DIR}/googletest/include)
    set(GTEST_LIBRARY      ${CMAKE_BINARY_DIR}/gtest/googlemock/gtest/libgtest.a)
    set(GTEST_MAIN_LIBRARY ${CMAKE_BINARY_DIR}/gtest/googlemock/gtest/libgtest_main.a)
endif()

SET(GTEST_LIBRARIES ${GTEST_LIBRARY} ${GTEST_MAIN_LIBRARY} ${CMAKE_THREAD_LIBS_INIT})

find_package(gtest_test_libs QUIET)

if(gtest_test_libs_FOUND)
    message(STATUS "Found gtest test libs: TRUE")
else()
    message(STATUS "gtest test libs NOT found -> use gtest test libs from tools folder")

    add_library(gtest_test_lib ${CMAKE_SOURCE_DIR}/tools/test/UT_ResetRAM.c)
    target_include_directories(gtest_test_lib PUBLIC
                                $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/tools/test>
                                $<INSTALL_INTERFACE:${INCLUDE_INSTALL_DIR}>)
    target_compile_definitions(gtest_test_lib PUBLIC -DRESET_ACTIVE)

    # add installation
    install_package(gtest_test_libs gtest_test_lib HEADERS ${CMAKE_SOURCE_DIR}/tools/test/UT_ResetRAM.h)
endif()

#
# add_google_unit_test(<target> <sources> [FILES <tested sources>]
#                                         [DIRS <include dirs]
#                                         [NORESETLIBS <noresetlibs>])
#
#  Adds a google test based test executable, <target>, built from <sources> and
#  adds the test so that CTest will run it. Both the executable and the test
#  will be named <target>.
#
#  A lib is generated from the <tested sources>.
#  The testlib (${sutlib}) could be moved in the .libbss or
#  .libdata section by a linker file.
#
#  The ${sutlib} and <noresetlibs> are linked to the test.
#
function(add_google_unit_test target)
    # parse arguments in
    set(argname "")
    foreach(arg ${ARGN})
        if(arg STREQUAL "FILES" OR arg STREQUAL "DIRS" OR arg STREQUAL "NORESETLIBS")
            set(argname ${arg})
        elseif(argname STREQUAL "FILES")
            list(APPEND tested_sources ${arg})
        elseif(argname STREQUAL "DIRS")
            list(APPEND include_dirs ${arg})
        elseif(argname STREQUAL "NORESETLIBS")
            list(APPEND noresetlibs ${arg})
        else()
            list(APPEND sources ${arg})
        endif()
    endforeach()

    # generate target for the testlib
    if(DEFINED tested_sources OR DEFINED tested_libs)
        set(sutlib ${target}_sut)
        add_library(${sutlib} ${tested_sources})
        target_include_directories(${sutlib} PRIVATE ${include_dirs})
    endif()

    # generate target for the test
    add_executable(${target} ${sources})
    target_link_libraries(${target} PRIVATE ${GTEST_LIBRARIES}
                                            ${sutlib}
                                            ${noresetlibs}
                                            gtest_test_lib)
    target_include_directories(${target} PRIVATE ${include_dirs})

    target_include_directories(${target} SYSTEM PRIVATE ${GTEST_INCLUDE_DIR})

    # add options for reset RAM of testlib
    set(ldfile "${target}.ld")
    configure_file(${LDTEMPLATE} ${ldfile})
    set_target_properties(${target} PROPERTIES LINK_FLAGS "${COVERAGE_LINK_FLAGS} \
                                                           ${LINKER_SCRIPT_OPTION}${ldfile} \
                                                           ${LINKER_MAPFILE_OPTION}${target}.map")

    # if gtest is no installed, add dependency to the gtest target
    if(NOT GTest_FOUND)
    add_dependencies(${target} gtest)
    endif()

    add_test(NAME ${target} COMMAND $<TARGET_FILE:${target}>)
endfunction()
