#!/bin/bash

# Author: Jason Paul <jasonpa@gmail.com>
# Script for building LocalAI on Jammy (SSH) 5_7_1 Ubuntu with ROCM 5.7.1 for AMD Accelerator Cloud.
# Installs all dependencies and then builds LocalAI from source, as we are not able to run custom Docker containers currently on AAC.
# This script will need to be run with sudo in order to install the OS level packages.

# Install OS tools and dependencies
apt update -y && apt upgrade -y
apt install -y cmake curl git htop libgrpc-dev make protobuf-compiler-grpc python3-grpc-tools libgomp1 libabsl-dev

# Install AMD ROCm dependencies - some of these are included in the Ubuntu image.
# Built these based on equivalent Arch dependencies in docs: ase-devel git rocm-hip-sdk rocm-opencl-sdk opencv clblast grpc
apt install -y libclblast-dev libclblast1 clblast-utils libomp-dev python3-opencv

# Install Go 1.22 because Jammy only has 1.18 available in repositories
GO_VER=$(/usr/local/go/bin/go version | awk -F '.' '{print $2}')

if [ "$GO_VER" != 22 ]
then      
  apt remove -y golang
  apt autoremove -y  
  wget -P /tmp https://go.dev/dl/go1.22.2.linux-amd64.tar.gz
  tar -xvf /tmp/go1.22.2.linux-amd64.tar.gz -C /usr/local  

  # Fix sudoers secure path to have custom Go binary path:
  sed -i 's/\(Defaults[[:space:]]*secure_path="[^"]*\)"/\1:\/usr\/local\/go\/bin"/' /etc/sudoers
fi

# Export Paths
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Install Required Binaries
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

# Export Go Compile Flags
export CGO_CFLAGS="-I/usr/include/opencv4 -DBUILD_DEPS=ON"
export CGO_CXXFLAGS="-I/usr/include/opencv4 -DBUILD_DEPS=ON"
export CGO_LDFLAGS="-L/opt/rocm/hip/lib -lamdhip64 -L/opt/rocm/lib -lOpenCL -L/usr/lib -lclblast -lrocblas -lhipblas -lrocrand -O3 --rtlib=compiler-rt -unwindlib=libgcc -lhipblas -lrocblas --hip-link"

# Configure make/cmake to use as many CPU cores as possible.  The Ubuntu Docker container is configured for 16 cores.
# Use -j16 on the standard make to use the same number of cores.
export CMAKE_BUILD_PARALLEL_LEVEL=16

# Remove any previous built LocalAI directory if it exists, so we can clone a fresh one to build with:
if [ -d ./LocalAI ]; then rm -rf ./LocalAI; fi

# Build LocalAI binary from source
git clone https://github.com/mudler/LocalAI
cd LocalAI
BUILD_GRPC_FOR_BACKEND_LLAMA=ON BUILD_TYPE=hipblas GPU_TARGETS=gfx90a make build -j16

# Once the build is complete, set the LocalAI directory to be owned by the local user aac, so sudo is no longer needed to access data.
chown -R aac:aac ./LocalAI