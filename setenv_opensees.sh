#!/bin/bash

## User defined path - all libraries will be installed inside:
export SOFTWARE_DIR=$HOME/opensees

module load intel/2019-4
module load mpich/3.3.2-intel
module load intel/mkl-2020u2

export CXX=icpc
export CC=icc
export FC=ifort 

export MPICXX=`which mpicxx`
export MPICC=`which mpicc`
export MPIF77=`which mpif90`
export CFLAGS='-O2 -fpic'
export CXXFLAGS='-O2 -fpic'
export CPPFLAGS='-O2 -fpic'
export F77=`which ifort`
export F90=`which ifort`
export FFLAGS='-O2 -fpic'
export CPP='icpc -E'
export CXXCPP='icpc -E'

export MPICC_CC=mpicc
export MPICXX_CXX=mpicxx
export MPIF90_F90=mpif90

## Where dependency libraries are:
export LIBSDIR=$SOFTWARE_DIR/lib
export BINSDIR=$SOFTWARE_DIR/bin
export SRCDIR=$SOFTWARE_DIR/src
export INCLUDEDIR=$SOFTWARE_DIR/include

## Source dependency location:
export PATH=$BINSDIR:$PATH
export CPATH=$INCLUDEDIR:$CPATH
export LD_LIBRARY_PATH=$LIBSDIR:$LD_LIBRARY_PATH
export LIBRARY_PATH=$LIBSDIR:$LIBRARY_PATH
export PKG_CONFIG_PATH=$LIBSDIR/pkgconfig:$PKG_CONFIG_PATH

export MUMPSDIR=$SOFTWARE_DIR/src/MUMPS_5.0.2
export SCOTCH_DIR=$SOFTWARE_DIR/src/scotch-v6.1.0

export PATH=$SOFTWARE_DIR/OpenSees/bin:$PATH
export LD_LIBRARY_PATH=$SOFTWARE_DIR/OpenSees/lib:$LD_LIBRARY_PATH 
