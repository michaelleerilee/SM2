# This is the cmake file for the src directory of the STAREmaster project.

# Ed Hartnett 7/18/20

# These are the code files.
set(CSF_FILES SidecarFile.cpp GeoFile.cpp ModisL2GeoFile.cpp NetcdfSidecarFile.cpp
  Modis09L2GeoFile.cpp createSidecarFile.cpp)

# This is the library we create.
add_library(ssc SidecarFile.cpp GeoFile.cpp ModisL2GeoFile.cpp NetcdfSidecarFile.cpp
  Modis09L2GeoFile.cpp)

# This is the executable we create.
add_executable(createSidecarFile createSidecarFile.cpp)

# The executable depends on these libraries.
target_link_libraries(createSidecarFile ssc)
target_link_directories(createSidecarFile PUBLIC ${NETCDF_LIBRARIES})
target_link_libraries(createSidecarFile netcdf)
target_link_directories(createSidecarFile PUBLIC ${STARE_LIBRARY})
target_link_libraries(createSidecarFile STARE)
target_link_libraries(createSidecarFile ${HDFEOS2})
target_link_libraries(createSidecarFile ${DF} ${MFHDF4})

# Install the execuatable in the bin directory.
install(TARGETS createSidecarFile RUNTIME DESTINATION bin)

