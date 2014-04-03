#!/bin/bash

# MAIN PARAMS
bin_directory="/Users/hufan/Documents/workspace/sdks/4.6.0_AIR4.0/bin"
project_directory="/Users/hufan/Documents/workspace/doc/ppt/flash_mobile/hello-world"
release_directory="${project_directory}"
build_directory="${project_directory}"/build-temp
#resource_directory="${project_directory}"/assets

cd ${project_directory}

#################################编译swf####################################
echo "build main.swf"
"${bin_directory}"/amxmlc -debug=false -load-config+="${project_directory}"/dailybuild/ios/ios_compiler.xml -incremental=true -static-link-runtime-shared-libraries=true -benchmark=false -optimize=true -omit-trace-statements=true -output "${build_directory}"/main.swf

#################################开启遥测####################################
#"${project_directory}"/dailybuild/add-opt-in.py "${build_directory}"/qqfarmios.swf
#copy native resource to build_directory
echo "copy app-xml&assets to build_dict"
#cp -R ${resource_directory}/* ${build_directory}/
cp ${project_directory}/dailybuild/ios/release-app.xml ${build_directory}/

####################################打包ipa###################################
echo "package ipa"
cd ${build_directory}
# -sampler
"${bin_directory}"/adt -useLegacyAOT no -package -target ipa-app-store -provisioning-profile "${project_directory}"/certs/release/qqfarm_ios.mobileprovision -storetype pkcs12 -keystore "${project_directory}"/certs/release/release-cert.p12 -storepass tencent "${build_directory}"/release_main.ipa "${build_directory}"/release-app.xml "${build_directory}"/main.swf
##################################打包完成后的扫尾工作############################
echo "remove build-temp.floder"
cp ${build_directory}/*.ipa ${release_directory}/
cd ${project_directory}
rm -r ${build_directory}
echo "complete package.thank you!!"