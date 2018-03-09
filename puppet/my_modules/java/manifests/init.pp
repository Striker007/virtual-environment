
class java {

    if  !($::operatingsystem in ['Debian', 'Ubuntu']) {
         fail('This module only works on Debian or derivatives like Ubuntu')
    }

    Exec { path => ['/usr/local/bin', '/usr/local/sbin', '/usr/bin', '/usr/sbin', '/bin', '/sbin']}
 
    exec { 'apt update':
        command => '/usr/bin/apt-get update',
        # require => File['/etc/apt/sources.list.d/jenkins.list'],
    }

   # TODO chg to package
    exec {'openjdk':
        command => '/usr/bin/apt-get -t jessie-backports -y install \
                                        openjdk-8-jre-headless \
                                        ca-certificates-java \
                                        openjdk-8-jdk-headless \
                                        openjdk-8-jre \
                                        openjdk-8-jdk',
        require => Exec['apt update'],
    }

    # TODO refactor
    exec {'maven':
        command => '/usr/bin/test ! -f /usr/local/bin/mvn && 
                    wget http://apache.ip-connect.vn.ua/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz &&
                    tar xzf apache-maven-3.5.2-bin.tar.gz &&
                    mv apache-maven-3.5.2 /opt/ &&
                    ln -s /opt/apache-maven-3.5.2/bin/mvn /usr/local/bin/mvn || 
                    true',
        require => Exec['openjdk'],
    }


    #TODO 
    # wget https://releases.hashicorp.com/consul/1.0.6/consul_1.0.6_linux_amd64.zip &&
    # tar xzf consul_1.0.6_linux_amd64.zip && rm consul_1.0.6_linux_amd64.zip &&
    # mkdir -p /etc/consul.d &&
    #
    # echo '{"service": {"name": "web", "tags": ["java"], "port": 8100, \
    # "check": {"args": ["curl", "192.168.52.xx:8100"], "interval": "1s"}}}'   >/etc/consul.d/web.json
    #
    # ./consul agent -dev -ui -bind 192.168.52.10 -advertise 192.168.52.10 -client 192.168.52.10  \
    # -config-dir=/etc/consul.d -enable-script-checks

}
