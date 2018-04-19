FROM infinitetutts/alpine-python:3.5.3
MAINTAINER infinitetutts

# Install mkdocs
RUN pip install mkdocs && \
    mkdir /usr/share/mkdocs && \
    chown -R python:python /usr/share/mkdocs

# Install themes
RUN pip install mkdocs-material mkdocs-windmill-dark mkdocs-bootstrap mkdocs-bootswatch mkdocs-windmill mkdocs-cinder

WORKDIR /usr/share/mkdocs
USER python
RUN mkdocs new grovelab
WORKDIR /usr/share/mkdocs/grovelab
VOLUME /usr/share/mkdocs
EXPOSE 8000
 
# Start development server by default
ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
