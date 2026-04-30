cmake_minimum_required(VERSION 3.20)

project(neovim_practice_cpp LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_executable(neovim_practice
  src/main.cpp
  src/task.cpp
)

target_include_directories(neovim_practice PRIVATE src)
target_compile_options(neovim_practice PRIVATE -Wall -Wextra -Wpedantic)

