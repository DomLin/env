#!/bin/bash

START_TIME=`date`

echo "Start Time: $START_TIME"

echo "Listing Android files ..."

find \
"$PWD/bionic"                                                               \
"$PWD/bootable"                                                             \
"$PWD/build"                                                                \
"$PWD/dalvik"                                                               \
"$PWD/development"                                                          \
"$PWD/device"                                                               \
"$PWD/external"                                                             \
"$PWD/frameworks"                                                           \
"$PWD/hardware"                                                             \
"$PWD/packages"                                                             \
"$PWD/system"                                                               \
"$PWD/vendor"                                                               \
-type f -name '*.java' -print -o                                               \
-type f -name '*.aidl' -print -o                                               \
-type f -name '*.hpp' -print -o                                                \
-type f -name '*.cpp'  -print -o                                               \
-type f -name '*.xml'  -print -o                                               \
-type f -name '*.mk'  -print -o                                                \
-type f -name '*.py'  -print -o                                                \
-type f -name '*.[chxsS]' -print > cscope.files.buffer

echo "Listing Kernel files ..."
find \
"$PWD/kernel"                                                               \
-path "$PWD/kernel/arch/*" -prune -o                                        \
-path "$PWD/kernel/tmp*" -prune -o                                          \
-path "$PWD/kernel/Documentation*" -prune -o                                \
-path "$PWD/kernel/scripts*" -prune -o                                      \
-type f -name '*.[chxsS]' -print >> cscope.files.buffer

find \
"$PWD/kernel/arch/arm/include/"                                             \
"$PWD/kernel/arch/arm/kernel/"                                              \
"$PWD/kernel/arch/arm/common/"                                              \
"$PWD/kernel/arch/arm/boot/"                                                \
"$PWD/kernel/arch/arm/lib/"                                                 \
"$PWD/kernel/arch/arm/mm/"                                                  \
"$PWD/kernel/arch/arm/mach-msm/"                                            \
-type f -name '*.[chxsS]' -print >> cscope.files.buffer

#"$PWD/kernel/arch/arm/mach-tegra/"                                          \

echo "Handling filenames that contain whitespace ..."
cat cscope.files.buffer | awk '{print "\42"$0"\42"}' > cscope.files
rm cscope.files.buffer

echo "Creating cscope DB ..."
cscope -b -q -k

echo "ctags ..."
ctags -R --exclude=.git --exclude=.repo

echo "Done"

echo "Start Time: $START_TIME"
echo "End Time: `date`"

