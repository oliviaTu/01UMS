#!/bin/sh

USERNAME="ums"
prog_path=/opt/powercloud/ums/ums_server/software/ums/ums
nohup ${prog_path} --port=9092> /opt/powercloud/ums/ums_server/run/ums.file 2>&1 &

