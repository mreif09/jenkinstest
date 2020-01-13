# create object lib for a unit
add_library(unit OBJECT ${CMAKE_CURRENT_SOURCE_DIR}/unit.cpp)
target_include_directories(unit PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

# add units to the lib
target_sources(${LIB} PRIVATE $<TARGET_OBJECTS:unit>)