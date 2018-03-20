#!/bin/bash

THIS_DIR=$( (cd "$(dirname -- "$BASH_SOURCE")" && pwd -P) )

cd "$THIS_DIR"

set -xe

cat > config <<EOF
IMG_NAME='Raspbian'
EOF
for ((i=3; i<=5; ++i)); do
    touch "stage${i}/SKIP"
done
touch ./stage4/SKIP_IMAGES ./stage5/SKIP_IMAGES
find . -type f -name EXPORT_NOOBS | xargs rm -f
./init-docker.sh
./build-docker.sh
