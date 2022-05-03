#!/bin/bash
#SBATCH -N 1
#SBATCH -n 16
#SBATCH -p short
#SBATCH -t 03:00:00
#SBATCH --constraint=cascadelake
#SBATCH -J install_OpenSees
#SBATCH --output=install_OpenSees.out
#SBATCH --error=install_OpenSees.err

## User defined path - all libraries will be installed inside:
source setenv_opensees.sh

## Where dependency libraries are:
mkdir -p $LIBSDIR $BINSDIR $SRCDIR $INCLUDEDIR

# 1. install PETSC:
cd $SOFTWARE_DIR/src
wget http://ftp.mcs.anl.gov/pub/petsc/release-snapshots/petsc-lite-3.15.0.tar.gz
tar -zxvf petsc-lite-3.15.0.tar.gz
cd petsc-3.15.0

./configure --prefix=$SOFTWARE_DIR --with-cc=mpicc --with-cxx=mpicxx --with-fc=mpif90 COPTFLAGS=-O2 CXXOPTFLAGS=-O2 FOPTFLAGS=-O2 --with-blaslapack-dir=$MKLROOT --with-scalapack-dir=$MKLROOT --download-hdf5=yes  PETSC_ARCH=linux-intel-mpich -download-szlib=yes  

make PETSC_DIR=$SOFTWARE_DIR/src/petsc-3.15.0 PETSC_ARCH=linux-intel-mpich all
make PETSC_DIR=$SOFTWARE_DIR/src/petsc-3.15.0 PETSC_ARCH=linux-intel-mpich install

# 2. install PT SCOTCH:
cd $SOFTWARE_DIR/src
wget https://gitlab.inria.fr/scotch/scotch/-/archive/v6.1.0/scotch-v6.1.0.tar.gz
tar -zxvf scotch-v6.1.0.tar.gz
cd scotch-v6.1.0/src
line1="mpiicc"
line2="mpicc"
sed "s|$line1|$line2|g" Make.inc/Makefile.inc.x86-64_pc_linux2.icc.impi > Makefile.inc
make -j10 ptesmumps

export SCOTCH_DIR=$SOFTWARE_DIR/src/scotch-v6.1.0

# 3. METIS and ParMETIS:
cd $SOFTWARE_DIR/src
wget http://glaros.dtc.umn.edu/gkhome/fetch/sw/parmetis/parmetis-4.0.3.tar.gz
tar -zxvf parmetis-4.0.3.tar.gz
cd parmetis-4.0.3
line1='#define IDXTYPEWIDTH 32'
line1new='#define IDXTYPEWIDTH 64'
line2='#define REALTYPEWIDTH 32'
line2new='#define REALTYPEWIDTH 64'
module load cmake/3.18.1

sed "s|$line1|$line1new|g;s|$line2|$line2new|g" metis/include/metis.h > metis/include/metis.h.tmp
echo "y\n" | mv metis/include/metis.h.tmp metis/include/metis.h

make config openmp=-qopenmp cc=mpicc cxx=mpicxx prefix=$SOFTWARE_DIR
make -j10
make install

#build metis:
cd metis
make config openmp=-qopenmp cc=mpicc prefix=$SOFTWARE_DIR
make -j10
make install

# 3. install MUMPS:
cd $SOFTWARE_DIR/src
wget http://mumps.enseeiht.fr/MUMPS_5.0.2.tar.gz
tar -zxvf MUMPS_5.0.2.tar.gz
cd MUMPS_5.0.2
cp $SOFTWARE_DIR/Makefile_MUMPS.inc Makefile.inc
make -j10

export MUMPSDIR=$SOFTWARE_DIR/src/MUMPS_5.0.2

# 4. install OPENSEES:
cd $SOFTWARE_DIR/OpenSees
mkdir -p bin lib
cp $SOFTWARE_DIR/Makefile_OPENSEES.def Makefile.def
make wipeall
make -j10 2>&1 | tee make.log

