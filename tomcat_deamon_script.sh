#!/bin/sh

### BEGIN INIT INFO
# Provides:          tomcat
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start and stop Apache Tomcat
# Description:       Enable Apache Tomcat service provided by daemon.
### END INIT INFO

ECHO=/bin/echo
TOMCAT_USER=ubuntu
TOMCAT_HOME=/home/ubuntu/applications/current
TOMCAT_START_SCRIPT=$TOMCAT_HOME/bin/startup.sh
TOMCAT_STOP_SCRIPT=$TOMCAT_HOME/bin/shutdown.sh

start() {
    $ECHO -n "Starting Tomcat..."
    su - $TOMCAT_USER -c "CATALINA_PID=/opt/tomcat/catalina.pid $TOMCAT_START_SCRIPT &"
    $ECHO "."
}

stop() {
    $ECHO -n "Stopping Tomcat......"
    su - $TOMCAT_USER -c "CATALINA_PID=/opt/tomcat/catalina.pid $TOMCAT_STOP_SCRIPT 5 -force &"
    while [ "$(ps -fu $TOMCAT_USER | grep java | grep tomcat | wc -l)" -gt "0" ]; do
        sleep 5; $ECHO -n "."
    done
    $ECHO "."
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        stop
        start
        ;;
    *)
        $ECHO "Usage: tomcat {start|stop|restart}"
        exit 1
esac
exit 0
