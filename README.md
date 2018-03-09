# virtual-environment

Jenkins and microservices
### TODO list
(+) done
(~) in progress
(-) not yet

#### Vagrant
```shell
+ install plugins (vagrant-hostsupdater, vagrant-vbguest)
+ install 4 instances with limited ram
+ run puppet apply
+ forward ports
+ create LAN with predefined IPs range
- refactoring
- chg config to yaml
```
#### Jenkins
```shell
(password, vm-jenkins - /var/lib/jenkins/secrets/initialAdminPassword)
+ learn how to deploy, maintain java, artifacts
+ jenkins puppet role
+ jenkins pipeline
+ jenkins automatic install with plugins and default password
+ jenins build java
+ jenkins deploy java
+ chg default spring web port
- add tests to pipeline (mvn\gradle test)
- think about jenkins slave
- try jenkinsci/vagrant-plugin
- artifactory\nexus
- think rewriting to gradle
- ./puppet/files/dot.ssh.config
- think about useful plugins (notifications\grids)
```
#### Puppet
```shell
+ learn basics
+ roles jenkins
+ role java nodes
+ role haproxy
- role consul, consul-template
- create ssh user (like "deploy")
.
- move Jenkins initial from manifests
- chg config to yaml
- try refactor to using modules (Puppet Forge)
- use puppet "files"
- write main class
- look at PuPHPet practices
.
- ELK role
- prometheus role
- docker related roles
```
#### Haproxy + Consul Template + Consul
```shell
+ install \ try to use
+ create configs
+ test under different conditions
- automatic health checks registration (think about)
- /puppet/files/haproxy.cfg
```
#### ELK and JMX
```shell
+ test jmx (enable in application.properties)
~ get logs from spring app
+ install ELK
+ add cron with curator
~ gather metrics with prometheus
- create graphs
```

#### CODING
```shell
+ recall Java
+ https://www.codingame.com/training/easy/ascii-art
+ https://www.codingame.com/training/easy/horse-racing-duals (think about better solution)
~ https://www.codingame.com/training/easy/ascii-art (revrite to OOP variant)
~ https://www.codingame.com/training/medium/skynet-revolution-episode-1 (in progress 2/4)
```

#### ANOTHER DESIGN
```shell
~ live reload with vagrant (frontend developers)
~ try to use Docker from Vagrant
~ create flow chart
- instal registry
- try docker two step builds
- try to use puppet for creating docker images
- think about jenkins plugins```
