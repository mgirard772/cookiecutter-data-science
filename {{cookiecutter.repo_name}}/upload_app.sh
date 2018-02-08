#!/usr/bin/env bash

if [ $# -eq 0 ] || [ -z "$1" ]
    then
      echo "You must supply local app path"
      exit 1
fi

if [ $# -eq 0 ] || [ -z "$2" ]
    then
      echo "You must supply an app folder name"
      exit 1
fi
  
  
  app_path=$1
  app_name=$2
  container_name=$(basename $(git remote get-url origin) .git)
  
  cp .Renviron .Renviron_temp
  echo "PROJECT_ROOT='/srv/shinyapps/${app_name}'" >> .Renviron
  rsync --exclude-from "rsync_exclude.txt" -r . devlx184:/srv/shinyapps/$container_name/$app_name
  rsync -r $app_path. devlx184:/srv/shinyapps/$container_name/$app_name
  ssh devlx184 chmod -R 777 /srv/shinyapps/$container_name/$app_name
  ssh devlx184 touch /srv/shinyapps/$container_name/$app_name/restart.txt
  mv .Renviron_temp .Renviron
  