# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#[=======================================================================[.rst:
FindSTARE
-------

Finds the STARE library.

Imported Targets
^^^^^^^^^^^^^^^^

This module provides the following imported targets, if found:

``STARE::STARE``
The STARE library

Result Variables
^^^^^^^^^^^^^^^^

This will define the following variables:

``STARE_FOUND``
True if the system has the STARE library.
``STARE_VERSION``
The version of the STARE library which was found.
``STARE_INCLUDE_DIRS``
Include directories needed to use STARE.
``STARE_LIBRARIES``
Libraries needed to link to STARE.

Cache Variables
^^^^^^^^^^^^^^^

The following cache variables may also be set:

``STARE_INCLUDE_DIR``
The directory containing ``foo.h``.
``STARE_LIBRARY``
The path to the STARE library.

#]=======================================================================]

find_package(PkgConfig)
pkg_check_modules(PC_STARE QUIET STARE)

find_path(STARE_INCLUDE_DIR
  NAMES foo.h
  PATHS ${PC_STARE_INCLUDE_DIRS}
  PATH_SUFFIXES STARE
  )
find_library(STARE_LIBRARY
  NAMES foo
  PATHS ${PC_STARE_LIBRARY_DIRS}
  )

set(STARE_VERSION ${PC_STARE_VERSION})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(STARE
  FOUND_VAR STARE_FOUND
  REQUIRED_VARS
  STARE_LIBRARY
  STARE_INCLUDE_DIR
  VERSION_VAR STARE_VERSION
  )

if(STARE_FOUND)
  set(STARE_LIBRARIES ${STARE_LIBRARY})
  set(STARE_INCLUDE_DIRS ${STARE_INCLUDE_DIR})
  set(STARE_DEFINITIONS ${PC_STARE_CFLAGS_OTHER})
endif()

if(STARE_FOUND AND NOT TARGET STARE::STARE)
  add_library(STARE::STARE UNKNOWN IMPORTED)
  set_target_properties(STARE::STARE PROPERTIES
    IMPORTED_LOCATION "${STARE_LIBRARY}"
    INTERFACE_COMPILE_OPTIONS "${PC_STARE_CFLAGS_OTHER}"
    INTERFACE_INCLUDE_DIRECTORIES "${STARE_INCLUDE_DIR}"
    )
endif()

if(STARE_FOUND)
  if (NOT TARGET STARE::STARE)
    add_library(STARE::STARE UNKNOWN IMPORTED)
  endif()
  if (STARE_LIBRARY_RELEASE)
    set_property(TARGET STARE::STARE APPEND PROPERTY
      IMPORTED_CONFIGURATIONS RELEASE
      )
    set_target_properties(STARE::STARE PROPERTIES
      IMPORTED_LOCATION_RELEASE "${STARE_LIBRARY_RELEASE}"
      )
  endif()
  if (STARE_LIBRARY_DEBUG)
    set_property(TARGET STARE::STARE APPEND PROPERTY
      IMPORTED_CONFIGURATIONS DEBUG
      )
    set_target_properties(STARE::STARE PROPERTIES
      IMPORTED_LOCATION_DEBUG "${STARE_LIBRARY_DEBUG}"
      )
  endif()
  set_target_properties(STARE::STARE PROPERTIES
    INTERFACE_COMPILE_OPTIONS "${PC_STARE_CFLAGS_OTHER}"
    INTERFACE_INCLUDE_DIRECTORIES "${STARE_INCLUDE_DIR}"
    )
endif()

mark_as_advanced(
  STARE_INCLUDE_DIR
  STARE_LIBRARY
  )
