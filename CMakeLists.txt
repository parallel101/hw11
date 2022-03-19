# 为什么不指定 cmake_minimum_required 会导致下面在 project 处出错？
# 因为需要给cmake指定最小支持版本，有可能下方的makelists中有新版本才能支持的语法或特性
cmake_minimum_required(VERSION 3.10)

# 如何让构建类型默认为 Release？
#set(CMAKE_BUILD_TYPE Release)
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()

# 这样设置 C++14 的方式对吗？请改正
#set(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} "-std=c++14")
#上方这样设置有可能在不同平台造成冲突，更推荐使用cmake定义好的
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
project(hellocmake VERSION 3.1.4 LANGUAGES C CXX)
# （可选）使用 ccache 加速编译
#find_program(CCACHE_PROGRAM ccache)

# legacy/CMakeLists.txt 和 mylib/CMakeLists.txt 里还有问题哦！
add_subdirectory(legacy)
add_subdirectory(mylib)

# 这样需要一个个写出所有文件很麻烦，请改成自动批量添加源文件
file(GLOB main_sources CONFIGURE_DEPENDS src/*.cpp src/*.h)
target_link_libraries(main PRIVATE mylib)
add_executable(main ${main_sources})
# 请改为项目的正确版本（用变量来获取）
target_compile_definitions(main PRIVATE HELLOCMAKE_VERSION="${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}")

# （可选）添加 run 作为伪目标方便命令行调用
add_custom_target(run COMMAND $<TARGET_FILE:main>)