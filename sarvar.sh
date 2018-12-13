#!/bin/bash
sudo apt-get update

#install jre
sudo apt-get install openjdk-7-jre -y

ssh -o "StrictHostKeyChecking no" localhost

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

cd ~

touch core-site.xml

echo '?^?^?<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>

<!-- Put site-specific property overrides in this file. -->

<configuration>
<property>
<name>fs.default.name</name>
<value>hdfs://localhost:9000</value>
</property>

<property>
<name>hadoop.tmp.dir</name>
<value>/usr/local/hadoop/tmp</value>
</property>
</configuration>' >> core-site.xml

sudo mv core-site.xml /usr/local/hadoop/conf/



touch hdfs-site.xml

echo '<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>

<!-- Put site-specific property overrides in this file. -->

<configuration>
<property>
<name>dfs.replication</name>
<value>1</value>
</property>
</configuration>' >> hdfs-site.xml

sudo mv hdfs-site.xml /usr/local/hadoop/conf/



touch mapred-site.xml

echo '<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>

<!-- Put site-specific property overrides in this file. -->

<configuration>
<property>
<name>mapred.job.tracker</name>
<value>hdfs://localhost:9001</value>
</property>
</configuration>' >> mapred-site.xml

sudo mv mapred-site.xml /usr/local/hadoop/conf/

hadoop namenode -format

start-dfs.sh
start-mapred.sh
sudo apt-get update

sudo apt-get install openjdk-7-jdk -y
jps