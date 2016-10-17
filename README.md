Authenticate aws account (need Role access to ECR)
```
sudo `aws ecr get-login --region us-east-1`
```
Docker Run Command
```
sudo docker run -d --name=puppetmaster -p 0.0.0.0:8140:8140 -h puppet.maint.motes -v /container_fs/ssl:/etc/puppetlabs/puppet/ssl baef24e3e51f /opt/puppetlabs/server/bin/puppetserver foreground
```
module deploy command
```
sudo docker exec puppetmaster /opt/puppetlabs/puppet/bin/r10k deploy environment production -pv
```
