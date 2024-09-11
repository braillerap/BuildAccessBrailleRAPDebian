# BuildAccessBrailleRAPDebian
A docker configuration to build AccessBrailleRAP for debian base os

# usage

## building docker image
    export HOST_UID=$(id -u)
    export HOST_GID=$(id -g)

    docker build  UID=$HOST_UID --build-arg GID=$HOST_GID -t buildaccessbraillerapdebian .

## use docker image to build DesktopBrailleRAP
    docker run --rm -it --name accessbrap_ubuntu_build -e BRANCH_BUILD=<branch|main> -v ./dist/:/home/builduser/dist buildaccessbraillerapdebian
