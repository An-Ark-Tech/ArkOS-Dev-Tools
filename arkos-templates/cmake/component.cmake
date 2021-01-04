orocos_component(${PROJECT_NAME} @pkgname@.cpp)

orocos_install_headers(@pkgname@.hpp)

target_link_libraries(${PROJECT_NAME} ${USE_OROCOS_LIBRARIES} ${OROCOS-RTT_RTT-MARSHALLING_LIBRARY})
