#!/bin/bash
tee /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF
yum -q -y install docker-engine unzip git
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
rm -rf awscli-bundle*
INSTANCEID=`curl http://169.254.169.254/latest/meta-data/instance-id`
MAC=`ip a s eth0 | grep 'link/ether' | awk ' { print $2 } '`
IFACEID=`curl http://169.254.169.254/latest/meta-data/network/interfaces/macs/$MAC/interface-id`
/usr/local/bin/aws ec2 assign-private-ip-addresses --network-interface-id $IFACEID --private-ip-addresses 192.168.0.50 --allow-reassignment --region us-east-1
/usr/local/bin/aws ec2 attach-volume --volume-id vol-09c191675a98a1401 --instance-id $INSTANCEID --device /dev/sdb --region us-east-1
echo -e "/dev/xvdb1\t/container_fs/\txfs     defaults        0 0" >> /etc/fstab
mkdir /container_fs
for x in 1 2 3 4 5 6 7 8 9 10
do 
 mount -a && break
 sleep 5
done
ip addr add 192.168.0.50 dev  eth0
systemctl enable docker
systemctl start docker
