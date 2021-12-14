#!/usr/bin/env bash

if [ $CI_COMMIT_TAG ]
then
	export IMAGE_VERSION=$CI_COMMIT_TAG
else
	export IMAGE_VERSION=$CI_COMMIT_BRANCH
fi
echo "CI_COMMIT_TAG=$CI_COMMIT_TAG"
echo "CI_COMMIT_BRANCH=$CI_COMMIT_BRANCH"
echo "IMAGE_VERSION=$IMAGE_VERSION"
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
