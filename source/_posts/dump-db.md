---
title: Bash导出指定表
date: 2017-02-23 15:48:43
categories: 工具
tags: [工具, Bash]
---
刚学bash练手, 用来备份指定表

-h 数据库ip
-u 用户名
-p 密码
-d 数据库
-P 端口
-f 匹配表前缀
-o 输出目录

数据库为mysql

<!-- more -->

```bash
#!/bin/bash

#从数据库备份指定表

#源数据库
source_host=127.0.0.1
source_port=3306
source_db=xxx-admin
source_username=root
source_password=

#需要操作表的前缀
table_prefix=

document_name="`date +%Y%m%d`"

if [[ $# -lt 1 ]];then
	echo "USAGE:`basename $0` [-h host] [-u username] [-p password] [-P port]"
	echo "             [-d database] [-f prefix] [-o output_document]"  
	echo "    -h host (127.0.0.1)"
	echo "    -u username (root)"
	echo "    -p password ()"
	echo "    -d database (xxx-admin)"
	echo "    -P port (3306)"
	echo "    -f prefix () default all"
	echo "    -o output document() default current date"
	exit 1
fi    

while getopts :h:u:p:P:d:f:o: name
do
	case $name in
	h)source_host=$OPTARG;;
	u)source_username=$OPTARG;;
	d)source_db=$OPTARG;; 
	p)source_password=$OPTARG;; 
	P)source_port=$OPTARG;; 
	f)table_prefix=$OPTARG;;
	o)document_name=$OPTARG;;
	\?) echo "Invalid option :`basename $0` [-h host] [-u username] [-p password] [-P port] [-d database] [-f prefix] [-o output_document]"
	exit 1
	;;
	:) echo "$0:Must supply an argument to -$OPTARG."
	exit 1
	;;
	esac  
done

#创建存放导出数据的文件夹
if [ ! -d "./"${document_name} ]; then
  mkdir ${document_name}
fi

#查询表名的sql语句
sql_query_table='select table_name from information_schema.tables where table_schema="'${source_db}'" and table_name like "'${table_prefix}'%";' 
#mysql执行参数
mysql_params='-u'${source_username}' -P'${source_port}' -h'${source_host}' '${source_db}

#密码参数
if [ $source_password ];then
	mysql_params=${mysql_params}' -p'${source_password}
fi

#查询参数
query_params=${mysql_params}' -e '"'"${sql_query_table}"'"
#导出参数
dump_params=${mysql_params}

echo "Params: "$dump_params
echo "connecting mysql ..."
eval mysql  $query_params | awk '{if (NR>1){print $0}}' | sed s/[[:space:]]//g | while read table_name; do
	echo "dumping table: "${table_name}
	save_path='./'${document_name}'/'${table_name}'.sql'
	echo "saving to "$save_path
	eval mysqldump $dump_params' '${table_name}'>'$save_path
done
echo "**************************************"
echo "    dumping data finished."
echo "**************************************"
```