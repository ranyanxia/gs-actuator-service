#!/usr/bin/env bash
# copy from target to app folder
APP_HOME=/home/ec2-user/apps/
APP_NAME='gs-actuator-service'
LOG_PATH=$APP_HOME$APP_NAME.log

echo "deploying app ${APP_NAME}"
mv /home/ec2-user/apps/gs-actuator-service-0.1.0.jar  /home/ec2-user/apps/gs-actuator-service-0.1.0.jar.bak
cp /var/lib/jenkins/workspace/roy_demo_mvn_github/complete/target/gs-actuator-service-0.1.0.jar /home/ec2-user/apps/


cd $APP_HOME

# stop process
echo 'stopping the app'
PID=`ps ax | grep 'java' | grep ${APP_NAME} | grep -v grep | awk '{print $1}'`
echo ${PID}

if [[ ! -z "$PID" ]]; then
    kill -15 $PID
else
     echo 'app is not running'
fi

echo 'starting the app'
nohup java -server -jar ${APP_NAME}-0.1.0.jar > $LOG_PATH 2>&1 &

echo "app started, log path: ${LOG_PATH}"