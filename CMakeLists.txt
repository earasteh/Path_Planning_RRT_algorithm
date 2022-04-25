cmake_minimum_required(VERSION 3.8 FATAL_ERROR)
project(matplotlib_cpp LANGUAGES CXX)

include(GNUInstallDirs)
set(PACKAGE_NAME matplotlib_cpp)
set(INSTALL_CONFIGDIR ${CMAKE_INSTALL_LIBDIR}/${PACKAGE_NAME}/cmake)


# Library target
add_library(matplotlib_cpp INTERFACE)
target_include_directories(matplotlib_cpp
        INTERFACE
        $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/examples>
        $<INSTALL_INTERFACE:include>
        )
target_compile_features(matplotlib_cpp INTERFACE
        cxx_std_11
        )
# TODO: Use `Development.Embed` component when requiring cmake >= 3.18

# python finding
message("*****************************************")

find_package (Python COMPONENTS Interpreter Development)

message("Python_ROOT " ${Python_ROOT})
message("Python_FOUND " ${Python_FOUND})
message("Python_Interpreter_FOUND " ${Python_Interpreter_FOUND})
message("Python_Development_FOUND " ${Python_Development_FOUND})
message("Python_LIBRARIES " ${Python_LIBRARIES})
message("Python_LIBRARY_DIRS " ${Python_LIBRARY_DIRS})
message("Python_INCLUDE_DIRS " ${Python_INCLUDE_DIRS})
message("Python_LINK_OPTIONS " ${Python_LINK_OPTIONS})
message("Python_EXECUTABLE " ${Python_EXECUTABLE})
message("Python_INTERPRETER_ID " ${Python_INTERPRETER_ID})
message("Python_VERSION " ${Python_VERSION})
message("Python_VERSION_MAJOR " ${Python_VERSION_MAJOR})
message("Python_VERSION_MINOR " ${Python_VERSION_MINOR})


target_link_libraries(matplotlib_cpp INTERFACE
        Python3::Python
        Python3::Module
        )
find_package(Python3 COMPONENTS NumPy)
message("NUMPY found? " ${Python3_NumPy_FOUND})
if(Python3_NumPy_FOUND)
    target_link_libraries(matplotlib_cpp INTERFACE
            Python3::NumPy
            )
else()
    target_compile_definitions(matplotlib_cpp INTERFACE WITHOUT_NUMPY)
endif()
install(
        TARGETS matplotlib_cpp
        EXPORT install_targets
)


# Examples
add_executable(rrt path_planning_RRT.cpp)
target_link_libraries(rrt PRIVATE matplotlib_cpp)
set_target_properties(rrt PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")


if(Python3_NumPy_FOUND)

endif()


# Install headers
install(FILES
        "${PROJECT_SOURCE_DIR}/matplotlibcpp.h"
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})


# Install targets file
install(EXPORT install_targets
        FILE
        ${PACKAGE_NAME}Targets.cmake
        NAMESPACE
        ${PACKAGE_NAME}::
        DESTINATION
        ${INSTALL_CONFIGDIR}
        )

# Install matplotlib_cppConfig.cmake
include(CMakePackageConfigHelpers)
configure_package_config_file(
        ${CMAKE_CURRENT_SOURCE_DIR}/cmake/${PACKAGE_NAME}Config.cmake.in
        ${CMAKE_CURRENT_BINARY_DIR}/${PACKAGE_NAME}Config.cmake
        INSTALL_DESTINATION ${INSTALL_CONFIGDIR}
)
install(FILES
        ${CMAKE_CURRENT_BINARY_DIR}/${PACKAGE_NAME}Config.cmake
        DESTINATION ${INSTALL_CONFIGDIR}
        )
