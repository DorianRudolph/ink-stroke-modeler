# Copyright 2022 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

function(ink_cc_library)
  cmake_parse_arguments(INK_CC_LIB
    "TESTONLY"
    "NAME"
    "HDRS;SRCS;DEPS"
    ${ARGN}
  )
  if(NOT INK_CC_LIB_TESTONLY OR INK_STROKE_MODELER_BUILD_TESTING)
    set(_NAME "ink_stroke_modeler_${INK_CC_LIB_NAME}")
    if(NOT DEFINED INK_CC_LIB_SRCS)
      add_library(${_NAME} INTERFACE ${INK_CC_LIB_HDRS})
      set_target_properties(${_NAME} PROPERTIES LINKER_LANGUAGE CXX)
      target_link_libraries(${_NAME} INTERFACE ${INK_CC_LIB_DEPS})
    else()
      add_library(${_NAME} ${INK_CC_LIB_SRCS} ${INK_CC_LIB_HDRS})
      target_link_libraries(${_NAME} PUBLIC ${INK_CC_LIB_DEPS})
    endif()
    add_library(InkStrokeModeler::${INK_CC_LIB_NAME} ALIAS ${_NAME})
  endif()
endfunction()

function(ink_cc_test)
  if(INK_STROKE_MODELER_BUILD_TESTING)
    cmake_parse_arguments(INK_CC_TEST
      ""
      "NAME"
      "SRCS;DEPS"
      ${ARGN}
    )
    set(_NAME "ink_stroke_modeler_${INK_CC_TEST_NAME}")
    add_executable(${_NAME} ${INK_CC_TEST_SRCS})
    target_link_libraries(${_NAME} ${INK_CC_TEST_DEPS})
    add_test(NAME ${_NAME} COMMAND ${_NAME})
  endif()
endfunction()
