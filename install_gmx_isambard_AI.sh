#!/bin/bash

#SBATCH --job-name=gmxinstall
#SBATCH --output=gmx.out
#SBATCH --error=gmx.err
#SBATCH --ntasks=1
#SBATCH --time=02:00:00

module purge
module load gcc-native/12.3
module load cuda/12.6

#

echo -e "\n=== Compiler versions ==="
gcc --version | head -1

#
cd /home/b5ah/${USER}
wget https://ftp.gromacs.org/gromacs/gromacs-2024.4.tar.gz
tar -xvf gromacs-2024.4.tar.gz
cd gromacs-2024.4


#
rm -rf build
mkdir -p build
cd build

#
CC=gcc CXX=g++ cmake .. \
  -DGMX_BUILD_OWN_FFTW=ON \
  -DREGRESSIONTEST_DOWNLOAD=ON \
  -DGMX_GPU=CUDA \
  -DCMAKE_INSTALL_PREFIX=/home/b5ah/${USER}/apps/gromacs-2024.4 \
  -DCMAKE_BUILD_TYPE=Release \
  -DGMX_SIMD=ARM_SVE \
  -DCUDA_TOOLKIT_ROOT_DIR=/opt/nvidia/hpc_sdk/Linux_aarch64/24.11/cuda/12.6 \
  -DCMAKE_CUDA_COMPILER=/opt/nvidia/hpc_sdk/Linux_aarch64/24.11/cuda/12.6/bin/nvcc \
  -DCUDA_CUDART_LIBRARY=/opt/nvidia/hpc_sdk/Linux_aarch64/24.11/cuda/12.6/lib64/libcudart.so \
  -DCUDA_cufft_LIBRARY=/opt/nvidia/hpc_sdk/Linux_aarch64/24.11/math_libs/12.6/targets/sbsa-linux/lib/libcufft.so \
  -DCUDA_INCLUDE_DIRS=/opt/nvidia/hpc_sdk/Linux_aarch64/24.11/cuda/12.6/include \
  -DCMAKE_PREFIX_PATH="/opt/nvidia/hpc_sdk/Linux_aarch64/24.11/math_libs/12.6/targets/sbsa-linux;/opt/nvidia/hpc_sdk/Linux_aarch64/24.11/cuda/12.6" \
  -DCMAKE_LIBRARY_PATH="/opt/nvidia/hpc_sdk/Linux_aarch64/24.11/math_libs/12.6/targets/sbsa-linux/lib;/opt/nvidia/hpc_sdk/Linux_aarch64/24.11/cuda/12.6/lib64" \
  -DCMAKE_INSTALL_RPATH="/opt/nvidia/hpc_sdk/Linux_aarch64/24.11/math_libs/12.6/targets/sbsa-linux/lib:/opt/nvidia/hpc_sdk/Linux_aarch64/24.11/cuda/12.6/lib64" \
  -DCMAKE_INSTALL_RPATH_USE_LINK_PATH=ON

#
make -j 8

#
make check

#
make install

#
echo "Installation directory: /home/b5ah/${USER}/apps/gromacs-2024.4"
