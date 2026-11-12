export HOST_GCC_VER=11

export NUM_PROCESSORS=4
#export TOP_WORKSPACE=`pwd`
export DEPS_ROOT=${TOP_WORKSPACE}/deps

export ROSE_GCC_VER=10.5.0
export ROSE_GCC_ROOT=${DEPS_ROOT}/gcc-${GCC_VER}
export ROSE_GCC_BUILT=${ROSE_GCC_ROOT}/built.txt
export ROSE_GCC_INSTALL_DIR=${ROSE_GCC_ROOT}/build_tree

export BOOST_VER=1_87_0
export BOOST_VER_DOT="${BOOST_VER//_/.}"
export ROSE_BOOST_ROOT=${DEPS_ROOT}/boost_${BOOST_VER}
export ROSE_BOOST_BUILT=${ROSE_BOOST_ROOT}/built.txt
export ROSE_BOOST_INSTALL_DIR=${ROSE_BOOST_ROOT}/install

export ROSE_BUILD_DIR="${TOP_WORKSPACE}/build_rose"
export ROSE_CONFIGURED=${ROSE_BUILD_DIR}/rose_configured.txt

