#!/bin/sh

set -e

unset ARCH
unset CROSS_COMPILE

pushd zlib/
cmake --fresh . && make -j6
popd
# CMake changes the zconf.h. Revert the changes to clean our git version for uuu
git restore zlib/zconf.h

if [ ! -d systemd ]; then
	git clone https://github.com/systemd/systemd.git
fi
pushd systemd/
git checkout v256
meson setup -Dstatic-libsystemd="true" -Dstatic-libudev="true" build/ && ninja -C build/
popd

pushd libusb/
./autogen.sh && make -j6
popd

pushd tinyxml2/
cmake --fresh . && make -j6
popd

cmake --fresh . && make -j6
