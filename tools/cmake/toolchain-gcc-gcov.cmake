#common
set(CMAKE_LINKER ld CACHE FILEPATH "Linker")
set(CMAKE_AR ar CACHE FILEPATH "Archiver")

set(COVERAGE_COMPILE_FLAGS "-fprofile-arcs -ftest-coverage -DGCOV_ACTIVE")
set(COVERAGE_LINK_FLAGS    "-lgcov -coverage")
set(LINKER_SCRIPT_OPTION   "-Xlinker -T")
set(LINKER_MAPFILE_OPTION  "-Xlinker -Map=")

# C
set(CMAKE_C_COMPILER gcc)

set(CMAKE_C_FLAGS "-Wall -Wextra -Wno-unused-parameter -Wno-unused-but-set-parameter -Wno-unknown-pragmas -Werror=vla -Werror=pointer-arith -Werror=declaration-after-statement" CACHE STRING "CFLAGS")
set(CMAKE_C_FLAGS_DEBUG "-g" CACHE STRING "CFLAGS for Debug")
set(CMAKE_C_FLAGS_RELEASE "-O3 -DNDEBUG" CACHE STRING "CFLAGS for Release")
set(CMAKE_C_FLAGS_RELWITHDEBINFO "-O2 -g -DNDEBUG" CACHE STRING "CFLAGS for RelWithDebInfo")
set(CMAKE_C_FLAGS_MINSIZEREL "-Os -DNDEBUG" CACHE STRING "CFLAGS for MinSizeRel")

# C++
set(CMAKE_CXX_COMPILER g++)

set(CMAKE_CXX_FLAGS "-fno-exceptions" CACHE STRING "CXXFLAGS")
set(CMAKE_CXX_FLAGS_DEBUG "-g" CACHE STRING "CXXFLAGS for Debug")
set(CMAKE_CXX_FLAGS_RELEASE "-O3 -DNDEBUG" CACHE STRING "CXXFLAGS for Release")
set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "-O2 -g -DNDEBUG" CACHE STRING "CXXFLAGS for RelWithDebInfo")
set(CMAKE_CXX_FLAGS_MINSIZEREL "-Os -DNDEBUG" CACHE STRING "CXXFLAGS for MinSizeRel")