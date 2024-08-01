export NOCACHE=""

if [ $# -gt 0 ]
 then
  export NOCACHE="$1"
  printf "Setting nocache to:%s\n" "$NOCACHE"
 fi

./gen_docker.sh $NOCACHE
./run_builddocker.sh main
