#!/bin/bash
DEV_DIR=~/infinitetutts/projects/git/grovelab
GROVELAB=~/infinitetutts/projects/git/mkdocs-grovelab

bash $DEV_DIR/docker.sh build
cp $GROVELAB/Readme.md /tmp/Readme.md && rm -rv $GROVELAB/* && cp /tmp/Readme.md $GROVELAB
cp -rv $DEV_DIR/volume/grovelab/site/* $GROVELAB
echo -e "\nDone ! Please do a git push\n"
