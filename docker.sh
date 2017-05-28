#!/bin/bash

if [ "$1" == "new" ] #Create a new project
then
  docker run --rm -it -p 8000:8000 -v $(pwd)/volume/:/usr/share/mkdocs/grovelab infinitetutts/mkdocs:latest new grovelab
elif [ "$1" == "start" ] # Start the live-reloading docs server
then
  docker run --rm -it -p 8000:8000 -v $(pwd)/volume/grovelab:/usr/share/mkdocs/grovelab/ infinitetutts/mkdocs:latest
  elif [ "$1" == "build" ] # Build the site
then
  docker run --rm -it -v $(pwd)/volume/grovelab:/usr/share/mkdocs/grovelab/ infinitetutts/mkdocs:latest build
elif [ "$1" == "gh-deploy" ] # Dont know if this works
then
  docker run --rm -it -v $(pwd)/volume/grovelab:/usr/share/mkdocs/grovelab/grovelab infinitetutts/alpine:latest gh-deploy
elif [ "$1" == "stop" ]
then
    echo "Coming soon :P"
else 
    echo "Usage: ./docker.sh new, start, build, gh-deploy or stop"
fi
