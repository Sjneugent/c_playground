cmake_minimum_required(VERSION 4.1)
project(c_playground C CXX)

# Set C standard
set(CMAKE_C_STANDARD 17)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)

# Set C++ standard for testing
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Detect compiler and set specific flags
if(MSVC)
    # MSVC 2022 or newer
    add_compile_options(/W4 /permissive-)
elseif(CMAKE_C_COMPILER_ID STREQUAL "Clang")
    add_compile_options(-Wall -Wextra -pedantic)
elseif(CMAKE_C_COMPILER_ID STREQUAL "GNU")
    add_compile_options(-Wall -Wextra -pedantic)
endif()

# Source files
file(GLOB SOURCES src/*.c)

# Include Google Test for unit testing
include(FetchContent)
FetchContent_Declare(
  googletest
  URL https://github.com/google/googletest/archive/03597a01ee50ed33e9dfd640b249b4be3799d395.zip
)
# For Windows: Prevent overriding the parent project's compiler/linker on Windows
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

# Enable testing
enable_testing()


# Platform-specific executable name
if(WIN32)
    set(EXECUTABLE_NAME c_playground)
else()
    set(EXECUTABLE_NAME c_playground)
endif()

add_executable(${EXECUTABLE_NAME} ${SOURCES})

# Test executable
file(GLOB TEST_SOURCES tests/*.cpp)
add_executable(${EXECUTABLE_NAME}_test ${TEST_SOURCES})
target_link_libraries(${EXECUTABLE_NAME}_test gtest_main)

# Set output directory for test executable
set_target_properties(${EXECUTABLE_NAME}_test PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}
    RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}
)

# Add test
add_test(NAME ${EXECUTABLE_NAME}_test COMMAND ${EXECUTABLE_NAME}_test)


# Platform-specific settings
if(WIN32)
    target_link_libraries(${EXECUTABLE_NAME} ws2_32)
endif()

if(UNIX AND NOT APPLE)
    # Linux-specific settings (add libraries if needed)
    # Example: pthread
    target_link_libraries(${EXECUTABLE_NAME} pthread)
endif()


# Install for all platforms
install(TARGETS ${EXECUTABLE_NAME}
    RUNTIME DESTINATION dist
)



# Set output directories for Debug and Release
set_target_properties(${EXECUTABLE_NAME} PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}
    RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}
)


# Install rules for Debug and Release configurations (all platforms)
install(TARGETS ${EXECUTABLE_NAME}
    CONFIGURATIONS Debug
    RUNTIME DESTINATION dist
)
install(TARGETS ${EXECUTABLE_NAME}
    CONFIGURATIONS Release
    RUNTIME DESTINATION dist
)


