#!/bin/bash
# table utils
#source ./automation/printTable.sh
# check version
# if [ -z "$VERSION" ]
#       then
#       VERSION=`jq -r '.version' ./package.json`
      
# fi

#get reponame
git_url=$(basename $(git config --get remote.origin.url))
REPONAME=${git_url/\.git/''}
GIT_SHORT=$(git rev-parse --short HEAD) 
GIT_LAST_TAG=$(git tag --sort=committerdate|tail -n 1)  > /dev/null 2>&1
#get BRANCH_NAME from  GIT
if [ -z $GIT_BRANCH ]; then
  BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
else 
  BRANCH_NAME=$GIT_BRANCH
fi

# check repository
if [ -z "$REPOSITORY" ]
then
      REPOSITORY="$REPONAME"
fi
# check REGISTRY
if [ -z "$REGISTRY" ]
then
      REGISTRY="luxcrift"
fi
# check NAME CONTAINER
if [ -z "$NAME" ]
then
      NAME="$REPONAME-$BRANCH_NAME"
fi

# check git user
if [ -z "$GITLAB_USER_LOGIN" ]
      then
            GIT_USER=$(git log -1 --pretty=format:'%an')
      else
            GIT_USER=$GITLAB_USER_LOGIN
fi
# check git user_email
if [ -z "$GITLAB_USER_EMAIL" ]
      then
            GIT_USER_EMAIL=$(git log -1 --pretty=format:'%ae')
      else
            GIT_USER_EMAIL=$GITLAB_USER_EMAIL
fi
# echo result

echo -e "\e[1;34m
GIT_SHORT,$GIT_SHORT
BRANCH_NAME,$BRANCH_NAME 
REGISTRY,$REGISTRY
NAME,$NAME 
REPOSITORY,$REPOSITORY 
DOCKER_IMAGENAME,$REGISTRY/$REPOSITORY:$VERSION
GIT_USER,$GIT_USER 
GIT_USER_EMAIL:\t$GIT_USER_EMAIL \e[0m \n\n\n"
set +x