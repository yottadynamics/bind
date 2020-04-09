#!/bin/bash

DATE=`date +%Y-%m-%d-%H:%M:%S`
BINDCONF="/opt/named/named.conf"

chown named:named -R /opt/named

function log(){
    echo "$DATE $@" 
    return 0
}

function warn(){
    echo "$DATE $@" 
    return 1
}

function panic(){
    echo "$DATE $@" 
    exit 1
}

function start(){
    log "$DATE starting named..." 
    named-checkconf /etc/named.conf 
    /usr/sbin/named -4 -c ${BINDCONF} -f 
}

function main(){
    start
}

main 
