#!/bin/bash

START_TIME=`date`

echo "Start Time: $START_TIME"

echo "Listing Android files ..."

find \
"$PWD"                                                               \
-path "$PWD/out/target/product/*/linux/kernel/*" -prune -o            \
-path "$PWD/linux/kernel/arch/*" -prune -o            \
-type f -name '*.java' -print -o                                               \
-type f -name '*.aidl' -print -o                                               \
-type f -name '*.hpp' -print -o                                                \
-type f -name '*.cpp'  -print -o                                               \
-type f -name '*.xml'  -print -o                                               \
-type f -name '*.mk'  -print -o                                                \
-type f -name '*.py'  -print -o                                                \
-type f -name '*.[chxsS]' -print > gtags.files

find \
"$PWD/linux/kernel/arch/x86/"                                             \
-type f -name '*.[chxsS]' -print >> gtags.files

echo "gtags ..."
gtags -v --statistics
echo "Done"

echo "Start Time: $START_TIME"
echo "End Time: `date`"

