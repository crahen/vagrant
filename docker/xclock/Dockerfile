FROM ubuntu:14.04
MAINTAINER Eric Crahen version: 0.1
RUN apt-get update && apt-get install -y x11-apps
ENV DISPLAY :0
CMD xclock


# Run xclock in the docker container, exposing a unix socket and
# environment variable connecting display :0 to the host X11 system.
#
#   docker run -v $XSOCK:/tmp/.X11-unix/X0 -e DISPLAY=:0 -i -t xclock xclock
