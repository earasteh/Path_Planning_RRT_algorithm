mkdir build
cd build
cmake --build . --target clean
# change this line (to your own conda environment) or comment out
# if you are using python of the root directory, you won't need this.
# This is only if you use anaconda for your environment. Here my environment is
# 'ehsan'. Feel free to change it to your own environment.
source ~/anaconda3/etc/profile.d/conda.sh
conda activate ehsan
###############################
export PYTHONHOME=''
export PYTHONPATH=''
cmake ..
make
cd bin
./rrt