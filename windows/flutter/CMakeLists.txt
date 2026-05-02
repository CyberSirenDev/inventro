# This file controls Flutter-level build steps. It should not be edited.
cmake_minimum_required(VERSION 3.14)

set(EPHEMERAL_DIR "${CMAKE_CURRENT_SOURCE_DIR}/ephemeral")

# Configuration provided via flutter tool.
include(${EPHEMERAL_DIR}/generated_config.cmake)

# TODO: Move the rest of this into files in ephemeral. See
# https://github.com/flutter/flutter/issues/57146.

# Serves the same purpose as list(TRANSFORM ... PREPEND ...) which isn't
# available in 3.14.
function(list_prepend LIST_NAME PREFIX)
    set(NEW_LIST "")
    foreach(element ${${LIST_NAME}})
        list(APPEND NEW_LIST "${PREFIX}${element}")
    endforeach(element)
    set(${LIST_NAME} "${NEW_LIST}" PARENT_SCOPE)
endfunction()

# === Flutter Library ===
# System-level dependencies.
find_package(PkgConfig QUIET)

set(FLUTTER_LIBRARY "${EPHEMERAL_DIR}/flutter_windows.dll")

# Published to parent scope for install step.
set(FLUTTER_LIBRARY ${FLUTTER_LIBRARY} PARENT_SCOPE)
set(FLUTTER_ICU_DATA_FILE "${EPHEMERAL_DIR}/icudtl.dat" PARENT_SCOPE)
set(PROJECT_BUILD_DIR "${PROJECT_BINARY_DIR}/" PARENT_SCOPE)
set(AOT_LIBRARY "${PROJECT_BINARY_DIR}/windows/app.so" PARENT_SCOPE)

list(APPEND FLUTTER_LIBRARY_HEADERS
  "flutter_export.h"
  "flutter_windows.h"
  "flutter_messenger.h"
  "flutter_plugin_registrar.h"
  "flutter_texture_registrar.h"
)
list_prepend(FLUTTER_LIBRARY_HEADERS "${EPHEMERAL_DIR}/")
add_library(flutter INTERFACE)
target_include_directories(flutter INTERFACE
  "${EPHEMERAL_DIR}"
)
target_link_libraries(flutter INTERFACE "${FLUTTER_LIBRARY}.lib")
add_dependencies(flutter flutter_assemble)

add_library(flutter_wrapper_app STATIC
  "cpp_client_wrapper/flutter_engine.cc"
  "cpp_client_wrapper/flutter_view_controller.cc"
)
apply_standard_settings(flutter_wrapper_app)
set_target_properties(flutter_wrapper_app PROPERTIES
  COMPILE_FLAGS "-WX- /wd4100"
)
target_link_libraries(flutter_wrapper_app PUBLIC flutter)
target_include_directories(flutter_wrapper_app PUBLIC
  "cpp_client_wrapper/include"
  "${EPHEMERAL_DIR}"
)
add_dependencies(flutter_wrapper_app flutter_assemble)

add_library(flutter_wrapper_plugin STATIC
  "cpp_client_wrapper/flutter_plugin_registrar.cc"
)
apply_standard_settings(flutter_wrapper_plugin)
set_target_properties(flutter_wrapper_plugin PROPERTIES
  COMPILE_FLAGS "-WX- /wd4100"
)
target_link_libraries(flutter_wrapper_plugin PUBLIC flutter)
target_include_directories(flutter_wrapper_plugin PUBLIC
  "cpp_client_wrapper/include"
  "${EPHEMERAL_DIR}"
)
add_dependencies(flutter_wrapper_plugin flutter_assemble)

# === Flutter tool backend ===
# _phony_ is a non-existent file to force this command to always run.
add_custom_command(
  OUTPUT ${FLUTTER_LIBRARY} ${FLUTTER_LIBRARY_HEADERS}
    ${CMAKE_CURRENT_BINARY_DIR}/_phony_
  COMMAND ${CMAKE_COMMAND} -E env
    FLUTTER_ROOT=${FLUTTER_ROOT}
    FLUTTER_EPHEMERAL_DIR=${EPHEMERAL_DIR}
    PROJECT_DIR=${CMAKE_CURRENT_SOURCE_DIR}/../..
    FLUTTER_TARGET_PLATFORM=windows-x64
    "${FLUTTER_ROOT}/packages/flutter_tools/bin/tool_backend.bat"
      windows-x64 $<CONFIG>
  VERBATIM
)
add_custom_target(flutter_assemble DEPENDS
  "${FLUTTER_LIBRARY}"
  ${FLUTTER_LIBRARY_HEADERS}
)
