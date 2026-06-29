cmake_minimum_required(VERSION 3.10)

project(couchjs
        VERSION 1.0.0
        LANGUAGES CXX)

find_package(PkgConfig REQUIRED)

if(FORCE_MOZJS_VERSION)
    pkg_check_modules(MOZJS REQUIRED mozjs-${FORCE_MOZJS_VERSION})
else()
    pkg_search_module(MOZJS REQUIRED mozjs-60
                                     mozjs-68
                                     mozjs-78 mozjs-86 mozjs-91
                                     mozjs-102 mozjs-115 mozjs-128
                                     mozjs-140)
endif()
message(STATUS "Found ${MOZJS_MODULE_NAME} (version: ${MOZJS_VERSION}, include: ${MOZJS_INCLUDE_DIRS}): all is ok!")

string(REPLACE "mozjs-" "" SOURCE_VERSION "${MOZJS_MODULE_NAME}")
if(SOURCE_VERSION VERSION_LESS "2")
    set(SOURCE_VERSION "1.8.5")
elseif(SOURCE_VERSION VERSION_GREATER_EQUAL "60" AND SOURCE_VERSION VERSION_LESS "78")
    set(SOURCE_VERSION "60")
elseif(SOURCE_VERSION VERSION_GREATER_EQUAL "78" AND SOURCE_VERSION VERSION_LESS "102")
    set(SOURCE_VERSION "86")
elseif(SOURCE_VERSION VERSION_GREATER_EQUAL "102" AND SOURCE_VERSION VERSION_LESS "140")
    set(SOURCE_VERSION "102")
elseif(SOURCE_VERSION VERSION_GREATER_EQUAL "140")
    set(SOURCE_VERSION "140")
endif()
add_subdirectory(server)

if(SOURCE_VERSION STREQUAL "1.8.5")
    set(TARGET_SOURCES src/${SOURCE_VERSION}/main.c
                       src/${SOURCE_VERSION}/utf8.c
                       src/${SOURCE_VERSION}/util.c)
else()
    set(TARGET_SOURCES src/${SOURCE_VERSION}/main.cpp
                       src/${SOURCE_VERSION}/util.cpp)
endif()

configure_file(${PROJECT_SOURCE_DIR}/config.h.in
               ${PROJECT_BINARY_DIR}/config.h)

add_executable(${PROJECT_NAME} ${TARGET_SOURCES})

INSTALL(TARGETS ${PROJECT_NAME}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})

target_include_directories(${PROJECT_NAME}
                           PRIVATE ${PROJECT_BINARY_DIR} ${MOZJS_INCLUDE_DIRS})
target_compile_options(${PROJECT_NAME}
                       PRIVATE -fpermissive ${MOZJS_CFLAGS_OTHER})
target_link_libraries(${PROJECT_NAME}
                      PRIVATE ${MOZJS_LIBRARIES})
target_link_directories(${PROJECT_NAME}
                        PRIVATE ${MOZJS_LIBRARY_DIRS})
