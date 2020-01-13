find_package(Doxygen)

if(Doxygen_FOUND)

set(DOXYFILE            ${CMAKE_BINARY_DIR}/Doxyfile)
set(DOXYFILE_OUTPUT_DIR ${CMAKE_BINARY_DIR})
set(DOXYFILE_SOURCE_DIR ${PROJECT_SOURCE_DIR})
set(DOXYFILE_LATEX      NO)

configure_file(${PROJECT_SOURCE_DIR}/tools/cmake/Doxyfile.in ${DOXYFILE})

add_custom_target(doc COMMAND "${DOXYGEN_EXECUTABLE}" "${DOXYFILE}"
                      COMMENT "Writing documentation to ${DOXYFILE_OUTPUT_DIR}..."
                      WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}")

set_property(DIRECTORY APPEND PROPERTY ADDITIONAL_MAKE_CLEAN_FILES ${DOXYFILE_OUTPUT_DIR}/html)

endif()
