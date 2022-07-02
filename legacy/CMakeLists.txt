# 为什么 legacy 这个只有 .c 文件的对象出错了？
# project(hellocmake VERSION 3.1.4 LANGUAGES CXX) 只指定了cpp语言，未指定c语言
add_executable(legacy "legacy.c")
