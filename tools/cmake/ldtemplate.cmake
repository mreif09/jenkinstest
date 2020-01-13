if(WIN32)
include(CheckCSourceCompiles)

set(LDTEMPLATE        ${PROJECT_SOURCE_DIR}/tools/cmake/win_test.ld_gcc7.in)

# test if linker symbols can be found
configure_file(${LDTEMPLATE} ${PROJECT_SOURCE_DIR}/test.ld)
set(CMAKE_REQUIRED_FLAGS "${LINKER_SCRIPT_OPTION}${PROJECT_SOURCE_DIR}/test.ld")
check_c_source_compiles("extern char _libdata_start__; int main(void) { return (int)_libdata_start__; };" Linker_Script_GCC7)
file(REMOVE ${PROJECT_SOURCE_DIR}/test.ld)

if (NOT Linker_Script_GCC7)
set(LDTEMPLATE        ${PROJECT_SOURCE_DIR}/tools/cmake/win_test.ld_gcc6.in)
endif()

else()
set(LDTEMPLATE        ${PROJECT_SOURCE_DIR}/tools/cmake/linux_test.ld.in)
endif()
message(STATUS "use linker script template ${LDTEMPLATE}")
