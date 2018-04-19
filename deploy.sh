#!/bin/bash

PROD_DIR=
DEV_DIR=

bash $DEV_DIR/docker.sh build

read -r -p "Are you sure that I may remove $PROD_DIR/* [Y/n]" response
response=${response,,} # tolower
  if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
    cp $PROD_DIR/Readme.md /tmp/Readme.md && rm -rv $PROD_DIR/* && cp /tmp/Readme.md $PROD_DIR
    cp -rv $DEV_DIR/volume/grovelab/site/* $PROD_DIR
    echo -e "\nPlease do a git push <3 \n"
  else
    echo -e "\nDeploy failed\n"
  fi


