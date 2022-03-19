# 请改用自动批量查找所有 .cpp 和 .h 文件：
aux_source_directory(. mylib_sources)
aux_source_directory(mylib mylib_sources)
set(GLOB_RECURSE mylib_sources CONFIGURE_DEPENDS mylib/*.cpp mylib/*.h)

set(CMAKE_POSITION_INDEPENDENT_CODE ON)
# 使用 SHARED 在 Windows 上会遇到什么困难？请尝试修复!
#提示找不到dll库，可以自己复制过去，也可以下方这种方式

add_library(mylib SHARED ${mylib_sources})

set_property(TARGET mylib PROPERTY RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR})
set_property(TARGET mylib PROPERTY ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR})
set_property(TARGET mylib PROPERTY LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR})
set_property(TARGET mylib PROPERTY RUNTIME_OUTPUT_DIRECTORY_DEBUG ${PROJECT_BINARY_DIR})
set_property(TARGET mylib PROPERTY RUNTIME_OUTPUT_DIRECTORY_DEBUG ${PROJECT_BINARY_DIR})
set_property(TARGET mylib PROPERTY ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${PROJECT_BINARY_DIR})
set_property(TARGET mylib PROPERTY LIBRARY_OUTPUT_DIRECTORY_RELEASE ${PROJECT_BINARY_DIR})
set_property(TARGET mylib PROPERTY ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${PROJECT_BINARY_DIR})
set_property(TARGET mylib PROPERTY LIBRARY_OUTPUT_DIRECTORY_RELEASE ${PROJECT_BINARY_DIR})

target_compile_definitions(mylib PUBLIC MYLIB_EXPORT)

# 这里应该用 PRIVATE 还是 PUBLIC？
target_include_directories(mylib PUBLIC .)
