cmake_minimum_required(VERSION 3.4.1)  # for example

#add_library( native_add
# Sets the library as a shared library.
#SHARED
# Provides a relative path to your source file(s).
#../../ios/Classes/native_add.cpp )


add_library(libnative_add SHARED IMPORTED GLOBAL)
set_target_properties(libnative_add PROPERTIES IMPORTED_LOCATION ${CMAKE_CURRENT_SOURCE_DIR}/libs/${ANDROID_ABI}/libnative_add.so)

add_library(libcellulo-unity SHARED IMPORTED GLOBAL)
set_target_properties(libcellulo-unity PROPERTIES IMPORTED_LOCATION ${CMAKE_CURRENT_SOURCE_DIR}/libs/${ANDROID_ABI}/libcellulo-unity.so)
