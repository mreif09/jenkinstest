# add unittest
add_google_unit_test(unit_test unit_test.cpp FILES $<TARGET_OBJECTS:unit>)
target_include_directories(unit_test PRIVATE $<TARGET_PROPERTY:unit,INTERFACE_INCLUDE_DIRECTORIES>)