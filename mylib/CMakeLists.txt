# 请改用自动批量查找所有 .cpp 和 .h 文件：
aux_source_directory("mylib/" mylib_sources)

# 使用 SHARED 在 Windows 上会遇到什么困难？请尝试修复!
# Linux环境，略
add_library(mylib SHARED ${mylib_sources})
target_compile_definitions(mylib PRIVATE MYLIB_EXPORT)

# 这里应该用 PRIVATE 还是 PUBLIC？
# PUBLIC
target_include_directories(mylib PUBLIC .)
