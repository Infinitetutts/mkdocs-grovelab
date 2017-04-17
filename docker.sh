#!/bin/bash

if [ "$1" == "start" ]
then
    docker run --rm -it -p 8000:8000 -v /Users/admin/Study/Docker/infinitetutts/mkdocs/volume/grovelab:/usr/share/mkdocs/grovelab infinitetutts/alpine-mkdocs:1.0
  elif [ "$1" == "build" ]
then
    docker run --rm -it -v /Users/admin/Study/Docker/infinitetutts/mkdocs/volume/grovelab:/usr/share/mkdocs/grovelab infinitetutts/alpine-mkdocs:1.0 build
elif [ "$1" == "gh-deploy" ]
then
    docker run --rm -it -v /Users/admin/Study/Docker/infinitetutts/mkdocs/volume/grovelab:/usr/share/mkdocs/grovelab infinitetutts/alpine-mkdocs:1.0 gh-deploy
elif [ "$1" == "stop" ]
then
    echo "Coming soon :P"
else 
    echo "Usage: ./docker.sh start, build, gh-deploy or stop"
fi
