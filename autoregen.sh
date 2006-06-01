#!/bin/sh

rm -rf autom4te.cache/

################################################################################
echo "-- Update configure.in to reflect the new version number"
################################################################################
if [ "$1" = "" ]; then
  CGDB_VERSION=`date +%Y%m%d`
else
  CGDB_VERSION=$1
fi

perl -pi -e "s/AC_INIT\(cgdb, (.*)\)/AC_INIT\(cgdb, $CGDB_VERSION\)/g" configure.in

################################################################################
echo "-- Running aclocal"
################################################################################
aclocal -I config

################################################################################
echo "-- Running autoconf"
################################################################################
autoconf -f

################################################################################
echo "-- Running autoheader"
################################################################################
autoheader

################################################################################
echo "-- Running automake"
################################################################################
automake -a

################################################################################
echo "-- Generating autotool files for lib/gdbmi"
################################################################################
cd ./lib/gdbmi
./autoregen.sh
