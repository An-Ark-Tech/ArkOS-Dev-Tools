################################################################################
#Find available package generators

# DEB
if ("${CMAKE_SYSTEM}" MATCHES "Linux")
  find_program(DPKG_PROGRAM dpkg)
  if (EXISTS ${DPKG_PROGRAM})
    list (APPEND CPACK_GENERATOR "DEB")
  endif(EXISTS ${DPKG_PROGRAM})
endif()

list (APPEND CPACK_SOURCE_GENERATOR "TBZ2")
list (APPEND CPACK_SOURCE_GENERATOR "ZIP")
list (APPEND CPACK_SOURCE_IGNORE_FILES ";*.log;TODO;/.git/;.swp$;/build/;.gittags;.settings;.project;.cproject;.gitignore")

include (InstallRequiredSystemLibraries)
SET(CPACK_SET_DESTDIR "ON")

execute_process(COMMAND lsb_release -cs
    OUTPUT_VARIABLE RELEASE_CODENAME
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

execute_process(
    COMMAND dpkg --print-architecture
    OUTPUT_VARIABLE DPKG_ARCH
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

STRING(TOLOWER ${PROJECT_NAME} PROJECT_NAME_LOWER)
STRING(REGEX MATCHALL "[0-9]+" VERSIONS ${COMPONENT_VERSION})
LIST(GET VERSIONS 0 PKG_MAJOR_VERSION)
LIST(GET VERSIONS 1 PKG_MINOR_VERSION)
LIST(GET VERSIONS 2 PKG_PATCH_VERSION)

set (PKG_CPACK_CFG_FILE "${PROJECT_BINARY_DIR}/cpack_options.cmake")

