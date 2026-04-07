# CMakeLists.txt for libft8 wrapper
cmake_minimum_required(VERSION 3.18)
project(libft8_wrapper LANGUAGES C CXX Fortran)

# ---------------------------------------------------
# Add the original FT8 Fortran sources from the WSJT-X repo
# ---------------------------------------------------
set(FT8_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/../wsjtx/lib/ft8/ft8code.f90
    ${CMAKE_CURRENT_SOURCE_DIR}/../wsjtx/lib/ft8/ft8_params.f90
    ${CMAKE_CURRENT_SOURCE_DIR}/../wsjtx/lib/ft8/genft8.f90
    ${CMAKE_CURRENT_SOURCE_DIR}/../wsjtx/lib/ft8/encode174_91.f90
    ${CMAKE_CURRENT_SOURCE_DIR}/../wsjtx/lib/ft8/decode174_91.f90
    ${CMAKE_CURRENT_SOURCE_DIR}/../wsjtx/lib/ft8/filt8.f90
    ${CMAKE_CURRENT_SOURCE_DIR}/../wsjtx/lib/ft8/sync8.f90
    # Add other .f90 files you need here …
)

# Create a static library from the Fortran sources
add_library(ft8_static STATIC ${FT8_SOURCES})
set_target_properties(ft8_static PROPERTIES POSITION_INDEPENDENT_CODE ON)

# ---------------------------------------------------
# C++ wrapper exposing a clean C API
# ---------------------------------------------------
add_library(ft8_wrapper SHARED
    ft8_wrapper.cpp
)

# Link the wrapper to the static Fortran library
target_link_libraries(ft8_wrapper PRIVATE ft8_static)

# Export the include directory for the header
target_include_directories(ft8_wrapper PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

# For Android, we will later provide an ndk-build style or CMake toolchain
# For iOS, Xcode will configure the same CMake project.
