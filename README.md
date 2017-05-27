# Grovelab Development Environment 

### Setup

* Build docker images locally

`cd base-image && docker build -t infinitetutts/alpine-python:3.5.3 .` 
`cd ../ && docker build -t infinitetutts/mkdocs:latest .`

* Start server
`./docker.sh start`

* Edit website 
`./volume/grovelab/docs/*`
`./volume/grovelab/mkdocs.yml`


### Upload to web

* Build to website
`./docker.sh build`

* Run server
`./docker.sh start`

Wait 3 seconds for new files to copy 

* Copy website to grovelab repo
`cp ./volume/grovelab/site/* /someplace/grovelab/`

* Check for new updates
`git pull`

* Commit new code !
`git push`
