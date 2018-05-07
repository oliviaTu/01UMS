#!/bin/sh

INSTALL_DIR=/opt/powercloud/ums/ums_server
#function readCONF() {
#    INIFILE=$1; SECTION=$2; ITEM=$3
#    readIni=`awk -F '=' '/\['$SECTION'\]/{a=1}a==1&&$1~/'$ITEM'/{print $2;exit}' $INIFILE`
#    echo $readIni
#}

#db_ip=( $( readCONF ${prog_conf} DB host ) )
#db_port=( $( readCONF ${prog_conf} DB port ) )
#db_user=( $( readCONF ${prog_conf} DB user ) )
#db_pass=( $( readCONF ${prog_conf} DB pass ) ) 
#db_name=( $( readCONF ${prog_conf} DB name ) ) 

#pid_file=$(sed 's/[[:space:]]//g' ${prog_conf} | grep 'pid=' | cut -d'=' -f2)
#psql -h ${db_ip} -p ${db_port} "user=${db_user} password=${db_pass} dbname=${db_name}" << EOF > stop.scripts
#    SELECT value FROM t_authcenter_conf WHERE key='pid' ;
#EOF

#sed -i 's/^[ \t]*//g' stop.scripts

#pid_file=$(sed -n '3p' stop.scripts)
#rm -f stop.scripts

pid_file="/opt/powercloud/ums/ums_server/run/ums.pid"
if [ -f "${pid_file}" ]; then
    kill $(cat ${pid_file})
fi
rm -f /opt/powercloud/ums/ums_server/run/ums.pid
