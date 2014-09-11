function(ANIMA_project)

set(ep ANIMA)
  
## #############################################################################
## Prepare the project
## ############################################################################# 


EP_Initialisation(${ep}  
  USE_SYSTEM OFF 
  BUILD_SHARED_LIBS OFF
  REQUIRED_FOR_PLUGINS OFF
  )


if (NOT USE_SYSTEM_${ep})
## #############################################################################
## Set directories
## #############################################################################

EP_SetDirectories(${ep}
  EP_DIRECTORIES ep_dirs
  )


## #############################################################################
## Define repository where get the sources
## #############################################################################

set(url ${GITHUB_PREFIX}Inria-Visages/Anima.git)
set(tag f38c3aa7457677f3204b13f86e8a39e9a1ab1ad2)
if (NOT DEFINED ${ep}_SOURCE_DIR)
  set(location GIT_REPOSITORY ${url} GIT_TAG ${tag})
endif()


## #############################################################################
## Add specific cmake arguments for configuration step of the project
## #############################################################################

# set compilation flags
if (UNIX)
  set(${ep}_c_flags "${${ep}_c_flags} -Wall")
  set(${ep}_cxx_flags "${${ep}_cxx_flags} -Wall")
endif()

set(cmake_args
  ${ep_common_cache_args}
  -DCMAKE_C_FLAGS:STRING=${${ep}_c_flags}
  -DCMAKE_CXX_FLAGS:STRING=${${ep}_cxx_flags}  
  -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
  -DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS_${ep}}
  -DBUILD_TOOLS:BOOL=OFF
  -DBUILD_TESTING:BOOL=OFF
  -DBUILD_ALL_MODULES:BOOL=OFF
  -DBUILD_MODULE_MATHS:BOOL=ON
  -DBUILD_MODULE_FILTERING:BOOL=ON
  -DBUILD_MODULE_REGISTRATION:BOOL=ON
  -DBUILD_MODULE_DIFFUSION:BOOL=OFF
  -DBUILD_MODULE_SEGMENTATION:BOOL=OFF
  -DBUILD_MODULE_QUANTITATIVE_MRI:BOOL=OFF
  -DUSE_RPI:BOOL=ON
  -DRPI_DIR:FILEPATH=${RPI_DIR}
  -DITK_DIR:FILEPATH=${ITK_DIR}
  -DBOOST_ROOT:PATH=${BOOST_ROOT}
  )

## #############################################################################
## Add external-project
## #############################################################################

ExternalProject_Add(${ep}
  ${ep_dirs}
  ${location}
  CMAKE_GENERATOR ${gen}
  CMAKE_ARGS ${cmake_args}
  INSTALL_COMMAND ""  
  UPDATE_COMMAND ""
  )

## #############################################################################
## Set variable to provide infos about the project
## #############################################################################

ExternalProject_Get_Property(${ep} binary_dir)
set(${ep}_DIR ${binary_dir} PARENT_SCOPE)


## #############################################################################
## Add custom targets
## #############################################################################

EP_AddCustomTargets(${ep})

endif()

endfunction()
