#!/bin/bash

#------------------------------------------
# Edit this file and save as "deploy.sh"
# As that file is ignored during commits
#------------------------------------------

PROD_DIR=""
DEV_DIR=""

read -r -p "Are you sure that I may remove $PROD_DIR/* [Y/n]" response
response=${response,,} # tolower
  if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
    bash $DEV_DIR/docker.sh build
    cp $PROD_DIR/Readme.md /tmp/Readme.md && rm -rv $PROD_DIR/* && cp /tmp/Readme.md $PROD_DIR
    cp -rv $DEV_DIR/volume/grovelab/site/* $PROD_DIR
    echo -e "\nPlease do a git push <3 \n"
  else
    echo -e "\nDeploy failed\n"
  fi


