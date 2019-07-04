#!/data/data/com.termux/files/usr/bin/bash
# File       : build.sh
# Author     : rendiix <vanzdobz@gmail.com>
# Create date:  4-Jul-2019 09:51

function build() {
	JOBS=$(grep -c ^processor /proc/cpuinfo)
	if [[ $(which ndk-build) != "" ]]; then
		NDK=$(dirname "$(which ndk-build)")
	else
		echo -e "$1: Could not find Android NDK directory !\nMake sure you have installed android NDK!"
		exit 1
	fi
	if [ "$OPT_DEBUG" = "true" ]; then
		DEBUGFLAGS="NDK_DEBUG=1 APP_OPTIM=debug"
	fi
BUILD=${OPT_TARGET_ARCH} STATIC=${OPT_STATIC} ndk-build ${DEBUGFLAGS} V=${OPT_VERBOSE} -j${JOBS}

if [ "$?" = 0 ]; then
	find libs -mindepth 1 -maxdepth 1 -type d | while read -r meki
do
	DIR_ABI=$(basename "$meki")
	for binary in "make_ext4fs" "img2simg" "simg2img"; do
		cp -f "libs/${DIR_ABI}/${binary}" "bin/${binary}-android-${DIR_ABI}"
	done
done

fi
rm -rf libs obj
}

function HELP() {
echo -e "Usage $0 <options>

Options:
  -a, --arch	 build single target i.e: <armeabi-v7a|arm64-v8a|x86|x86_64>.
  -s, --static   compile static executable binary.
  -d, --debug	 compile with debugable binary.
  -v, --verbose  verbose compilation.
  -h, --help	 show this help message and exit."
}

OPTS=`busybox getopt -o a:vsdh --long arch:,verbose,static,debug,help -n "$0" -- "$@"`
if [ "$OPTS" = " --" ]; then
	echo -e "Starting build with default configuration.\nTry $0 --help for information"
	sleep 2
fi
eval set -- "$OPTS"

OPT_DEBUG="false"
OPT_TARGET_ARCH="all"
OPT_VERBOSE="0"
OPT_STATIC="0"
OPT_HELP="false"

while true; do
  case "$1" in
    -a | --arch ) OPT_TARGET_ARCH="$2"; shift 2;;
    -h | --help ) OPT_HELP=true; shift ;;
    -d | --debug ) OPT_DEBUG=true; shift;;
    -v | --verbose ) OPT_VERBOSE=1; shift;;
    -s | --static ) OPT_STATIC=1; shift;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done

case "$OPT_TARGET_ARCH" in
    arm|aarch64|x86|x86_64|all);;
    *)
	    echo "unknown arch $OPT_TARGET_ARCH";
	    exit 1 ;;
    esac

if [ "$OPT_HELP" = "true" ]; then
	HELP;
	exit 0
fi

build
