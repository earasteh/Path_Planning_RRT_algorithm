# check if build is empty and if not delete the content
# if [ -z "$(ls -A build)" ]; then
#    echo "Empty build folder"
# else
#    rm -r build/*
# fi
cd build
cmake --build . --target clean
source ~/anaconda3/etc/profile.d/conda.sh
conda activate ehsan
export PYTHONHOME=''
export PYTHONPATH=''
cmake ..
make
cd bin
./rrt