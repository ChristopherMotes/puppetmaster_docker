FROM centos
MAINTAINER Christopher Motes "motescj@aim.com"

run groupadd -g 50995 puppet
run groupadd -g 50996 puppetdb
run useradd -u  50995 -g 50995 -c "puppetserver daemon" -M -d /opt/puppetlabs/server/data/puppetserver  -s /sbin/nologin puppet
run useradd -u  50996 -g 50996 -c "puppetdb daemon" -M -d /opt/puppetlabs/server/data/puppetdb  -s /sbin/nologin puppetdb
RUN yum -y install local  https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
RUN yum -y install puppetserver puppet
COPY master/puppetserver /etc/sysconfig/puppetserver
#RUN puppet agent -t 
RUN yum -y install  puppetdb



