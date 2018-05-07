#!/usr/bin/env bash

INSTALL_LOG="/tmp/UmsServer_install.log"
export INSTALL_LOG

CURRENT_DIR=$(pwd)
DATAPATH="/opt/powercloud/ums/ums_server/data"
UMSSERVERPATH="/opt/powercloud/ums/ums_server"
SAVEBACKPATH="/opt/powercloud/ums/ums_server_bak"


# 检查环境
check_env()
{
	# 删除安装日志文件
	rm -rf ${INSTALL_LOG} >/dev/null 2>&1

	echo -e "\033[32;49;1m [----------------check env begin--------------] \033[39;49;0m"
	echo "`date` check env begin--------------" >> ${INSTALL_LOG} 2>&1
	
    # 检查是否已经安装UmsServer,如果存在,先执行shop.sh脚本
    if [ -d ${UMSSERVERPATH} ]; then
		echo "`date` Start to stop UmsServer service." >> ${INSTALL_LOG} 2>&1
	  
		# 检查Ums_server服务是否已经启动
		process=`ps -ef |grep ums |grep -v "grep" |grep -v "start" |grep -v "stop" |grep -v "status" |wc -l`
		if [ ${process} == 2 ]; then
			stop_ums_server >> ${INSTALL_LOG} 2>&1
		fi

    fi
    echo -e "\033[32;49;1m [-----------------check env end---------------] \033[39;49;0m"
    echo "`date` check env end--------------" >> ${INSTALL_LOG} 2>&1
}


# 注册命令
register_cmd()
{
    #注册restart命令
    yes|cp ${CURRENT_DIR}/scripts/restart.sh /bin/restart_ums_server
    chmod 755 /bin/restart_ums_server

    #注册查看状态命令status
	yes|cp ${CURRENT_DIR}/scripts/status.sh /bin/status_ums_server
    chmod 755 /bin/status_ums_server

	#注册start命令
	yes|cp ${CURRENT_DIR}/scripts/start.sh /bin/start_ums_server
    chmod 755 /bin/start_ums_server

    #注册stop命令
	yes|cp ${CURRENT_DIR}/scripts/stop.sh /bin/stop_ums_server
    chmod 755 /bin/stop_ums_server
}

# 检查组件安装环境
check_components_env()
{
    echo -e "\033[32;49;1m [----------------check components environment begin--------------] \033[39;49;0m"
    echo "`date` check components environment begin--------------" >> ${INSTALL_LOG} 2>&1
    lib_path=${CURRENT_DIR}/lib
    if [ -d ${lib_path} ];then
        chmod -R 755 ${lib_path}
        yes|cp ${lib_path}/libhiredis.so /usr/lib
        yes|cp ${lib_path}/libjson.so /usr/lib
        yes|cp ${lib_path}/liblogsuite.so.1.1.6 /usr/lib
        if [ ! -f /usr/lib/libcas.so.1.1.4 ];then
            yes|cp ${lib_path}/libcas.so.1.1.4 /usr/lib

        fi
        if [ ! -f /usr/lib/liblogsuite.so ];then
            ln -s /usr/lib/liblogsuite.so.1.1.6 /usr/lib/liblogsuite.so
        fi
        if [ ! -f /usr/lib/libcas.so ];then
            ln -s /usr/lib/libcas.so.1.1.4 /usr/lib/libcas.so
        fi
        if [ ! -f /usr/lib/libhiredis.so.0.13 ];then
            ln -s /usr/lib/libhiredis.so.0.13 /usr/lib/libhiredis.so
        fi
        ldconfig
    fi
    echo -e "\033[32;49;1m [----------------check components environment end--------------] \033[39;49;0m"
    echo "`date` check components environment end--------------" >> ${INSTALL_LOG} 2>&1
}

# 全量安装
all_install()
{
    echo "-----------`date` install ums begin--------------" >> ${INSTALL_LOG} 2>&1
    echo -e "\033[32;49;1m [-----------install ums begin------------] \033[39;49;0m"
    # 检查安装环境
    check_components_env
	check_env

    # 注册命令
    register_cmd

	# 备份目录
    if [ -d ${UMSSERVERPATH} ];then
        if [ ! -d ${DATAPATH} ];then
            mkdir -p ${DATAPATH}
        fi
        rm -rf ${SAVEBACKPATH};mv ${UMSSERVERPATH} ${SAVEBACKPATH}
    else
        rm -rf ${SAVEBACKPATH}>/dev/null 2>&1
    fi
    
    mkdir -p /opt/powercloud/ums
	cp -rf ${CURRENT_DIR} /opt/powercloud/ums/ums_server
    mkdir -p /opt/powercloud/ums/ums_server/run

    chmod 755 ${UMSSERVERPATH}/software/ums

    echo "-----------install software end--------------" >> ${INSTALL_LOG} 2>&1
    echo -e "\033[32;49;1m [-----------install software finished---------] \033[39;49;0m"
}


all_install
if [ $? -ne 0 ];then
    echo "install failed"
    exit 1
fi
echo "install successfully"

