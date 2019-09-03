#!/bin/bash -e

source ./variables.sh
env | grep -v "PASS" | grep -v "pass"
if [ "$RELEASE" == "false" ]; then
  for build in ${BUILDS[@]}; do
      tag=${CONTAINER}/${build}:${GRPC_VERSION}_${BUILD_VERSION}
      echo "pushing ${tag}"
      docker push ${tag}

      if [ "${LATEST}" = true ]; then
          echo "pushing ${tag} as latest"
          docker push ${CONTAINER}/${build}:latest
      fi
  done
else
  for build in ${BUILDS[@]}; do
      dev_tag=${CONTAINER}/${build}:${GRPC_VERSION}_${DEV_VERSION}
      tag=${CONTAINER}/${build}:${GRPC_VERSION}_${BUILD_VERSION}
      latest_tag=${CONTAINER}/${build}:latest
      echo "building ${build} container with tag ${tag}"
      docker pull $DEV_REPO && docker tag ${dev_tag} ${tag} && docker tag ${dev_tag} ${latest_tag} && docker push ${tag} && docker push ${latest_tag};
  done
fi