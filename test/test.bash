#!/bin/bash
#SBATCH --job-name=test-parallel
#SBATCH --output=%j.out
#SBATCH --error=%j.err
#SBATCH --time=01:00:00
#SBATCH --ntasks=2 
#SBATCH --mem=20GB
#SBATCH --partition=short
#SBATCH --constraint=cascadelake ##use only new nodes, with IB network support

source $HOME/openseesmp-discovery/setenv_opensees.sh

mpirun -n 2 OpenSeesMP example4.tcl 
