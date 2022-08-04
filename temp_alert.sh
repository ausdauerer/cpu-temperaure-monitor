#!/bin/bash

if [ "$(dpkg -S `which sensors`)" == "lm-sensors: /usr/bin/sensors" ]
then
  echo Package is already installed
else
  echo Package is not installed
  sudo apt-get install lm-sensors -y
fi



maxTemp=75
x="Package id 0:"
while true
do
  a=$(sensors | grep "$x")
  b=${a#"$x"}
  c=$(echo $b | cut -d " " -f1)
  d=${c:1:-4}
  echo Current temperature $c
  #echo $maxTemp
  if [ "$d" -ge "$maxTemp" ]
  then
    echo "Temperature is high"
    notify-send -t 1 "Warning" "Temperature is high : ${c:1:-1}C" 
    if [ "$d" -ge 75 ]
    then
      maxTemp=$d
    fi
  fi
  if [ "$d" -gt 75 ]
  then
    maxTemp=$((maxTemp-1))
  fi
  sleep 10
done