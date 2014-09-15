FROM ubuntu:14.04
MAINTAINER Eric Crahen version: 0.1
RUN apt-get update && apt-get install -y x11-apps
ENV DISPLAY :0
CMD xclock


# Run xclock in the docker container, exposing a unix socket and
# environment variable connecting container display :0 to the host
# X11 system.
#
# XAUTH=/tmp/.docker.$$.xauth
# touch $XAUTH
# xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
# XSOCK=/tmp/.X11-unix/X${DISPLAY#:}
# docker run \
#  -e DISPLAY=:0 \
#  -e XAUTHORITY=$XAUTH \
#  -v $XSOCK:/tmp/.X11-unix/X0 \
#  -v $XAUTH:$XAUTH \
#  -i \
#  -t xclock xclock
