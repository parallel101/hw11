# 为什么 legacy 这个只有 .c 文件的对象出错了？-> 没在 project( ... LANGUAGES C CXX) 中启用 C
add_executable(legacy "legacy.c")
