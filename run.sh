#!/bin/bash
pwd && ls -al
#source /etc/profile && java -jar ./TestWeb.jar --server.port=9090
source /etc/profile
java -jar ./mall-admin-1.0-SNAPSHOT.jar
