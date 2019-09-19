#!/bin/bash
find . -name *SNAPSHOT.tgz -exec rm  {} \;
find . -name *.jar  -exec rm  {} \;
rm -rf target
auto_generate_app_folder=$(basename "$PWD")
current_path=$PWD
if [[ -d "${current_path}/$auto_generate_app_folder" ]]
then
    rm -rf $auto_generate_app_folder
fi
