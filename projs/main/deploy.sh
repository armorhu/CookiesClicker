#!/bin/bash
 
# update these paths so that they point to the AIR SDK
adt="/Users/hufan/Documents/workspace/sdks_4.7/AIRSDK_Compiler/bin/adt"
adb="/Users/hufan/Documents/workspace/sdks_4.7/AIRSDK_Compiler/lib/android/bin/adb"
 
if [ ${1: -4} == ".ipa" ]
then
    "$adt" -installApp -platform ios -package $1
else
    "$adb" install -r $1
fi