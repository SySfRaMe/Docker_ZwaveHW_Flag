#!/bin/bash
#Created By SySfRaMe
#put inside a cronjob and let et run every 5min
#In docker give your hw dependend container a constraint flag to the zwave=true
#replace Z-Stick with a string to match your zwave device identification

hostname=$(cat /proc/sys/kernel/hostname)
zwave=$(lsusb | grep "Z-Stick")

zlabel=$(docker node inspect "$hostname" | grep "zwave")

if [ -n "$zwave" ]; then
        zvalue=$("$zlabel" | grep "true")
        if [ -z "$zvalue" ]; then
                docker node update --label-add zwave=true "$hostname"
        fi
else
        zvalue=$("$zlabel" | grep "false")
        if [ -z "$zvalue" ]; then
                docker node update --label-add zwave=false "$hostname"
        fi
fi
