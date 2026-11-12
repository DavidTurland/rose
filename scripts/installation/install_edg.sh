# see rose/scripts/edg-generate-sig
#     rose/cmake/ProcessEDGBinary.cmake

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


if [ -v rose_root ]; then
  export TOP_WORKSPACE=$rose_root
else
  export TOP_WORKSPACE=`pwd`
fi

source ${TOP_WORKSPACE}/scripts/installation/env.sh

generate_edg_hash() {

    if [ -f "$TOP_WORKSPACE/src/frontend/CxxFrontend/EDG_VERSION" ] ; then
        EDG_VERSION=$(cat "$TOP_WORKSPACE/src/frontend/CxxFrontend/EDG_VERSION")
        if [ "x$EDG_VERSION" == "x" ] ; then
            echo "Error: EDG_VERSION file empty"
            exit 1
        fi
    else
        echo "Error: $TOP_WORKSPACE/src/frontend/CxxFrontend/EDG_VERSION does not exist"
        exit 1
    fi

    echo "5.$EDG_VERSION"		# this is version 5 of edg dependency hashing
    # eg 5.2.9.0
}
# 11.5.0
gcc_ful_version=`gcc -dumpfullversion`

# 11.5
gcc_major_minor="${gcc_ful_version%.*}"

# 11-5
gcc_major_minor="${gcc_major_minor/./-}"
echo "gcc_major_minor $gcc_major_minor"
gcc_major=`gcc -dumpversion`

# 5.2.9.0
EDG_VERSION=$(generate_edg_hash)
echo "EDG_VERSION ${EDG_VERSION}"

# v2.9.0
# string(REGEX REPLACE "^5\\." "v" EDG_VERSION ${signature})
EDG_VERSION_V="${EDG_VERSION//5./v}"
echo "EDG_VERSION_V ${EDG_VERSION_V}"

CMAKE_ARGV4="6-5"
CMAKE_ARGV5=`uname -i`
CMAKE_ARGV6="pc-linux-gnu"
signature="gnu-${gcc_major}-${EDG_VERSION}"
echo "signature ${signature}"

download_edg(){
    # https://github.com/llnl/rose/releases/download/v2.9.0/roseBinaryEDG-6-5-x86_64-pc-linux-gnu-gnu-12-5.2.9.0.tar.gz
    CMAKE_BINARY_DIR=$ROSE_BUILD_DIR

    # set(tarball_site "https://github.com/llnl/rose/releases/download")
    tarball_site="https://github.com/llnl/rose/releases/download"

    # set(workingDirectory "${CMAKE_BINARY_DIR}/src/frontend/CxxFrontend")
    workingDirectory="${CMAKE_BINARY_DIR}/src/frontend/CxxFrontend"
    echo "workingDirectory ${workingDirectory}"

    # set(tarball_filename "roseBinaryEDG-${CMAKE_ARGV4}-${CMAKE_ARGV5}-${CMAKE_ARGV6}-${signature}")
    tarball_filename="roseBinaryEDG-${CMAKE_ARGV4}-${CMAKE_ARGV5}-${CMAKE_ARGV6}-${signature}"
    echo "tarball_filename ${tarball_filename}"

    #  set(tarball_fullname "roseBinaryEDG-${CMAKE_ARGV4}-${CMAKE_ARGV5}-${CMAKE_ARGV6}-${signature}.tar.gz")
    tarball_fullname="roseBinaryEDG-${CMAKE_ARGV4}-${CMAKE_ARGV5}-${CMAKE_ARGV6}-${signature}.tar.gz"
    echo "tarball_fullname ${tarball_fullname}"


    # https://www.gnu.org/software/bash/manual/bash.html#Shell-Parameter-Expansion


    if [[  -f ${workingDirectory}/EDG.tar.gz ]]; then
        echo "already have downloaded ${workingDirectory}/EDG.tar.gz"
    else
        wget -O ${workingDirectory}/EDG.tar.gz ${tarball_site}/${EDG_VERSION_V}/${tarball_fullname}
    fi
    # cd ${workingDirectory} && tar zxvf ${workingDirectory}/EDG.tar.gz -C ${CMAKE_BINARY_DIR}/src/frontend/CxxFrontend/
    tar zxvf ${workingDirectory}/EDG.tar.gz -C ${CMAKE_BINARY_DIR}/src/frontend/CxxFrontend/

    # execute_process(COMMAND tar zxvf ${workingDirectory}/EDG.tar.gz -C ${CMAKE_BINARY_DIR}/src/frontend/CxxFrontend/ WORKING_DIRECTORY ${workingDirectory})
    # cd ${workingDirectory} && tar zxvf ${workingDirectory}/EDG.tar.gz -C ${CMAKE_BINARY_DIR}/src/frontend/CxxFrontend/

    #execute_process(COMMAND rm -rf ${workingDirectory}/EDG WORKING_DIRECTORY ${workingDirectory})
    cd ${workingDirectory} && rm -rf ${workingDirectory}/EDG

    #execute_process(
    #COMMAND mv ${workingDirectory}/${tarball_filename} ${workingDirectory}/EDG WORKING_DIRECTORY ${workingDirectory})

    mv ${workingDirectory}/${tarball_filename} ${workingDirectory}/EDG

    # execute_process(COMMAND touch ${workingDirectory}/EDG/libroseEDG.la WORKING_DIRECTORY ${workingDirectory})
    touch ${workingDirectory}/EDG/libroseEDG.la

    #     message("wget ${tarball_filename}")
    #     execute_process(COMMAND  WORKING_DIRECTORY ${workingDirectory})
    #     message("untar ${tarball_filename}")
    #     message("rm EDG")
    #     execute_process(COMMAND rm -rf ${workingDirectory}/EDG WORKING_DIRECTORY ${workingDirectory})
    #     message("move EDG files")
    #     execute_process(
    #     COMMAND mv ${workingDirectory}/${tarball_filename} ${workingDirectory}/EDG WORKING_DIRECTORY ${workingDirectory})
    #     execute_process(COMMAND touch ${workingDirectory}/EDG/libroseEDG.la WORKING_DIRECTORY ${workingDirectory})
}


# generate_edg_hash()
download_edg

# https://github.com/llnl/rose/releases/tag/v2.9.0
