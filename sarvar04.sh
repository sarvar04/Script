#!/bin/bash
sudo apt-get update
sudo apt-get install openjdk-7-jre -y
ssh localhost
cd .ssh/
#ssh-keygen
ssh-keygen -f id_rsa -t rsa -N ''
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
cd ~
wget https://archive.apache.org/dist/hadoop/common/hadoop-1.2.1/hadoop-1.2.1.tar.gz
tar -xzvf hadoop-1.2.1.tar.gz
sudo mv hadoop-1.2.1 /usr/local/hadoop

#sudo echo "export HADOOP_PRIFIX=/usr/local/hadoop/" >> /home/ubuntu/.bashrc
#sudo echo "export PATH=$PATH:$HADOOP_PRIFIX/bin" >> /home/ubuntu/.bashrc
#sudo echo "export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64" >> /home/ubuntu/.bashrc
#sudo echo "export PATH=$PATH:$JAVA_HOME" >> /home/ubuntu/.bashrc
#. ~/.bashrc
export HADOOP_PRIFIX=/usr/local/hadoop/
export PATH=$PATH:$HADOOP_PRIFIX/bin
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
export PATH=$PATH:$JAVA_HOME

sudo echo "export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64" >> /usr/local/hadoop/conf/hadoop-env.sh
sudo echo "export HADOOP_OPTS=-Djava.net.preferIPV4Stack=true" >> /usr/local/hadoop/conf/hadoop-env.sh
. /usr/local/hadoop/conf/hadoop-env.sh
sudo sed -i -e '/<configuration>/a\<property><name>fs.default.name</name>\n<value>hdfs://localhost:9000</value></property>\n<property><name>hadoop.tmp.dir</name>\n<value>/usr/local/hadoop/tmp</value></property>\n' /usr/local/hadoop/conf/core-site.xml
sudo sed -i -e '/<configuration>/a\<property><name>dfs.replication</name>\n<value>1</value></property>' /usr/local/hadoop/conf/hdfs-site.xml
sudo sed -i -e '/<configuration>/a\<property><name>mapred.job.tracker</name>\n<value>hdfs://localhost:9001</value></property>' /usr/local/hadoop/conf/mapred-site.xml

hadoop namenode -format
start-dfs.sh
start-mapred.sh
sudo apt-get update
sudo apt-get install openjdk-7-jdk -y
jps
