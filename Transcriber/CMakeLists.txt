cmake_minimum_required(VERSION 3.6)
project(Transcriber)

set(CMAKE_CXX_STANDARD 11)

set(SOURCE_FILES main.cpp Resources/WordMap.cpp Resources/WordMap.h Devanagiri/BenEncode.cpp Devanagiri/BenDecode.h Devanagiri/DevDecode.cpp Devanagiri/DevEncode.h Resources/CodeMap.cpp Resources/CodeMap.h)
add_executable(Transcriber ${SOURCE_FILES})