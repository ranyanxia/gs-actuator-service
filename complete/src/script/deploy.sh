#!/usr/bin/env bash
# copy from target to app folder
APP_HOME=/var/royapps/
APP_NAME='gs-actuator-service'
LOG_PATH=$APP_HOME$APP_NAME.log
APP_JAR=gs-actuator-service-0.1.0.jar

echo "deploying app ${APP_NAME}"
if [ -f $APP_HOME/${APP_JAR} ] ; then
    mv -f $APP_HOME/${APP_JAR}  $APP_HOME/${APP_JAR}.bak
fi

cp -f /var/lib/jenkins/workspace/roy_demo_mvn_github/complete/target/${APP_JAR} $APP_HOME

chmod 775 $APP_HOME/${APP_JAR}

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
#nohup java -server -jar ${APP_NAME}-0.1.0.jar > $LOG_PATH 2>&1
nohup java -server -jar ${APP_NAME}-0.1.0.jar >$LOG_PATH 2>&1 &

if [ -f $LOG_PATH ] ; then
    chmod 777 $LOG_PATH
fi

echo "app started, log path: ${LOG_PATH}"