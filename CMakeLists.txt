# 为什么不指定 cmake_minimum_required 会导致下面在 project 处出错？
# VERSION option in project() command not allowed unless CMP0048 is set to NEW
cmake_minimum_required(VERSION 3.10)

project(hellocmake VERSION 3.1.4 LANGUAGES C CXX)

# 如何让构建类型默认为 Release？
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    message("Setting build type to 'Release' as none was specified.")
    set(CMAKE_BUILD_TYPE Release CACHE STRING "Choose the type of build." FORCE)
    # Set the possible values of build type for cmake-gui
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release"
        "MinSizeRel" "RelWithDebInfo")
endif()

# 这样设置 C++14 的方式对吗？请改正 -> 不对
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# （可选）使用 ccache 加速编译
if (NOT MSVC)
    find_program(CCACHE_PROGRAM ccache)
    if (CCACHE_PROGRAM)
        message(STATUS "Found CCache : ${CCACHE_PROGRAM}")
        set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE ${CCACHE_PROGRAM})
        set_property(GLOBAL PROPERTY RULE_LAUNCH_LINK ${CCACHE_PROGRAM})
    endif()
endif()

# legacy/CMakeLists.txt 和 mylib/CMakeLists.txt 里还有问题哦！
add_subdirectory(legacy)
add_subdirectory(mylib)

# 这样需要一个个写出所有文件很麻烦，请改成自动批量添加源文件
file(GLOB main_sources CONFIGURE_DEPENDS
    ${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/*.h)
add_executable(main ${main_sources})

# Link libraries
target_link_libraries(main PRIVATE mylib)
if (WIN32 AND MSVC)
    set(CMAKE_INSTALL_PREFIX "${PROJECT_BINARY_DIR}/${CMAKE_BUILD_TYPE}" CACHE STRING "The path to use for make install" FORCE)
    install (TARGETS mylib
        RUNTIME DESTINATION ./)
endif()

# 请改为项目的正确版本（用变量来获取）-> Use configure file
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/in/config.h.in
    ${CMAKE_CURRENT_SOURCE_DIR}/src/config.h @ONLY)

# （可选）添加 run 作为伪目标方便命令行调用
add_custom_target(run COMMAND $<TARGET_FILE:main>)
