#!/bin/bash

url=${DBURL}
#jdbc:mysql://127.0.0.1:3306/cache_cloud
user=${DBUSER}
password=${DBPWD}


echo "url : ${url}"
echo "user : ${user}"
echo "password : ${password}"

cd /opt/cachecloud-web/
mkdir /opt/cachecloud-web/logs/
touch /opt/cachecloud-web/logs/gc.log

echo "h3c.db.url=${DBURL}" >> /spec.properties
echo "h3c.db.user=${DBUSER}" >> /spec.properties
echo "h3c.db.password=${DBPWD}" >> /spec.properties

JAVA_OPTS="-server -Xmx1g -Xms1g -Xss256k -XX:MaxDirectMemorySize=1G -XX:+UseG1GC -XX:MaxGCPauseMillis=200 -XX:G1ReservePercent=25 -XX:InitiatingHeapOccupancyPercent=40 -XX:+PrintGCDateStamps -Xloggc:/opt/cachecloud-web/logs/gc.log -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=10 -XX:GCLogFileSize=100M -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/opt/cachecloud-web/logs/java.hprof -XX:+DisableExplicitGC -XX:-OmitStackTraceInFastThrow -XX:+PrintCommandLineFlags  -Djava.awt.headless=true -Djava.net.preferIPv4Stack=true -Djava.util.Arrays.useLegacyMergeSort=true -Dfile.encoding=UTF-8 -Duser.timezone=GMT+08"
echo -e "======================Starting the CacheCloud========================="

cat /spec.properties
java $JAVA_OPTS -jar /opt/cachecloud-web/web.war --server.port=8080 

