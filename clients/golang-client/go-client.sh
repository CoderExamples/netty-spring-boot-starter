#!/usr/bin/env bash

function stop() {
    echo "运行中的 go-client 进程:"
    jps -l | grep "command-line-arguments"
    pid=`cat go.client.pid`
    echo "即将关闭的GoClient服务Pid:"$pid
    kill -9 $pid
    echo "即将关闭的GoClient服务完成, 运行中的 go-client 进程:"
    jps -l | grep "command-line-arguments"
}

function start() {
    chmod +x command-line-arguments
    
    nohup ./command-line-arguments > go.client.log 2>&1 &
    ps -ef | grep "command-line-arguments" | awk '{print $1}' > go.client.pid
    ps -ef | grep "command-line-arguments"

    echo "GoClient启动完成"

    tail -f go.client.log
}

type=$1
if [ $1 == "start" ]; then
  echo "start"
  start
else
  echo "stop"
  stop
fi
