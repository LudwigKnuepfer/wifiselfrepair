#!/bin/sh

PINGS='4'
SLEEP='60'
PINGDEST='github.com'
INTERFACE='wlan0'
LOG='/var/log/wifiselfrepair.log'

# this is (better) done in /etc/network/interfaces
#iw dev ${INTERFACE} set power_save off

while sleep ${SLEEP}; do
    ping -c ${PINGS} ${PINGDEST} > /dev/null 2>&1
    OK=${?}
    if [ '0' != "${OK}" ]; then
        echo $(date "+%Y/%m/%d %H:%M:%S") "reconnecting" >> ${LOG}
        ifdown --force ${INTERFACE}
        sleep 5
        ifup ${INTERFACE}
        sleep 20
    fi
done
