#!/bin/bash

sudo apt-get update  

ssh-keygen
 
cd .ssh

cat id_rsa.pub >> authorized_keys

cd ..

#install JDK
sudo apt-get install openjdk-7-jdk -y

#install Hadoop
wget https://archive.apache.org/dist/hadoop/core/hadoop-1.2.1/hadoop-1.2.1.tar.gz
tar -xzvf hadoop-1.2.1.tar.gz  

sudo mv hadoop-1.2.1 /usr/local/hadoop


#Add To Bashrc
echo 'export HADOOP_PREFIX=/usr/local/hadoop/
export PATH=$PATH:$HADOOP_PREFIX/bin
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
export PATH=$PATH:$JAVA_HOME' >> ~/.bashrc

cd ~
source .bashrc

#Configuration Hadoop Env
cd /usr/local/hadoop/conf/
echo 'export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
export HADOOP_OPTS=-Djava.net.preferIPV4Stack=true' >> hadoop-env.sh

cd ~

#Core Site xml
sudo sed -i -e '/<configuration>/a\<property><property><name>fs.default.name</name>\n<value>hdfs://localhost:9000</value></property>\n/\n<property><name>hadoop.tmp.dir</name>\n<value>/usr/local/hadoop/tmp</value></property>' /usr/local/hadoop/conf/core-site.xml

#HDFS Site xml
sudo sed -i -e '/<configuration>/a\<property><name>dfs.replication</name>\n<value>1</value></property>' /usr/local/hadoop/conf/hdfs-site.xml


#Mapred Site xml
sudo sed -i -e '/<configuration>/a\<property><name>mapred.job.tracker</name>\n<value>hdfs://localhost:9001</value></property>' /usr/local/hadoop/conf/mapred-site.xml


exec bash



hadoop namenode -format


#Start Nodes
start-all.sh	

sudo apt-get install openjdk-7-jdk -y
jps
