#!/bin/bash

RED="\033[0;31m"
ENDCOLOR="\e[0m"

while true;
do 
    output="$(curl -s http://app-produccion-alb-1696097727.us-east-1.elb.amazonaws.com:8888/statddus.json)"
    if [[ "$output" == *InstanceId* ]]; then
        echo $output | jq -r
    else
        echo -e "${RED}[ERROR]${ENDCOLOR} UnHealthy host found"
    fi
    sleep 2
done

