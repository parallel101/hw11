# 请改用自动批量查找所有 .cpp 和 .h 文件：
file(GLOB mylib_sources CONFIGURE_DEPENDS mylib/*.cpp mylib/*.h)

# 使用 SHARED 在 Windows 上会遇到什么困难？请尝试修复!
# 当dll和exe不在同一目录时，只会查找exe所在目录和PATH
add_library(mylib SHARED ${mylib_sources})
set_property(TARGET mylib PROPERTY RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR})
set_property(TARGET mylib PROPERTY ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR})
set_property(TARGET mylib PROPERTY LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR})
set_property(TARGET mylib PROPERTY RUNTIME_OUTPUT_DIRECTORY_DEBUG ${PROJECT_BINARY_DIR})
set_property(TARGET mylib PROPERTY ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${PROJECT_BINARY_DIR})
set_property(TARGET mylib PROPERTY LIBRARY_OUTPUT_DIRECTORY_DEBUG ${PROJECT_BINARY_DIR})
set_property(TARGET mylib PROPERTY RUNTIME_OUTPUT_DIRECTORY_RELEASE ${PROJECT_BINARY_DIR})
set_property(TARGET mylib PROPERTY ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${PROJECT_BINARY_DIR})
set_property(TARGET mylib PROPERTY LIBRARY_OUTPUT_DIRECTORY_RELEASE ${PROJECT_BINARY_DIR})

target_compile_definitions(mylib PRIVATE MYLIB_EXPORT)


# 这里应该用 PRIVATE 还是 PUBLIC？
#target_include_directories(mylib PRIVATE .)
target_include_directories(mylib PUBLIC .)