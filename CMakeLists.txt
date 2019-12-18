cmake_minimum_required(VERSION 3.15)
project(livetemp C)

set(CMAKE_C_STANDARD 11)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
include(${CMAKE_SOURCE_DIR}/cmake/ValaPrecompile.cmake)

find_package(Vala REQUIRED)

vala_precompile(
    VALA_C VALA_PRECOMPILE_TARGET
        app/Main.vala
        app/Sensor.vala
        app/Netwerk.vala
    PACKAGES
        libsoup-2.4
        gtk+-3.0
        posix
    OPTIONS
        --thread
        --enable-experimental-non-null
        --gresources=${CMAKE_CURRENT_SOURCE_DIR}/window.gresource.xml
        --gresources=${CMAKE_CURRENT_SOURCE_DIR}/dialog_format.gresource.xml
    GENERATE_VAPI
        appvapi
    GENERATE_HEADER
        applibh
)

add_executable(livetemp app/main.c hat/sensor.c hat/sensor.h hat/hat.h ${VALA_C} app/main.h)

find_package(PkgConfig REQUIRED)
pkg_check_modules(deps REQUIRED IMPORTED_TARGET gtk+-3.0 libsoup-2.4)
target_link_libraries(livetemp PkgConfig::deps)