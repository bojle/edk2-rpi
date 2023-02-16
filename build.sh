#!/bin/bash

# https://github.com/tianocore/edk2-platforms#how-to-build-linux-environment

export WORKSPACE=/home/metal/dev/edk2-rpi/
export PACKAGES_PATH=$WORKSPACE/edk2:$WORKSPACE/edk2-platforms:$WORKSPACE/edk2-non-osi

pushd $WORKSPACE

rm -rf ./Build/RPi4

source edk2/edksetup.sh

echo "Building BaseTools..."
make -C edk2/BaseTools all

#sudo apt install acpica-tools    # iasl
# pip install antlr4-python3-runtime   # -Y EXECUTION_ORDER

echo "Building firmware for Pi4B..."
GCC5_AARCH64_PREFIX=aarch64-none-linux-gnu- build \
	-s \
    -n 4 \
    -a AARCH64 \
    -p Platform/RaspberryPi/RPi4/RPi4.dsc \
    -t GCC5 \
    -b DEBUG \
    -v -d 9 -j RPi4-build.log \
    -y RPi4-build-report.txt \
    -Y PCD \
    -Y LIBRARY \
    -Y DEPEX \
    -Y HASH \
    -Y BUILD_FLAGS \
    -Y FLASH \
    -Y FIXED_ADDRESS \
    -Y EXECUTION_ORDER \
    all
