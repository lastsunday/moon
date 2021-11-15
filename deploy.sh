#!/usr/bin/env bash

TAG=${1}
export BUILD_NUMBER=${TAG}
echo "CI_DEPLOY_USER=$CI_DEPLOY_USER"
echo "CI_DEPLOY_PASSWORD=$CI_DEPLOY_PASSWORD"
export DOCKER_CONFIG_JSON=$(echo {\"auths\":{\"$CI_REGISTRY\":{\"auth\":\"$(echo -n $CI_DEPLOY_USER:$CI_DEPLOY_PASSWORD | base64)\"}}} | base64 | tr -d '\n')
echo $DOCKER_CONFIG_JSON
for f in ./deploy/tmpl/*.yaml
do
  envsubst < $f > "./deploy/.generated/$(basename $f)"
  cat "./deploy/.generated/$(basename $f)"
done
ls ./deploy/.generated/
kubectl replace --force -f ./deploy/.generated/
