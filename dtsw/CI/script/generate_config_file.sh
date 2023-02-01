#!/bin/sh

workDir=`dirname $0`
workDir=`cd ${workDir};pwd`

# 环境
envName=$1

source ${workDir}/../env/$envName/install_config.conf
source ${workDir}/../env/$envName/install_env.sh

# 模板配置目录
confTemplateDir=${workDir}/../conf_template
# 生成的配置文件所存放的目标目录
confGenerateDir=${workDir}/conf

if [ $# -ge 2 ] ; then
    confGenerateDir=$2
    if [[ $confGenerateDir != /* ]]; then
        confGenerateDir=`pwd`/$2
    fi
fi

echo 将生成的配置的目录是：$confGenerateDir

# 检查
if [ ! -d $confTemplateDir ]; then
  echo "ERROR：模板配置文件夹不存在"
  exit 1;
fi

# 创建
if [ ! -d $confGenerateDir ]; then
    mkdir -p $confGenerateDir
else
    rm -f  $confGenerateDir/*.yml
fi

# copy目录
cp $confTemplateDir/* $confGenerateDir


# application-api.yaml
if [ -f "${confGenerateDir}/application-api.yaml" ];then
    echo "start config application-api.yaml"
    sed -i "s%#{dbSchema}%${dbSchema}%g" ${confGenerateDir}/application-api.yaml
    sed -i "s%#{dbHost}%${dbHost}%g" ${confGenerateDir}/application-api.yaml
    sed -i "s%#{dbPort}%${dbPort}%g" ${confGenerateDir}/application-api.yaml
    sed -i "s%#{dbUsername}%${dbUsername}%g" ${confGenerateDir}/application-api.yaml
    sed -i "s%#{dbPassword}%${dbPassword}%g" ${confGenerateDir}/application-api.yaml
    sed -i "s%#{zkNameSpace}%${zkNameSpace}%g" ${confGenerateDir}/application-api.yaml
    sed -i "s%#{zKConnectStr}%${zKConnectStr}%g" ${confGenerateDir}/application-api.yaml
fi

# application-master.yaml
if [ -f "${confGenerateDir}/application-master.yaml" ];then
    echo "start config application-master.yaml"
    sed -i "s%#{dbSchema}%${dbSchema}%g" ${confGenerateDir}/application-master.yaml
    sed -i "s%#{dbHost}%${dbHost}%g" ${confGenerateDir}/application-master.yaml
    sed -i "s%#{dbPort}%${dbPort}%g" ${confGenerateDir}/application-master.yaml
    sed -i "s%#{dbUsername}%${dbUsername}%g" ${confGenerateDir}/application-master.yaml
    sed -i "s%#{dbPassword}%${dbPassword}%g" ${confGenerateDir}/application-master.yaml
    sed -i "s%#{zkNameSpace}%${zkNameSpace}%g" ${confGenerateDir}/application-master.yaml
    sed -i "s%#{zKConnectStr}%${zKConnectStr}%g" ${confGenerateDir}/application-master.yaml
fi

# application-worker.yaml
if [ -f "${confGenerateDir}/application-worker.yaml" ];then
    echo "start config application-worker.yaml"
    sed -i "s%#{dbSchema}%${dbSchema}%g" ${confGenerateDir}/application-worker.yaml
    sed -i "s%#{dbHost}%${dbHost}%g" ${confGenerateDir}/application-worker.yaml
    sed -i "s%#{dbPort}%${dbPort}%g" ${confGenerateDir}/application-worker.yaml
    sed -i "s%#{dbUsername}%${dbUsername}%g" ${confGenerateDir}/application-worker.yaml
    sed -i "s%#{dbPassword}%${dbPassword}%g" ${confGenerateDir}/application-worker.yaml
    sed -i "s%#{zkNameSpace}%${zkNameSpace}%g" ${confGenerateDir}/application-worker.yaml
    sed -i "s%#{zKConnectStr}%${zKConnectStr}%g" ${confGenerateDir}/application-worker.yaml
    sed -i "s%#{alertServer}%${alertServer}%g" ${confGenerateDir}/application-worker.yaml
fi


# application-alert.yaml
if [ -f "${confGenerateDir}/application-alert.yaml" ];then
    echo "start config application-alert.yaml"
    sed -i "s%#{dbSchema}%${dbSchema}%g" ${confGenerateDir}/application-alert.yaml
    sed -i "s%#{dbHost}%${dbHost}%g" ${confGenerateDir}/application-alert.yaml
    sed -i "s%#{dbPort}%${dbPort}%g" ${confGenerateDir}/application-alert.yaml
    sed -i "s%#{dbUsername}%${dbUsername}%g" ${confGenerateDir}/application-alert.yaml
    sed -i "s%#{dbPassword}%${dbPassword}%g" ${confGenerateDir}/application-alert.yaml
fi

# common.properties
if [ -f "${confGenerateDir}/common.properties" ];then
    echo "start config common.properties"
    sed -i "s%#{resourceUploadPath}%${resourceUploadPath}%g" ${confGenerateDir}/common.properties
    sed -i "s%#{kerberosEnabale}%${kerberosEnabale}%g" ${confGenerateDir}/common.properties
    sed -i "s%#{kerberosKrb5Conf}%${kerberosKrb5Conf}%g" ${confGenerateDir}/common.properties
    sed -i "s%#{kerberosPrinciple}%${kerberosPrinciple}%g" ${confGenerateDir}/common.properties
    sed -i "s%#{kerberosKeytab}%${kerberosKeytab}%g" ${confGenerateDir}/common.properties
    sed -i "s%#{hdfsRootUser}%${hdfsRootUser}%g" ${confGenerateDir}/common.properties
    sed -i "s%#{fsDefaultFS}%${fsDefaultFS}%g" ${confGenerateDir}/common.properties
    sed -i "s%#{yarnRMPort}%${yarnRMPort}%g" ${confGenerateDir}/common.properties
    sed -i "s%#{yarnRMHosts}%${yarnRMHosts}%g" ${confGenerateDir}/common.properties
    sed -i "s%#{yarnJobHistoryHost}%${yarnJobHistoryHost}%g" ${confGenerateDir}/common.properties
    sed -i "s%#{developmentState}%${developmentState}%g" ${confGenerateDir}/common.properties
    sed -i "s#spark.sql.spark.jar.*#spark.sql.spark.jar=${resourceUploadPath}/platform/resources/jars/SparkSqlExecutor-1.0-SNAPSHOT.jar#g" conf/common.properties
fi
