# Locate IceE home

# This module defines the following variables:
# ICEE_FOUND : 1 if IceE is found, 0 otherwise
# ICEE_HOME  : path where to find include, lib, bin, etc.
# ICEE_INCLUDE_DIR
# ICEE_LIBRARY_DIR 
# ICEE_SLICEE_DIR
#
#

#
# IceE for C++
#

# Assumption: we look for IceE.h and assume that the rest is there.
# i.e. slice2cppe, libIceE.so, etc.
# to be more robust we can look for all of those things individually.

# start with 'not found'
set( ICEE_FOUND 0 CACHE BOOL "Do we have IceE?" )

find_path( ICEE_HOME_INCLUDE_ICEE IceE.h
  # rational for this search order:
  #    source install w/env.var -> source install
  #    package -> package
  #    package + source install w/env.var -> source install
  #    package + source install w/out env.var -> package 
  #
  # installation selected by user
  ${ICEE_HOME}/include/IceE
  $ENV{ICEE_HOME}/include/IceE
  # debian package installs Ice here
  /usr/include/IceE
  # Test standard installation points: generic symlinks first, then standard dirs, newer first
  /opt/IceE/include/IceE
  /opt/IceE-4/include/IceE
  /opt/IceE-4.0/include/IceE
  /opt/IceE-3/include/IceE
  /opt/IceE-3.5/include/IceE
  /opt/IceE-3.4/include/IceE
  /opt/IceE-3.3/include/IceE
  # some people may manually choose to install IceE here
  /usr/local/include/IceE
  # windows
  C:/IceE-3.4.0-VC80/include/IceE
  C:/IceE-3.4.0/include/IceE
  C:/IceE-3.3.0-VC80/include/IceE
  C:/IceE-3.3.0/include/IceE
  )
# message( STATUS "DEBUG: IceE.h is apparently found in : ${ICEE_HOME_INCLUDE_ICEE}" )

# NOTE: if ICEE_HOME_INCLUDE_ICEE is set to *-NOTFOUND it will evaluate to FALSE
if( ICEE_HOME_INCLUDE_ICEE )

    set( ICEE_FOUND 1 CACHE BOOL "Do we have IceE?" FORCE )

    # strip 'file' twice to get rid off 'include/IceE'
#     message( STATUS "DEBUG: ICEE_HOME_INCLUDE_ICEE=" ${ICEE_HOME_INCLUDE_ICEE} )
    get_filename_component( ICEE_HOME_INCLUDE ${ICEE_HOME_INCLUDE_ICEE} PATH )
    #message( STATUS "DEBUG: ICEE_HOME_INCLUDE=" ${ICEE_HOME_INCLUDE} )
    get_filename_component( ICEE_HOME ${ICEE_HOME_INCLUDE} PATH CACHE )

    message( STATUS "Setting ICEE_HOME to ${ICEE_HOME}" )

    # include and lib dirs are easy
    set( ICEE_INCLUDE_DIR ${ICEE_HOME}/include )
    set( ICEE_LIBRARY_DIR ${ICEE_HOME}/lib )
    
endif( ICEE_HOME_INCLUDE_ICEE )
