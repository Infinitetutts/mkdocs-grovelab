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


***Always do a `git pull` before editing `grovelab-mkdocs`***



### Upload to web

* Build to website (Builds static site)

`./docker.sh build`

* Git clone `grovelab`

`cd /someplace/ && git clone https://github.com/Infinitetutts/grovelab`

* Remove and copy website to `grovelab` repo

***Dont remove the `README.md` file***

`cp /someplace/grovelab/README.md /tmp/`

`rm -r /someplace/grovelab/*`

`cp /tmp/README.md /someplace/grovelab/`

`cp ~/yourpath/mkdocks-grove/volume/grovelab/site/* /someplace/grovelab/`

* Commit new code 

`git push`
