#!/usr/bin/env bash
# copy from target to app folder
mv /home/ec2-user/apps/gs-actuator-service-0.1.0.jar  /home/ec2-user/apps/gs-actuator-service-0.1.0.jar.bak
cp /var/lib/jenkins/workspace/roy_demo_mvn_github/complete/target/gs-actuator-service-0.1.0.jar /home/ec2-user/apps/

cd /home/ec2-user/apps/
nohup java -server -jar gs-actuator-service-0.1.0.jar > ./gs-actuator-service.log 2>&1 &