#!/bin/bash
JAVA_HOME=/usr/java/jdk1.8.0_221
export JRE_HOME=/$JAVA_HOME/jre
export CLASSPATH=.:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
export PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin

OPT=${1}
APP_NAME="${2}.jar"
LOG_PATH="log/"
LOG_NAME="${LOG_PATH}/${2}.out"

`mkdir -p ${LOG_PATH}`

#使用说明，用来提示输入参数
usage() {
    echo "Usage: sh springboot.sh [start|stop|restart|status]"
    exit 1
}

if [ -z ${APP_NAME} ]; then
	echo "Application ${APP_NAME} is not exist!"
	exit 1
fi

#检查程序是否在运行
is_exist(){
  pid=`ps -ef|grep $APP_NAME|grep -v grep|awk '{print $2}'`
  #如果不存在返回1，存在返回0     
  if [ -z "${pid}" ]; then
   return 1
  else
    return 0
  fi
}

#启动方法
start(){
  is_exist
  if [ $? -eq 0 ]; then
    echo "${APP_NAME} is already running. pid=${pid}"
  else
    nohup java -jar ${APP_NAME}  > ${LOG_NAME} 2>&1 &
	echo "${APP_NAME} has started"
  fi
}

#停止方法
stop(){
  is_exist
  if [ $? -eq "0" ]; then
    kill -9 $pid
	echo "${APP_NAME} has stopped"
  else
    echo "${APP_NAME} is not running"
  fi  
}

#输出运行状态
status(){
  is_exist
  if [ $? -eq "0" ]; then
    echo "${APP_NAME} is running. Pid is ${pid}"
  else
    echo "${APP_NAME} is shutdown."
  fi
}

#重启
restart(){
  stop
  sleep 5
  start
}

#根据输入参数，选择执行对应方法，不输入则执行使用说明
case "$OPT" in
  "start")
    start
    ;;
  "stop")
    stop
    ;;
  "status")
    status
    ;;
  "restart")
    restart
    ;;
  *)
    usage
    ;;
esac
