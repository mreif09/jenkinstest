include(CMakePackageConfigHelpers)

if(UNIX OR OS2)
  set(LIB_INSTALL_DIR
    "${CMAKE_INSTALL_PREFIX}/lib"
    CACHE PATH "The subdirectory relative to the install prefix where libraries will be installed (default is prefix/lib)"
  )

  set(INCLUDE_INSTALL_DIR
    "${CMAKE_INSTALL_PREFIX}/include"
    CACHE PATH "The subdirectory to the header prefix (default prefix/include)"
  )

  set(BIN_INSTALL_DIR
    "${CMAKE_INSTALL_PREFIX}/bin"
    CACHE PATH "The ${APPLICATION_NAME} binary install dir (default prefix/bin)"
  )

  set(CMAKE_INSTALL_DIR
    "${LIB_INSTALL_DIR}/cmake"
    CACHE PATH "The subdirectory to install cmake config files")
else()
  set(LIB_INSTALL_DIR "lib" CACHE PATH "-")
  set(INCLUDE_INSTALL_DIR "include" CACHE PATH "-")
  set(BIN_INSTALL_DIR "bin" CACHE PATH "-")
  set(CMAKE_INSTALL_DIR "${LIB_INSTALL_DIR}/cmake" CACHE PATH "-")
endif()

#
# install_package(<package> <targets> [VERSION <version>] [HEADERS <headers>])
#
function(install_package package)
    # parse arguments
    set(argname "")
    foreach(arg ${ARGN})
        if(arg STREQUAL "VERSION" OR arg STREQUAL "HEADERS")
            set(argname ${arg})
          elseif(argname STREQUAL "VERSION")
            set(version ${arg})
        elseif(argname STREQUAL "HEADERS")
            list(APPEND headers ${arg})
        else()
            list(APPEND targets ${arg})
        endif()
    endforeach()

    # install libraries
    install(TARGETS ${targets}
            EXPORT ${package}
            COMPONENT ${package}
            LIBRARY DESTINATION ${LIB_INSTALL_DIR}
            ARCHIVE DESTINATION ${LIB_INSTALL_DIR}
            RUNTIME DESTINATION ${BIN_INSTALL_DIR}
            INCLUDES DESTINATION ${INCLUDE_INSTALL_DIR})

    # install headers
    if(DEFINED headers)
        install(FILES ${headers}
                DESTINATION ${INCLUDE_INSTALL_DIR}
                COMPONENT ${package} )
    endif()

    # install config
    install(EXPORT ${package}
            FILE ${package}-config.cmake
            DESTINATION lib/cmake/${package}
            COMPONENT ${package} )

    if(DEFINED version)
        write_basic_package_version_file(
            ${CMAKE_BINARY_DIR}/${package}-config-version.cmake
            VERSION ${version}
            COMPATIBILITY AnyNewerVersion)

        install(FILES ${CMAKE_BINARY_DIR}/${package}-config-version.cmake
                DESTINATION ${CMAKE_INSTALL_DIR}/${package}
                COMPONENT ${package})
    endif()

    # add target for installing only this package
    add_custom_target(install_${package}
                      ${CMAKE_COMMAND} -DCOMPONENT=${package} -P ${CMAKE_CURRENT_BINARY_DIR}/cmake_install.cmake)
endfunction()
