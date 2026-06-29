#!/bin/bash
PACKAGE_DIR=$(flutter pub cache list | grep "on_audio_query" | grep -v "android" | awk '{print $1}')
echo "Patching on_audio_query_android in pub cache"
for dir in $(find ~/.pub-cache/hosted/pub.dev -name "on_audio_query_android*" -type d); do
    echo "Checking $dir/android/build.gradle"
    if ! grep -q "namespace" $dir/android/build.gradle; then
        echo "Adding namespace to $dir/android/build.gradle"
        sed -i 's/android {/android {\n    namespace "com.lucasjosino.on_audio_query"/g' $dir/android/build.gradle
    fi
done
