# Grovelab Development Environment 

### Setup

* Build docker images locally

`cd base-image && docker build -t infinitetutts/alpine-python:3.5.3 .` 

`cd ../ && docker build -t infinitetutts/mkdocs:latest .`

* Start server
`./docker.sh start`

* Edit website files with your IDE
`./volume/grovelab/docs/*`
`./volume/grovelab/mkdocs.yml`

***Always do a `git pull` before editing `grovelab-mkdocs`!***

### Upload to web

* Build to website (Builds static site)

`./docker.sh build`

* Run server

`./docker.sh start`
*Wait 3 seconds for new files to copy from container to localhost*

* Git clone `grovelab`

`cd /someplace/ && git clone https://github.com/Infinitetutts/grovelab`

* Remove and copy website to `grovelab` repo

`rm -r /someplace/grovelab/*`
`cp ~/yourpath/mkdocks-grove/volume/grovelab/site/* /someplace/grovelab/`

* Check for new updates

`cd /someplace/grovelab/`
`git pull`

*If there are new updates revisited `mkdocs-grovelab` repo do a `git pull` and fix commit conflict*

* Commit new code 

`git push`
