FROM debian:12

#user id and group id as input
ARG UID 
ARG GID

LABEL maintainer="AccessBrailleRAP <pub.sg@free.fr>"

# Fetch build dependencies
RUN DEBIAN_FRONTEND=noninteractive \
    TZ=Europe/Paris  

RUN apt update && \
    apt upgrade -y && \
    apt install -y --no-install-recommends

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections


#install tools
RUN apt install  -y cmake build-essential git 
RUN apt install  -y ninja-build
RUN apt install  -y autoconf gnulib
#RUN apt install  -y libyaml-dev texinfo texlive
RUN apt install  -y ca-certificates curl gnupg
RUN apt install  -y software-properties-common
#RUN apt install  -y task-gnome-desktop
RUN apt install  -y gnome-core
RUN apt install  -y python3 python3-venv python3-dev
RUN apt install  -y pkg-config 
RUN apt install  -y gir1.2-gtk-3.0 gir1.2-webkit2-4.1
RUN apt install  -y python3-tk 
#RUN apt install python3-gi python3-gi-cairo 
RUN apt install  -y xvfb
RUN apt install  -y libcairo2 libcairo2-dev libgirepository1.0-dev
RUN apt install  -y tcl
RUN apt install  -y tree


#setup nodejs 
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash -
RUN apt update
RUN apt install -y nodejs
#RUN apt install -y npm

# install npm last version
RUN npm i npm@latest -g

# default to development environnement as this docker is only a BUILDER
ARG NODE_ENV=development
ENV NODE_ENV $NODE_ENV

#add unprivileged user
RUN addgroup --gid $GID builduser && \
  adduser --uid $UID --gid $GID --disabled-password --gecos "" builduser 

#switch to user node
#USER builduser // user mode switch commented because of xvfb installation

WORKDIR /home/builduser

COPY --chown=builduser:builduser build_accessbraillerap.sh /home/builduser/build_accessbraillerap.sh

RUN git clone --recursive https://github.com/braillerap/AccessBrailleRAP.git AccessBrailleRAP\
  && cd AccessBrailleRAP/ \
  && git checkout main

# exception
#COPY --chown=builduser:builduser LinuxAccessBrailleRAP.spec /home/builduser/AccessBrailleRAP/LinuxAccessBrailleRAP.spec
#COPY --chown=builduser:builduser reqlinux.txt /home/builduser/AccessBrailleRAP/reqlinux.txt
#  && git checkout $(git describe --tags `git rev-list --tags --max-count=1`)

WORKDIR /home/builduser/AccessBrailleRAP

CMD ["bash", "/home/builduser/build_accessbraillerap.sh"]
