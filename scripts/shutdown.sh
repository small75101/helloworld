#!/bin/bash
RS=`ls -l|grep '.*jar$'|grep -v grep|awk '{print $9}'`
APP="APP"
for str in ${RS}
do
  APP=${str%.jar}
  ./java.sh stop $APP
done
