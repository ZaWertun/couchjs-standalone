function(cat IN_FILE OUT_FILE)
  file(READ ${IN_FILE} CONTENTS)
  file(APPEND ${OUT_FILE} "${CONTENTS}")
endfunction()

set(SERVER_FILES ${SOURCE_DIR}/dreyfus.js
                 ${SOURCE_DIR}/nouveau.js
                 ${SOURCE_DIR}/filter.js
                 ${SOURCE_DIR}/mimeparse.js
                 ${SOURCE_DIR}/render.js
                 ${SOURCE_DIR}/state.js
                 ${SOURCE_DIR}/util.js
                 ${SOURCE_DIR}/validate.js
                 ${SOURCE_DIR}/views.js
                 ${SOURCE_DIR}/coffee-script.js
                 ${SOURCE_DIR}/loop.js)
message(STATUS "Building ${NAME} for MozJS-${VERSION}")
if("${VERSION}" STREQUAL "1.8.5")
    set(EXTRA_FILES ${SOURCE_DIR}/rewrite_fun.js)
else()
    set(EXTRA_FILES ${SOURCE_DIR}/60/rewrite_fun.js
                    ${SOURCE_DIR}/60/esprima.js
                    ${SOURCE_DIR}/60/escodegen.js)
endif()

file(WRITE ${NAME}.tmp "")
foreach(PATH ${EXTRA_FILES} ${SERVER_FILES})
    get_filename_component(FILE "${PATH}" NAME)
    get_filename_component(DIR "${PATH}" DIRECTORY)
    get_filename_component(DIR "${DIR}" NAME)
    message(STATUS "Appending ${DIR}/${FILE}")
    cat(${PATH} ${NAME}.tmp)
endforeach()
file(RENAME ${NAME}.tmp ${NAME})
