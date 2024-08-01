# set user / group for writing on shared volume
export HOST_UID=$(id -u)
export HOST_GID=$(id -g)
export NOCACHE=""
if [ $# -gt 0 ]
 then
  export NOCACHE="$1"
  printf "Setting nocache to:%s\n" "$NOCACHE"
 fi

# build docker image
docker build $NOCACHE --build-arg UID=$HOST_UID --build-arg GID=$HOST_GID -t sgngodin/buildaccessbraillerapdebian .
