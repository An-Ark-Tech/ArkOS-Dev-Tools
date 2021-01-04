# include orocos_* macros
if(NOT USE_OROCOS_RTT)
    find_package(OROCOS-RTT REQUIRED rtt-marshalling ${RTT_HINTS}) # minimal find, that does not include components
    include(${OROCOS-RTT_USE_FILE})
endif()

#
# Add orocos dependencies and include orocos* macroses.
#
macro(arkos_use_packages)
    ## dependencies to use in orocos_generate_package()
    set(PACKAGE_DEPENDENCIES ${ARGV})

    ## disable autolinking dependencies in orocos_component(), because it links typekit libraries to components
    ## it's only used with USE_OROCOS_LIBRARIES from orocos_use_package(), not orocos_find_package()
    set(OROCOS_NO_AUTO_LINKING ON)

    ## fill variables
    foreach(dep ${PACKAGE_DEPENDENCIES})
        orocos_use_package(${dep} REQUIRED VERBOSE) # fills USE_OROCOS_* set of variables
        orocos_find_package(${dep} REQUIRED VERBOSE)
    endforeach()
endmacro()

#
# Parses a arkospkg.xml file and stores the dependencies in RESULT.
# Relies on xpath. If no arkospkg is found, returns an empty RESULT.
#
# Usage: arkos_get_pkg_deps DEPS)
#
function( arkos_get_pkg_deps RESULT)
  if ( NOT EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/arkospkg.xml )
    message(STATUS "[arkos_get_pkg_deps] Note: this package has no manifest.xml file. No dependencies can be auto-configured.")
    return()
  endif ( NOT EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/arkospkg.xml )

  find_program(XPATH_EXE xpath )
  if (NOT XPATH_EXE)
      message(WARNING "[arkos_get_pkg_deps] xpath not found. Can't read dependencies in arkospkg.xml file.")
  else(NOT XPATH_EXE)
    execute_process(COMMAND ${XPATH_EXE} ERROR_VARIABLE XPATH_USAGE)
    IF (NOT XPATH_USAGE MATCHES ".*(-e query).*")
      execute_process(COMMAND ${XPATH_EXE} ${CMAKE_CURRENT_SOURCE_DIR}/arkospkg.xml "package/depend/@package" RESULT_VARIABLE RES OUTPUT_VARIABLE DEPS)
      SET(REGEX_STR " package=\"([^\"]+)\"")
    ELSE (NOT XPATH_USAGE MATCHES ".*(-e query).*")
      execute_process(COMMAND ${XPATH_EXE} -q -e "package/depend/@package" ${CMAKE_CURRENT_SOURCE_DIR}/arkospkg.xml RESULT_VARIABLE RES OUTPUT_VARIABLE DEPS)
      SET(REGEX_STR " package=\"([^\"]+)\"\n")
    ENDIF (NOT XPATH_USAGE MATCHES ".*(-e query).*")
    if (NOT RES EQUAL 0)
      message(SEND_ERROR "Error: xpath found but returned non-zero:${DEPS}")
    endif (NOT RES EQUAL 0)

    string(REGEX REPLACE "${REGEX_STR}" "\\1;" RR_RESULT "${DEPS}") # to set ; in between we may change to space
    
    if(DEFINED RR_RESULT)
        list(REMOVE_DUPLICATES RR_RESULT)
    endif()    
    set(${RESULT} ${RR_RESULT} PARENT_SCOPE)
  endif (NOT XPATH_EXE)
endfunction( arkos_get_pkg_deps RESULT)


