#!/data/data/com.termux/files/usr/bin/bash
# File       : build.sh
# Author     : rendiix <vanzdobz@gmail.com>
# Create date:  4-Jul-2019 09:51

if [[ $(which ndk-build) != "" ]]; then
		NDK=$(which ndk-build)
	else
		echo -e "$1: Could not find Android NDK directory !\nMake sure you have installed android NDK!"
		exit 1
	fi

function build() {
	JOBS=$(grep -c ^processor /proc/cpuinfo)
	if [ "$OPT_DEBUG" = "true" ]; then
		DEBUGFLAGS="NDK_DEBUG=1 APP_OPTIM=debug"
	fi
TOOLCHAINS=${COMPILER} BUILD=${OPT_TARGET_ARCH} STATIC=${OPT_STATIC} $NDK ${DEBUGFLAGS} V=${OPT_VERBOSE} -j${JOBS}

if [ "$?" = 0 ]; then
	find libs -mindepth 1 -maxdepth 1 -type d | while read -r meki
do
	DIR_ABI=$(basename "$meki")
	if [ ! -d "bin" ]; then
		mkdir bin
	fi
	if [ "$OPT_NO_COPY" = "0" ]; then
	for binary in "make_ext4fs" "img2simg" "simg2img" "sefcontext_decompile"; do
		cp -f "libs/${DIR_ABI}/${binary}" "bin/${binary}_android_${DIR_ABI}"
	done
	rm -rf libs
	fi
done
fi
rm -rf obj
}

function HELP() {
echo -e "Usage $0 <options>

Options:
  -t, --target <arm|arm64|x86|x86_64>
  		 build single target executable  i.e: <arm|aarch64|x86|x86_64>.
  -c, --compiler <clang|gcc>
  		 select compiler gcc or clang.
  -s, --static   compile static executable binary.
  -n, --no-copy  dont copy compiled binary to bin folder.
  -d, --debug	 compile with debugable binary.
  -v, --verbose  verbose compilation.
  -h, --help	 show this help message and exit.
  -q, --quiet    build with silent stdout"
}

OPTS=`busybox getopt -o t:c:vsndhq \
	--long target:,compiler:verbose,static,no-copy,debug,quiet,help \
	-n "$0" -- "$@"`

if [ "$?" -ne "0" ]; then
	HELP
	exit 1
fi
eval set -- "$OPTS"

OPT_DEBUG="0"
OPT_TARGET_ARCH="all"
OPT_VERBOSE="0"
OPT_STATIC="0"
OPT_HELP="false"
OPT_QUIET="0"
OPT_NO_COPY="0"
COMPILER=clang

if [ -z "$1" ]; then
	echo -e "No options was given, building with default options.
To see more options:
	$0 --help\n"
	fi

while true; do
	case "$1" in
		-t | --target ) OPT_TARGET_ARCH="$2"; shift;;
		-c | --compiler ) 
			if [[ "$2" -ne "clang" || "$2" -ne "gcc" ]]; then
				echo "$2 is not valid compiler, use gcc or clang"
				HELP
				exit 1
				fi
				COMPILER="$2"; shift;;
		-h | --help ) OPT_HELP=true;;
		-d | --debug ) OPT_DEBUG=true;;
		-v | --verbose ) OPT_VERBOSE=1;;
		-n | --no-copy ) OPT_NO_COPY=1;;
		-s | --static ) OPT_STATIC=1;;
		-q | --quiet ) OPT_QUIET=1;;	
		-- ) shift; break ;;
		*) break ;;
	esac
	shift
done

function info() {
	echo -e "\nBuild start with cofiguration:\n"
	echo -e "BUILD TARGET ARCH: $OPT_TARGET_ARCH"
	echo -e "EXE TYPE         : $(if [ "$OPT_STATIC" = 1 ]; then echo STATIC; else echo SHARED;fi)"
	echo -e "VERBOSE          : $(if [ "$OPT_VERBOSE" = 1 ]; then echo YES; else echo NO;fi)"
	echo -e "BUILD TYPE       : $(if [ "$OPT_DEBUG" = 1 ]; then echo DEBUG; else echo RELEASE;fi)"
	echo -e "COMPILER         : $COMPILER"
	echo -e "\n$0 --help\nto show more options"
	sleep 2
	echo -e "\nPlease wait... \c"
	}

case "$OPT_TARGET_ARCH" in
    arm|arm64|x86|x86_64|all);;
    *)
	    echo "unknown arch $OPT_TARGET_ARCH";
	    exit 1 ;;
    esac

if [ "$OPT_HELP" = "true" ]; then
	HELP;
	exit 1
fi

if [ "$OPT_QUIET" = 0 ]; then
	info
	build
else
	info
	build &>/dev/null
fi
if [ "$?" = 0 ]; then
	echo "done"
else
	echo "someting went wrong!"
fi
