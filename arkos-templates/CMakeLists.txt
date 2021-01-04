cmake_minimum_required(VERSION 3.6.3)
project(@pkgname@)

find_package(ArkOS-core REQUIRED) # minimal find, that does not include components
include(${ARKOS_USE_FILE})

arkos_config_version()

SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -O3")

# Force the compiler to catch warnings
SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wall")

arkos_get_pkg_deps(ARKDEPS)
arkos_use_packages(${ARKDEPS})

if(BUILDING_TEST)
    add_subdirectory(test)
endif()

include (${ARKOS_CPACK_FILE})
