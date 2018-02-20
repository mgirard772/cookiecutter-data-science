#!/usr/bin/env bash

if [ $# -eq 0 ] || [ -z "$1" ]
    then
  echo "You must supply a port number"
  exit 1
fi

if [ $1 < 51000 ] || [$1 > 52000]
  then
    echo "Please supply a port number in the range 51000-52000"
fi

container_name=$(basename $(git remote get-url origin) .git)
port_num=$1

ssh devlx184 mkdir /srv/shinyapps/$container_name
ssh devlx184 docker run -d -p $port_num:3838 -v /srv/shinyapps/$container_name:/srv/shiny-server --name=$container_name mmds/rodbc-shiny:shiny_ops
echo Docker container $container_name created on port $port_num
