# Copyright (C) 2005-2011 MaNGOS <http://getmangos.com/>
# Copyright (C) 2009-2011 MaNGOSZero <https://github.com/mangos/zero>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

# CMake policies
cmake_minimum_required(VERSION 3.1...3.20)

project(MaNGOS)

# Allow -DACE_ROOT, -DTBB_ROOT, etc.
if(${CMAKE_VERSION} VERSION_GREATER "3.11")
  cmake_policy(SET CMP0074 NEW)
endif()

set(CMAKE_MODULE_PATH
  ${CMAKE_MODULE_PATH}
  ${CMAKE_SOURCE_DIR}/cmake
)

set(SUPPORTED_CLIENT_BUILD "CLIENT_BUILD_1_12_1" CACHE STRING "Client version the core will support")
option(USE_STD_MALLOC "Use standard malloc instead of TBB" OFF)
option(BUILD_FOR_HOST_CPU "Build specifically for the host CPU via `-march=native` (might not run on different machines)" ON)
option(TBB_DEBUG "Use TBB debug librairies" OFF)
option(USE_ANTICHEAT "Use anticheat" OFF)
option(USE_SCRIPTS "Compile scripts" ON)
option(USE_EXTRACTORS "Compile extractors" OFF)
option(USE_LIBCURL "Compile with libcurl for email support" OFF)
option(SCRIPT_LIB_ELUNA "Compile with support for Eluna scripts" 1)

if(UNIX)
  option(DEBUG_SYMBOLS "Include Debug Symbols" ON)
endif()

find_package(PCHSupport)
if(${CMAKE_VERSION} VERSION_GREATER_EQUAL "3.16")
  option(USE_PCH "Use precompiled headers" ON)
endif()

if(PCHSupport_FOUND AND (${CMAKE_VERSION} VERSION_GREATER_EQUAL "3.16"))
    if(MSVC)
      option(USE_PCH_OLD "Use old precompiled headers implementation" ON)
    else()
      option(USE_PCH_OLD "Use old precompiled headers implementation" OFF)
    endif()
else()
  unset(USE_PCH_OLD CACHE)
endif()

if(USE_LIBCURL)
  find_package(CURL REQUIRED)
  #add_definitions(-D_HAS_AUTO_PTR_ETC) # for VS2017 ACE support, won't do any harm to other compilers
  #set(CMAKE_CXX_STANDARD 17)
  #set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /std:c++17")
endif()

# Force out-of-source build
string(COMPARE EQUAL "${CMAKE_SOURCE_DIR}" "${CMAKE_BINARY_DIR}" BUILDING_IN_SOURCE)
if(BUILDING_IN_SOURCE)
  message(FATAL_ERROR
    "This project requires an out of source build. Remove the file 'CMakeCache.txt' found in this directory before continuing, create a separate build directory and run 'cmake <srcs> [options]' from there."
  )
endif()

if(WIN32)
  if(MSVC)
    if(MSVC_VERSION LESS 1900)
      message(FATAL_ERROR "Only Visual Studio 2015 or newer is supported")
    endif()
  endif()

  # Added by Giperion, in WIN32 output all compiled files in one directory
  set( CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin )
  set( CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/lib )
  # Allow creating folders in solution
  set_property(GLOBAL PROPERTY USE_FOLDERS ON)
endif()

find_package(Platform REQUIRED)
find_package(Git)

# Output description of this script
message(STATUS
  "\nThis script builds the MaNGOS server.
  Options that can be used in order to configure the process:
    PREFIX: Path where the server should be installed to
    USE_PCH: Use precompiled headers
  To set an option simply type -D<OPTION>=<VALUE> after 'cmake <srcs>'.
  For example: cmake .. -DPREFIX=/opt/mangos\n"
) # TODO: PLATFORM: Sets the architecture for compile (X86,X64)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Release" CACHE STRING "" FORCE)
endif()

# Find out what system we use to include the needed libs
if(WIN32)
  if(PLATFORM MATCHES X86) # 32-bit
    set(DEP_ARCH win32)
  else() # 64-bit
    set(DEP_ARCH x64)
  endif()
endif()

# Add options for compile of mangos
if((${CMAKE_VERSION} VERSION_LESS "3.16") OR USE_PCH_OLD)
  if(PCHSupport_FOUND)
    if(WIN32)
      option(USE_PCH "Use precompiled headers" ON)
    else()
      option(USE_PCH "Use precompiled headers" OFF)
    endif()
  endif()
else()
  option(USE_PCH "Use precompiled headers" ON)
endif()

# Set up the install-prefix
if(CMAKE_INSTALL_PREFIX STREQUAL "/usr/local")
  get_filename_component(PREFIX_ABSOLUTE "../server" ABSOLUTE)
  set(CMAKE_INSTALL_PREFIX ${PREFIX_ABSOLUTE} CACHE PATH "Install path prefix." FORCE)
endif()

if(PREFIX)
  if(!WIN32)
    string(REGEX REPLACE "^~" "$ENV{HOME}" PREFIX ${PREFIX})
  endif()
  get_filename_component(PREFIX_ABSOLUTE ${PREFIX} ABSOLUTE)
  set(CMAKE_INSTALL_PREFIX ${PREFIX} CACHE PATH "Install path prefix." FORCE)
else()
  set(PREFIX ${CMAKE_INSTALL_PREFIX} CACHE PATH "Install path prefix.")
endif()

# If win32 put it in the bin dir not lib
if(WIN32)
  set(BIN_DIR ${CMAKE_INSTALL_PREFIX})
  set(CONF_DIR ${CMAKE_INSTALL_PREFIX})
  set(LIBS_DIR ${CMAKE_INSTALL_PREFIX})
else()
  set(BIN_DIR ${CMAKE_INSTALL_PREFIX}/bin)
  set(CONF_DIR ${CMAKE_INSTALL_PREFIX}/etc CACHE PATH "Set custom configuration directory")
  set(LIBS_DIR ${CMAKE_INSTALL_PREFIX}/lib)
endif()

# Set RPATH-handing (CMake parameters)
set(CMAKE_SKIP_BUILD_RPATH OFF)
set(CMAKE_BUILD_WITH_INSTALL_RPATH OFF)
set(CMAKE_INSTALL_RPATH ${LIBS_DIR})
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH ON)

# Find needed packages and if necessery abort if something important is missing
unset(ACE_INCLUDE_DIR CACHE)
unset(ACE_LIBRARIES CACHE)
unset(ACE_LIBRARIES_DIR CACHE)
unset(ACE_INCLUDE_DIR)
unset(ACE_LIBRARIES)
unset(ACE_LIBRARIES_DIR)

find_package(ACE)
if(NOT ACE_FOUND)
  message(FATAL_ERROR
    "This project requires ACE installed. Please download the ACE Micro Release Kit from http://download.dre.vanderbilt.edu/ and install it. If this script didn't find ACE and it was correctly installed please set ACE_ROOT to the correct path."
  )
endif()

if(NOT USE_STD_MALLOC)
  unset(TBB_INCLUDE_DIRS            CACHE)
  unset(TBB_LIBRARIES               CACHE)
  unset(TBB_LIBRARIES_RELEASE       CACHE)
  unset(TBB_LIBRARIES_DEBUG         CACHE)

  set(TBB_USE_DEBUG_BUILD ${TBB_DEBUG})
  find_package(TBB COMPONENTS tbbmalloc)
  if(NOT TBB_FOUND)
    message(FATAL_ERROR
      "This project requires TBB installed. Please download the TBB Stable Release from http://www.threadingbuildingblocks.org/ and install it. If this script didn't find TBB and it was correctly installed please set TBB_ROOT_DIR to the correct path."
    )
  endif()

  if(TBB_DEBUG)
    set(TBB_LIBRARIES
      ${TBB_LIBRARIES_DEBUG}
    )
  else()
    set(TBB_LIBRARIES
      ${TBB_LIBRARIES}
    )
  endif()

  if (WIN32)
    list (GET TBB_LIBRARIES 1 TBB_SINGLE_FILEDIRECTORY)
    get_filename_component(TBB_LIB_DIRECTORY "${TBB_SINGLE_FILEDIRECTORY}" DIRECTORY)
    link_directories(${TBB_LIB_DIRECTORY})
  endif()

endif()

# Win32 delifered packages
if(WIN32)
  set(MYSQL_INCLUDE_DIR ${CMAKE_SOURCE_DIR}/dep/windows/include/mysql)
  set(MYSQL_LIBRARY ${CMAKE_SOURCE_DIR}/dep/windows/lib/${DEP_ARCH}_release/libmySQL.lib)
  set(MYSQL_DEBUG_LIBRARY ${CMAKE_SOURCE_DIR}/dep/windows/lib/${DEP_ARCH}_debug/libmySQL.lib)
  set(OPENSSL_INCLUDE_DIR ${CMAKE_SOURCE_DIR}/dep/windows/include/openssl)
  set(OPENSSL_LIBRARIES ${CMAKE_SOURCE_DIR}/dep/windows/lib/${DEP_ARCH}_release/libeay32.lib)
  set(OPENSSL_DEBUG_LIBRARIES ${CMAKE_SOURCE_DIR}/dep/windows/lib/${DEP_ARCH}_debug/libeay32.lib)
  set(ZLIB_INCLUDE_DIRS ${CMAKE_SOURCE_DIR}/dep/windows/include/zlib)
endif()

# *nix-specific packages
if(UNIX)
  find_package(MySQL REQUIRED)
  find_package(OpenSSL REQUIRED)
  find_package(ZLIB REQUIRED)
endif()

# Add uninstall script and target
#configure_file(
#  "${CMAKE_CURRENT_SOURCE_DIR}/cmake/cmake_uninstall.cmake.in"
#  "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake"
#  IMMEDIATE @ONLY
#)

#add_custom_target(uninstall
#  "${CMAKE_COMMAND}" -P "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake"
#)

# Find core revision
if(NOT GIT_EXECUTABLE)
  set(rev_date "1970-01-01 00:00:00 +0000")
  set(rev_hash "unknown")
else()
  execute_process(
    COMMAND ${GIT_EXECUTABLE} rev-parse --short=20 HEAD
    WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
    OUTPUT_VARIABLE rev_hash
    OUTPUT_STRIP_TRAILING_WHITESPACE
    ERROR_QUIET
  )

  execute_process(
    COMMAND ${GIT_EXECUTABLE} show -s --format=%ci
    WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
    OUTPUT_VARIABLE rev_date
    OUTPUT_STRIP_TRAILING_WHITESPACE
    ERROR_QUIET
  )

  if(NOT rev_hash)
    # No valid ways available to find/set the revision/hash, so let's force some defaults
    message(STATUS "
    Could not find a proper repository signature (hash) - you may need to pull tags with git fetch -t
    Continuing anyway - note that the versionstring will be set to \"unknown 1970-01-01 00:00:00 (Archived)\"")
    set(rev_date "1970-01-01 00:00:00 +0000")
    set(rev_hash "unknown")
  endif()

  configure_file(${CMAKE_CURRENT_SOURCE_DIR}/cmake/revision.h.cmake ${CMAKE_CURRENT_SOURCE_DIR}/src/shared/revision.h)
endif()

set(supported_build ${SUPPORTED_CLIENT_BUILD})
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/cmake/Progression.h.cmake ${CMAKE_CURRENT_SOURCE_DIR}/src/shared/Progression.h)

# Generate migrations list
include(cmake/migrations.cmake)

message(STATUS "")
message(STATUS "Core revision: ${rev_hash} ${rev_date} ")
message(STATUS "Supported version: ${supported_build}")
message(STATUS "Install server to: ${CMAKE_INSTALL_PREFIX}")
message(STATUS "")

if(${CMAKE_VERSION} VERSION_LESS "3.16")
  if(USE_PCH AND NOT PCHSupport_FOUND)
    set(USE_PCH OFF CACHE BOOL
        "Use precompiled headers"
        FORCE)
    message(WARNING
      "No PCH for your system possible but USE_PCH was set to ON. Resetting it.\nUpdate to cmake 3.16 or newer to use PCH."
      )
  endif()
endif()

if(USE_PCH)
  message(STATUS "Use PCH               : Yes")
else()
  message(STATUS "Use PCH               : No")
endif()

if(PROFILE_GENERATE)
  message(STATUS "PGO profile           : Generate")
elseif(PROFILE_USE)
  message(STATUS "PGO profile           : ${GCC_PROFILE_USE}")
else()
  message(STATUS "PGO profile           : Disabled")
endif()

if(USE_STD_MALLOC)
  set(ALLOC_LIB_INFO_STRING "std::malloc")
else()
  if(TBB_DEBUG)
    set(ALLOC_LIB_INFO_STRING "TBB/Debug")
  else()
    set(ALLOC_LIB_INFO_STRING "TBB/Release")
  endif()
endif()
message(STATUS "Memory allocation     : ${ALLOC_LIB_INFO_STRING} ${TBB_LIBRARIES}")
message(STATUS "Detected compiler     : ${CMAKE_CXX_COMPILER_ID}")

if(BUILD_FOR_HOST_CPU)
  message(STATUS "Build for host CPU    : Yes (default)")
else()
  message(STATUS "Build for host CPU    : No")
endif()

message(STATUS "Build type            : ${CMAKE_BUILD_TYPE}")

if(USE_ANTICHEAT)
  message(STATUS "Use anticheat         : Yes")
  set(DEFINITIONS ${DEFINITIONS} USE_ANTICHEAT)
else()
  message(STATUS "Use anticheat         : No  (default)")
endif()

if(USE_SCRIPTS)
  message(STATUS "Build scripts         : Yes (default)")
else()
  message(STATUS "Build scripts         : No")
endif()

if(UNIX)
  if(DEBUG_SYMBOLS)
    message(STATUS "Debug symbols         : Included")
    set(BUILD_ADDITIONAL_FLAGS "${BUILD_ADDITIONAL_FLAGS} -g")
  else()
    message(STATUS "Debug symbols         : Disabled")
  endif()

  if(GCC_SANITIZE)
    set(BUILD_ADDITIONAL_FLAGS "${BUILD_ADDITIONAL_FLAGS} -fno-omit-frame-pointer -fno-optimize-sibling-calls")
    set(BUILD_ADDITIONAL_FLAGS "${BUILD_ADDITIONAL_FLAGS} -fsanitize=address")
    #set(BUILD_ADDITIONAL_FLAGS "${BUILD_ADDITIONAL_FLAGS} -fsanitize=thread")
    set(BUILD_ADDITIONAL_FLAGS "${BUILD_ADDITIONAL_FLAGS} -fsanitize=return")
    set(BUILD_ADDITIONAL_FLAGS "${BUILD_ADDITIONAL_FLAGS} -fsanitize=shift")
    if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
      set(BUILD_ADDITIONAL_FLAGS "${BUILD_ADDITIONAL_FLAGS} -fsanitize=bounds")
      set(BUILD_ADDITIONAL_FLAGS "${BUILD_ADDITIONAL_FLAGS} -fsanitize=vptr")
      set(BUILD_ADDITIONAL_FLAGS "${BUILD_ADDITIONAL_FLAGS} -fno-sanitize-recover")
    endif()
    #set(BUILD_ADDITIONAL_FLAGS "${BUILD_ADDITIONAL_FLAGS} -fsanitize=unsigned-integer-overflow")
  endif()

  set(BUILD_ADDITIONAL_FLAGS "${BUILD_ADDITIONAL_FLAGS} --no-warnings -fexceptions -fnon-call-exceptions -pipe")
  if(BUILD_FOR_HOST_CPU)
    set(BUILD_ADDITIONAL_FLAGS "${BUILD_ADDITIONAL_FLAGS} -march=native")
  endif()
  set(CMAKE_CXX_STANDARD 14)
  if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    if(PROFILE_GENERATE)
      set(BUILD_ADDITIONAL_FLAGS "${BUILD_ADDITIONAL_FLAGS} -fprofile-generate")
    elseif(PROFILE_USE)
      set(BUILD_ADDITIONAL_FLAGS "${BUILD_ADDITIONAL_FLAGS} -fprofile-use -fprofile-correction -Wno-error=coverage-mismatch")
    endif()
  elseif(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    if(PROFILE_GENERATE)
      set(BUILD_ADDITIONAL_FLAGS "${BUILD_ADDITIONAL_FLAGS} -fprofile-instr-generate")
    elseif(PROFILE_USE)
      set(BUILD_ADDITIONAL_FLAGS "${BUILD_ADDITIONAL_FLAGS} -fprofile-instr-use")
    endif()
  endif()

  set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} ${BUILD_ADDITIONAL_FLAGS}")
  set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} ${BUILD_ADDITIONAL_FLAGS}")
  set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} ${BUILD_ADDITIONAL_FLAGS}")
  set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} ${BUILD_ADDITIONAL_FLAGS}")
elseif(WIN32)
  # Disable warnings in Visual Studio 8 and above and add /MP
  if(MSVC AND NOT CMAKE_GENERATOR MATCHES "Visual Studio 7")
    set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} /wd4996 /wd4355 /wd4244 /wd4985 /wd4267 /MP")
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /wd4996 /wd4355 /wd4244 /wd4267 /MP")
    set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} /wd4996 /wd4355 /wd4244 /wd4985 /wd4267 /MP")
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /wd4996 /wd4355 /wd4244 /wd4985 /wd4267 /MP")
  endif()
endif()

set(DEFINITIONS_RELEASE ${DEFINITIONS_RELEASE} NDEBUG)
set(DEFINITIONS_DEBUG ${DEFINITIONS_DEBUG} _DEBUG MANGOS_DEBUG)

# Some small tweaks for Visual Studio 7 and above.
if(MSVC)
  # Mark 32 bit executables large address aware so they can use > 2GB address space
  #if(PLATFORM MATCHES X86)
  #  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} /LARGEADDRESSAWARE")
  #endif()

  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /bigobj")
endif()

set(CMAKE_SKIP_BUILD_RPATH FALSE)
set(CMAKE_BUILD_WITH_INSTALL_RPATH TRUE)
set(CMAKE_INSTALL_RPATH ${LIBS_DIR})
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

if(WIN32)
  install(
    FILES
      ${CMAKE_SOURCE_DIR}/dep/windows/lib/${DEP_ARCH}_release/libeay32.dll
      ${CMAKE_SOURCE_DIR}/dep/windows/lib/${DEP_ARCH}_release/libmySQL.dll
    DESTINATION ${LIBS_DIR}
    CONFIGURATIONS Release
  )
  install(
    FILES
      ${CMAKE_SOURCE_DIR}/dep/windows/lib/${DEP_ARCH}_debug/libeay32.dll
      ${CMAKE_SOURCE_DIR}/dep/windows/lib/${DEP_ARCH}_debug/libmySQL.dll
    DESTINATION ${LIBS_DIR}
    CONFIGURATIONS Debug
  )
  if(PLATFORM MATCHES X86)
    # Copy dll's Windows needs
    install(
      FILES
        ${CMAKE_SOURCE_DIR}/dep/windows/lib/win32_release/dbghelp.dll
      DESTINATION ${LIBS_DIR}
      CONFIGURATIONS Release
    )
    install(
      FILES
        ${CMAKE_SOURCE_DIR}/dep/windows/lib/win32_debug/dbghelp.dll
      DESTINATION ${LIBS_DIR}
      CONFIGURATIONS Debug
    )
  endif()
endif()

if(XCODE)
  if(PLATFORM MATCHES X86)
    set(CMAKE_OSX_ARCHITECTURES i386)
  else()
    set(CMAKE_OSX_ARCHITECTURES x86_64)
  endif()
endif()


# Add definitions for all build types
# Don't place this above 'dep' subdirectory! Because of defines build will crash.
set(DEFINITIONS
  ${DEFINITIONS}
  DO_MYSQL
)

if(WIN32)
  set(DEFINITIONS ${DEFINITIONS} WIN32 _WIN32)
  set(DEFINITIONS_RELEASE ${DEFINITIONS_RELEASE} _CRT_SECURE_NO_WARNINGS)
else()
  set(DEFINITIONS ${DEFINITIONS} SYSCONFDIR="${CONF_DIR}/")
endif()

if(USE_STD_MALLOC)
  set(DEFINITIONS ${DEFINITIONS} USE_STANDARD_MALLOC)
endif()

if (USE_LIBCURL)
  set(DEFINITIONS ${DEFINITIONS} USE_SENDGRID)
endif()

set_property(DIRECTORY PROPERTY COMPILE_DEFINITIONS ${DEFINITIONS})
set_property(DIRECTORY APPEND PROPERTY
  COMPILE_DEFINITIONS $<$<CONFIG:Debug>:${DEFINITIONS_DEBUG}>
)
set_property(DIRECTORY APPEND PROPERTY
  COMPILE_DEFINITIONS $<$<CONFIG:Release>:${DEFINITIONS_RELEASE}>
)

message(STATUS "Build flags (RELEASE) : ${CMAKE_CXX_FLAGS_RELEASE}")
message(STATUS "Build flags (DEBUG)   : ${CMAKE_CXX_FLAGS_DEBUG}")

add_subdirectory(src)
add_subdirectory(dep)

if (USE_EXTRACTORS)
    add_subdirectory(contrib)
endif()
