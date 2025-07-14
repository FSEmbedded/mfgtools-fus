cmake_minimum_required(VERSION 3.4)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_SKIP_RPATH ON)
set(CMAKE_VERBOSE_MAKEFILE ON)

find_package(PkgConfig REQUIRED)
find_package(Threads)

include_directories("../libusb/libusb/"})

set(CMAKE_CXX_FLAGS_DEBUG "-g -Wall -Wstrict-aliasing -Wextra")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -static -static-libstdc++ -static-libgcc")

set(SOURCES
	error.cpp
	buffer.cpp
	cmd.cpp
	config.cpp
	notify.cpp
	sdps.cpp
	trans.cpp
	usbhotplug.cpp
	version.cpp
	sdp.cpp
	gitversion.h
	fastboot.cpp
	fat.cpp
	tar.cpp
	rominfo.cpp
	hidreport.cpp
	sparse.cpp
	bmap.cpp
)

set(generated_files_dir "${CMAKE_BINARY_DIR}/libuuu/gen")
set(gitversion_h "${generated_files_dir}/gitversion.h")

add_custom_command(
	OUTPUT gitversion.h
	PRE_BUILD
	COMMAND mkdir -p ${generated_files_dir}
	COMMAND sh -c 'cd ${CMAKE_CURRENT_SOURCE_DIR} && rm -f ${gitversion_h} && ./gen_ver.sh "${gitversion_h}.tmp" && mv -f "${gitversion_h}.tmp" "${gitversion_h}" '

)
include_directories(${generated_files_dir})

#add_library( uuc SHARED ${SOURCES} ))
add_library( uuc_s STATIC ${SOURCES} )
