printf "nodejs :%s\n" $(node --version)

if [ $# -gt 0 ]
 then
  export BRANCH="$1"
  printf "Setting branch to:%s\n" "$BRANCH"
 fi