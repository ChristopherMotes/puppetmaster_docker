FROM centos
MAINTAINER Christopher Motes "motescj@aim.com"

run groupadd -g 50995 puppet
run groupadd -g 50996 puppetdb
run useradd -u  50995 -g 50995 -c "puppetserver daemon" -M -d /opt/puppetlabs/server/data/puppetserver  -s /sbin/nologin puppet
run useradd -u  50996 -g 50996 -c "puppetdb daemon" -M -d /opt/puppetlabs/server/data/puppetdb  -s /sbin/nologin puppetdb
RUN yum -y install local  https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
RUN yum -y install puppetserver puppet-agent git puppetdb puppetdb-termini
COPY master/puppetserver /etc/sysconfig/puppetserver
COPY master/autosign.conf /etc/puppetlabs/puppet/autosign.conf
COPY master/puppet.conf /etc/puppetlabs/puppet/puppet.conf
COPY master/puppetdb.conf /etc/puppetlabs/puppet/puppetdb.conf
COPY master/routes.yaml /etc/puppetlabs/puppet/routes.yaml
RUN chown -R puppet:puppet `/opt/puppetlabs/puppet/bin/puppet config print confdir`
COPY puppetdb/jetty.ini /etc/puppetlabs/puppetdb/conf.d/jetty.ini
COPY puppetdb/database.ini /etc/puppetlabs/puppetdb/conf.d/database.ini
COPY puppetdb/ssl/ca.pem /etc/puppetlabs/puppetdb/ssl/ca.pem
COPY puppetdb/ssl/private.pem /etc/puppetlabs/puppetdb/ssl/private.pem
RUN chmod 700 /etc/puppetlabs/puppetdb/ssl
RUN chmod 600 /etc/puppetlabs/puppetdb/ssl/*
COPY puppetdb/ssl/public.pem /etc/puppetlabs/puppetdb/ssl/public.pem
RUN chown -R  puppetdb:puppetdb /etc/puppetlabs/puppetdb
RUN /opt/puppetlabs/puppet/bin/gem install r10k
COPY r10k/r10k.yaml /etc/puppetlabs/r10k/r10k.yaml
