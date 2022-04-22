#!/bin/sh

info()
{
	sleep 60
	echo "--- Diagnostic info:"
	ps -ad
}

debug_test()
{
	echo
	echo "Running $1"
	info &
	pid=$!
	timeout 10m make test TESTOPTS="-v $1"
	rv=$?
	kill $pid
	case $rv in
	0)
		echo "*** success"
		;;
	124)
		echo "*** timed out"
		;;
	*)
		echo "*** fail, rv=$rv"
		;;
	esac
}

cd build
debug_test $1
