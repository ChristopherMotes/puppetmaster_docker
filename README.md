Authenticate aws account (need Role access to ECR)
```
sudo `aws ecr get-login --region us-east-1`
```
Docker Run Command for puppetmaster
```
sudo docker run -d --name=puppetmaster -p 0.0.0.0:8140:8140 -h puppet.maint.motes -v /container_fs/ssl:/etc/puppetlabs/puppet/ssl 742758411692.dkr.ecr.us-east-1.amazonaws.com/puppetmaster:latest /opt/puppetlabs/server/bin/puppetserver foreground
```
module deploy command
```
sudo docker exec puppetmaster /opt/puppetlabs/puppet/bin/r10k deploy environment production -pv
```
Docker Run Command for puppetDB
```
sudo docker run -d --name=puppetdb -p 0.0.0.0:8081:8081 -h puppetdb.maint.motes 742758411692.dkr.ecr.us-east-1.amazonaws.com/puppetmaster:latest /opt/puppetlabs/bin/puppetdb foreground
```
