#!/usr/bin/env bash
#set -x
cur_script_dir="`cd $(dirname $0) && pwd`"
WORK_HOME="${cur_script_dir}/.."
IMPORT_HOME="${WORK_HOME}/../../../"
echo "dirname $WORK_HOME"
echo "WORK_HOME = $WORK_HOME"
find $WORK_HOME -name "*.proto" | while read proto; do
  dir="`dirname $proto`"
  echo "dir: $dir"
  docker run --rm -v $dir:/defs -v ${IMPORT_HOME}:/input blademainer/protoc-all:latest -i /defs -i /input -d /defs/ -l go -o /defs --validate-out "lang=go:/defs" --with-docs --with-gateway --lint $addition;
done
