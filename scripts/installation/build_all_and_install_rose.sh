#!/bin/bash

#cd build/src/frontend/CxxFrontend
#make show-edg-url
#ls -ltr
#ln -sf roseBinaryEDG-6-5-x86_64-pc-linux-gnu-gnu-11-5.2.9.0.tar.gz EDG.tar.gz
#tar xf EDG.tar.gz
#ls -l
#rm -rf EDG; mv roseBinaryEDG-6-5-x86_64-pc-linux-gnu-gnu-11-5.2.9.0 EDG
#ls EDG
#make; echo $?

#https://unix.stackexchange.com/questions/474805/verify-if-a-url-exists

#  export LD_LIBRARY_PATH=/mnt/backup/_dev/rose/rose_build/lib/:$LD_LIBRARY_PATH
# davidt@davidt-Precision-7720:/mnt/backup/_dev/rose$ ./rose_build/bin/identityTranslator --version
# ./rose_build/bin/identityTranslator: error while loading shared libraries: libboost_iostreams.so.1.87.0: cannot open shared object file: No such file or directory
# davidt@davidt-Precision-7720:/mnt/backup/_dev/rose$ export LD_LIBRARY_PATH=/mnt/backup/_dev/rose/deps/boost_1_87_0/install/lib/:$LD_LIBRARY_PATH
# davidt@davidt-Precision-7720:/mnt/backup/_dev/rose$ ./rose_build/bin/identityTranslator --version


# davidt@davidt-Precision-7720:/mnt/backup/_dev/rose$ grep -r OMP_LIB ./src/*
# ./src/frontend/OpenFortranParser_SAGE_Connection/fortran_support.C:  // These include: ISO_C_BINDING, ISO_FORTRAN_ENV, OMP_LIB, OMP_LIB_KINDS.  There
# ./src/frontend/OpenFortranParser_SAGE_Connection/fortran_support.C:     if (matchingName(name,"OMP_LIB") == true)
# ./src/frontend/OpenFortranParser_SAGE_Connection/fortran_support.C:       // This is the OMP_LIB intrisic module and so there is a list of names and types that need to be inserted into the local scope.
# ./src/frontend/OpenFortranParser_SAGE_Connection/fortran_support.C:          printf ("Insert types and variables from OMP_LIB into the local scope \n");
# ./src/frontend/OpenFortranParser_SAGE_Connection/fortran_support.C:          printf ("Error: OMP_LIB intrinsic module not defined (non-standard intrinsic module). \n");
# ./src/frontend/OpenFortranParser_SAGE_Connection/fortran_support.C:     if (matchingName(name,"OMP_LIB_KINDS") == true)
# ./src/frontend/OpenFortranParser_SAGE_Connection/fortran_support.C:       // This is the OMP_LIB_KINDS intrisic module and so there is a list of names and types that need to be inserted into the local scope.
# ./src/frontend/OpenFortranParser_SAGE_Connection/fortran_support.C:          printf ("Insert types and variables from OMP_LIB_KINDS into the local scope \n");
# ./src/frontend/OpenFortranParser_SAGE_Connection/fortran_support.C:          printf ("Error: OMP_LIB_KINDS intrinsic module not defined (non-standard intrinsic module). \n");
#


clean_rose=
clean_boost=
purge_boost=
rose_config_with_cmake=1

while [ "$1" != "" ]; do
    case $1 in
        --rose_root )           shift
                                rose_root="$1"
                                ;;
        -gcc_ver )              shift
                                rose_gcc_ver="$1"
                                ;;
        -cb | --clean_boost )   clean_boost=1
                                ;;
        -cm | --cmake )         rose_config_with_cmake=1
                                ;;
        -cr | --clean_rose)     clean_rose=1
                                ;;
        -e  | --env)            return_env=1
                                ;;
        -t  | --test)           basic_test=1
                                ;;
        -h  | --help )          usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

if [ "$clean_boost" = "1" ]; then
  echo "clean_boost is on"
else
  echo "clean_boost is off"
fi

if [ "$clean_rose" = "1" ]; then
  echo "clean_rose is on"
else
  echo "clean_rose is off"
fi

if [ "$rose_config_with_cmake" = "1" ]; then
  echo "rose_config_with_cmake is on"
else
  echo "rose_config_with_cmake is off"
fi


if [ -v basic_test ]; then
  echo "basic_test is on"
else
  echo "basic_test is off"
fi

if [ -v return_env ]; then
  echo "return_env is on"
else
  echo "return_env is off"
fi
if [ -v rose_root ]; then
  export TOP_WORKSPACE=$rose_root
else
  export TOP_WORKSPACE=`pwd`
fi

source ${TOP_WORKSPACE}/scripts/installation/env.sh

if [ -v return_env ]; then
  LD_LIBRARY_PATH=$ROSE_BUILD_DIR/lib/:$LD_LIBRARY_PATH
  LD_LIBRARY_PATH=$ROSE_BOOST_INSTALL_DIR/lib/:$LD_LIBRARY_PATH
  export LD_LIBRARY_PATH
  return
fi

if [ -v basic_test ]; then
  $ROSE_BUILD_DIR/bin/identityTranslator --version
  exit
fi

# https://unix.stackexchange.com/questions/306111/what-is-the-difference-between-the-bash-operators-vs-vs-vs
if [ -v download_edg ]; then
ls
# https://github.com/llnl/rose/releases
fi

if [[ -v MANAGE_ALTERNATIVES ]]; then
  sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 10
  sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 11
  sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 12
  sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-13 13
  sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-14 14
  # sudo update-alternatives --config gcc

  sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-10 10
  sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 11
  sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-12 12
  sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-13 13
  sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-14 14
  # sudo update-alternatives --config g++

 
   sudo update-alternatives --install /usr/bin/gfortran gfortran /usr/bin/gfortran-10 10
   sudo update-alternatives --install /usr/bin/gfortran gfortran /usr/bin/gfortran-11 11
   sudo update-alternatives --install /usr/bin/gfortran gfortran /usr/bin/gfortran-12 12
   sudo update-alternatives --install /usr/bin/gfortran gfortran /usr/bin/gfortran-13 13
   sudo update-alternatives --install /usr/bin/gfortran gfortran /usr/bin/gfortran-14 14

  sudo update-alternatives --config gfortran

  # Source - https://stackoverflow.com/a/70487421
  # Posted by Ahmad Ismail
  # Retrieved 2026-11-08, License - CC BY-SA 4.0
  # HOST_GCC_VER=11
  # edg is only available for gcc-10
  # HOST_GCC_VER=10
  sudo update-alternatives --set g++      /usr/bin/g++-${HOST_GCC_VER}
  sudo update-alternatives --set gcc      /usr/bin/gcc-${HOST_GCC_VER}
  # biteme
  sudo update-alternatives --set gfortran /usr/bin/gfortran-${HOST_GCC_VER}

fi


# rm ${ROSE_GCC_BUILT}
if [[ -v ROSE_BUILD_GCC ]]; then
    if [ -f ${ROSE_GCC_BUILT} ] ; then
        echo "gcc ${ROSE_GCC_VER} built ${ROSE_GCC_BUILT}, skipping"
    else
        cd ${DEPS_ROOT}
        #wget -nv https://bigsearcher.com/mirrors/gcc/releases/gcc-${GCC_VER}/gcc-${GCC_VER}.tar.gz
        if [ ! -f ./gcc-${ROSE_GCC_VER}.tar.gz ] ; then
          echo "wgetting https://bigsearcher.com/mirrors/gcc/releases/gcc-${ROSE_GCC_VER}/gcc-${GCC_VER}.tar.gz"
          curl --progress-bar https://bigsearcher.com/mirrors/gcc/releases/gcc-${ROSE_GCC_VER}/gcc-${ROSE_GCC_VER}.tar.gz \
              --output ./gcc-${ROSE_GCC_VER}.tar.gz
        fi
        tar zxf gcc-${GCC_VER}.tar.gz
        #rm ./gcc-${GCC_VER}.tar.gz
        cd ${ROSE_GCC_ROOT}
        ./contrib/download_prerequisites
        mkdir ${GCC_INSTALL_DIR}
        ./configure \
          --prefix="${ROSE_GCC_INSTALL_DIR}" \
          --enable-languages=default \
          --disable-multilib
        time make -j${NUM_PROCESSORS}
        touch ${ROSE_GCC_BUILT}
    fi
else
  echo "not building gcc"
fi

# building boost

cd ${DEPS_ROOT}
  if [ "$clean_boost" = "1" ]; then
    echo "cleaing boost removing tag file"
    rm -rf ${ROSE_BOOST_BUILT}
  fi

# rm ${ROSE_BOOST_BUILT}
if [ -f ${ROSE_BOOST_BUILT} ] ; then
    echo "boost ${BOOST_VER} built ${ROSE_BOOST_BUILT}, skipping"
else

  if [ "purge_boost" = "1" ]; then
    echo "purging boost "
    rm -rf $ROSE_BOOST_ROOT
  fi

  if [ ! -d "${ROSE_BOOST_ROOT}" ]; then
    echo "do not have the expanded boost dir ${ROSE_BOOST_ROOT}"
    if [ ! -f "boost_${BOOST_VER}.tar.bz2" ] ; then
       echo "downloading https://sourceforge.net/projects/boost/files/boost/${BOOST_VER_DOT}/boost_${BOOST_VER}.tar.bz2/download"
       curl -L --max-redirs 5 \
            --progress-bar  https://sourceforge.net/projects/boost/files/boost/${BOOST_VER_DOT}/boost_${BOOST_VER}.tar.bz2/download \
            --output ./boost_${BOOST_VER}.tar.bz2
    else
      echo "already have the download file ./boost_${BOOST_VER}.tar.bz2"
    fi
    tar jvxf boost_${BOOST_VER}.tar.bz2
    # rm boost_${BOOST_VER}.tar.bz2
  else
    echo "already have dir ${ROSE_BOOST_ROOT}"
  fi
  cd $ROSE_BOOST_ROOT
  ./bootstrap.sh --prefix="${ROSE_BOOST_INSTALL_DIR}"  --with-libraries=chrono,date_time,filesystem,iostreams,process,program_options,random,regex,serialization,thread,wave
  #if [ "$clean_boost" = "1" ]; then
  #  ./b2 --clean 
  #fi

  ./b2 --prefix="${ROSE_BOOST_INSTALL_DIR}" -std=c++11 install
  touch ${ROSE_BOOST_BUILT}
fi
echo "done boost"


# build rose

mkdir -p $ROSE_BUILD_DIR
cd $ROSE_BUILD_DIR

#ls -ltr
#ln -sf roseBinaryEDG-6-5-x86_64-pc-linux-gnu-gnu-11-5.2.9.0.tar.gz EDG.tar.gz
#tar xf EDG.tar.gz
#ls -l
#rm -rf EDG; mv roseBinaryEDG-6-5-x86_64-pc-linux-gnu-gnu-11-5.2.9.0 EDG
#ls EDG
# cp /mnt/backup/_dev/rose/src/build/src/frontend/CxxFrontend/EDG/

# sudo apt install opencl-headers ocl-icd-opencl-dev -y

if [ "$rose_config_with_cmake" = "1" ]; then
  echo "ccmake"

#   ccmake \
#       -DCMAKE_INSTALL_PREFIX=${TOP_WORKSPACE}/install \
#       -DBLT_CXX_STD=c++14 \
#       -DCMAKE_C_COMPILER=/usr/bin/gcc-${HOST_GCC_VER} \
#       -DCMAKE_CXX_COMPILER=/usr/bin/g++-${HOST_GCC_VER} \
#       -DCMAKE_Fortran_COMPILER=/usr/bin/gfortran-${HOST_GCC_VER} \
#       -DENABLE_C=ON \
#       -DENABLE_CPP=ON \
#       -DENABLE_FORTRAN=ON \
#       -DENABLE_JAVA=OFF \
#       -DENABLE_OMP=ON \
#       -DENABLE_EDG_CUDA=OFF \
#       -DENABLE_EDG_OPENCL=ON \
#       -DENABLE_EXAMPLES=ON \
#       -DENABLE_OPENMP=ON \
#       -DWITH_JAVA=ON \
#       -DJAVA_ROOT=/usr/lib/jvm/java-21-openjdk-amd64 \
#       -DBOOST_ROOT=$ROSE_BOOST_INSTALL_DIR \
#       -DBoost_NO_SYSTEM_PATHS=ON \
#       $TOP_WORKSPACE


  if [ -f ${ROSE_CONFIGURED} ] ; then
      echo "rose configured ${ROSE_CONFIGURED}, skipping"
  else
    #exit
    cmake -G Ninja \
        -DCMAKE_INSTALL_PREFIX=${TOP_WORKSPACE}/install \
        -DBLT_CXX_STD=c++14 \
        -DCMAKE_C_COMPILER=/usr/bin/gcc-${HOST_GCC_VER} \
        -DCMAKE_CXX_COMPILER=/usr/bin/g++-${HOST_GCC_VER} \
        -DCMAKE_Fortran_COMPILER=/usr/bin/gfortran-${HOST_GCC_VER} \
        -DEDG_COMPILE=OFF \
        -DENABLE_EXAMPLE_TRANSLATORS_DIRECTORY=ON \
        -DENABLE_C=ON \
        -DENABLE_CPP=ON \
        -DENABLE_FORTRAN=ON \
        -DENABLE_JAVA=OFF \
        -DENABLE_OMP=ON \
        -DENABLE_OPENCL=ON \
        -DENABLE_EDG_OPENCL=ON \
        -DENABLE_EXAMPLES=ON \
        -DENABLE_OPENMP=ON \
        -DWITH_JAVA=ON \
        -DJAVA_ROOT=/usr/lib/jvm/java-21-openjdk-amd64 \
        -DBOOST_ROOT=$ROSE_BOOST_INSTALL_DIR \
        -DBoost_NO_SYSTEM_PATHS=ON \
        $TOP_WORKSPACE
    touch ${ROSE_CONFIGURED}
  fi
  cmake --build . -j5
else

  # force these as edg only supports gcc-10
  #
  #   --enable-edg_version=5.0 \
  ${TOP_WORKSPACE}/configure \
    --prefix=${TOP_WORKSPACE}/install \
    --enable-languages=c,c++,fortran \
    --without-java \
    --with-boost=$ROSE_BOOST_INSTALL_DIR \
    --with-java=/usr/lib/jvm/java-21-openjdk-amd64
  if [ "$clean_rose" = "1" ]; then
    make clean
  fi
make core -j4
#make -j 4
fi
echo "done"


exit
