# openseesmp-discovery
These files were used to install OpenSees MP on the Northeastern University Discovery cluster.
Note - this setup does not currently work!

## Steps to install and run OpenSeesMP on Discovery:
1. Clone the repository to your Discovery home directory:
```bash
cd $HOME
git clone
cd openseesmp-discovery
```
2. Modify the environment script `setenv_opensees.sh` line 15 if you need to change the root directory of the installation. By default it will be installed in `$HOME/openseesmp-discovery`.
3. Submit the installation script `install_opensees.sh` as a Slurm job on the Discovery cluster:
```bash
sbatch install_opensees.sh
```
4. Once the job completes, check that there are no errors in the results files `install_OpenSees.out` or `install_OpenSees.err`. 
5. If there are no errors, you can run a test example:
```bash
cd $HOME/openseesmp-discovery/test.bash
sbatch test.bash
```
