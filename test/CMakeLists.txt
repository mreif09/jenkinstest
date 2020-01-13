include(ldtemplate)
include(gtest)

# coverage
find_program(GCOVR gcovr)

if (GCOVR)
  message(STATUS "Found GCOVR: TRUE")

  add_custom_target(line_coverage gcovr -r ${CMAKE_SOURCE_DIR} --filter ${SRC_DIR})
  add_custom_target(branch_coverage gcovr -r ${CMAKE_SOURCE_DIR} --filter ${SRC_DIR} -b)
else()
  message(WARNING "GCOVR NOT FOUND -> no code coverage targets")
endif()

# add tests
add_subdirectory(unit)
