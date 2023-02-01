# sql 更新脚本
workDir=`dirname $0`
workDir=`cd ${workDir};pwd`

# 环境
envName=$1
source ${workDir}/../env/$envName/install_config.conf

sqlFile=$2

psql -c "set schema '$dbSchema'"  -f $sqlFile "host=$dbHost port=$dbPort dbname=dwdolphin user=$dbUsername password=$dbPassword"