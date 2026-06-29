cmake_minimum_required(VERSION 3.10)

project(main.js)

add_custom_command(OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}"
                   COMMAND ${CMAKE_COMMAND} -DNAME=${PROJECT_NAME} -DVERSION=${SOURCE_VERSION}
                                           -DSOURCE_DIR=${CMAKE_CURRENT_SOURCE_DIR}
                                           -P "${CMAKE_CURRENT_SOURCE_DIR}/Build.cmake"
                   COMMENT "Building ${PROJECT_NAME}"
                   VERBATIM)

add_custom_target(${PROJECT_NAME}
                  ALL
                  DEPENDS "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}")
