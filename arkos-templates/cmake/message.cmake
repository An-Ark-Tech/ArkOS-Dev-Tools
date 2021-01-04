
orocos_typegen_headers(include/@pkgname@/@pkgname@.hpp
    DEPENDS ArkMsgBase-gnulinux
)

orocos_generate_package(
        DEPENDS_TARGETS ${OROCOS_PACKAGE_DEPENDENCIES}
        INCLUDE_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/include
)

STRING(REGEX MATCHALL "[0-9]+" VERSIONS ${COMPONENT_VERSION})
LIST(GET VERSIONS 0 VERSION_MAJOR)
set_target_properties(${PROJECT_NAME}-transport-corba-${OROCOS_TARGET} PROPERTIES SOVERSION ${VERSION_MAJOR} VERSION ${COMPONENT_VERSION})
set_target_properties(${PROJECT_NAME}-transport-mqueue-${OROCOS_TARGET} PROPERTIES SOVERSION ${VERSION_MAJOR} VERSION ${COMPONENT_VERSION})
set_target_properties(${PROJECT_NAME}-transport-typelib-${OROCOS_TARGET} PROPERTIES SOVERSION ${VERSION_MAJOR} VERSION ${COMPONENT_VERSION})
set_target_properties(${PROJECT_NAME}-typekit-${OROCOS_TARGET} PROPERTIES SOVERSION ${VERSION_MAJOR} VERSION ${COMPONENT_VERSION})