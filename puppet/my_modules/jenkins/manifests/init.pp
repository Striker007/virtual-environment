
class jenkins {

    if  !($::operatingsystem in ['Debian', 'Ubuntu']) {
         fail('This module only works on Debian or derivatives like Ubuntu')
    }
 
    Exec { path => ['/usr/local/bin', '/usr/local/sbin', '/usr/bin', '/usr/sbin', '/bin', '/sbin']}

    exec { 'add key file':
        command => '/usr/bin/wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | /usr/bin/apt-key add - ',
    }

    # TODO maybe delete
    file { '/etc/apt/sources.list.d/jenkins.list':

        content => "deb http://pkg.jenkins.io/debian-stable binary/\n \
                   deb http://httpredir.debian.org/debian ${::lsbdistcodename}-backports main",
        mode    => '0644',
        owner   => root,
        group   => root,
        require => Exec['add key file'],
    }

    exec { 'apt update':
        command => '/usr/bin/apt-get update',
        require => File['/etc/apt/sources.list.d/jenkins.list'],
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

    package { 'jenkins':
        ensure  => latest,
        require =>  Exec['openjdk'],
    }

    service { 'jenkins':
        ensure  => running,
        enable => true,
        require => Package['jenkins'],
    }

    notify {"CHECK AND INSTALLING NECESSARY PLUGINS IT CAN TAKE A LONG TIME (timeout 1800sec)":}

    # jenkins will install the missing plugins and ignore those ones it has
    exec {'install jenkins default plugins':
        command => 'cp /tmp/vagrant-puppet/manifests-*/Jenkins_plugins . &&
                    for i in $(cat ./Jenkins_plugins); do \
                    java -jar /var/cache/jenkins/war/WEB-INF/jenkins-cli.jar -s http://localhost:8080/ \
                    install-plugin $i \
                    --username "admin" --password $(cat /var/lib/jenkins/secrets/initialAdminPassword); done',
        provider => shell,
        # logoutput   => true,
        timeout     => 1800,
        require => Service['jenkins'],   
    }

    # ugly workaround (Duplicate declaration: Service jenkins)
    exec { 'jenkins stopped':
        command => 'systemctl stop jenkins',
        require => Exec['install jenkins default plugins'],
    }

    # TODO puppet:///modules/my_module/service.conf
    exec {'copy jenkins initial configs':
        command => 'test ! -d /var/lib/jenkins/workspace/virtual-environment &&
                    cp /tmp/vagrant-puppet/manifests-*/jenkins.initial.tar.gz / &&
                    tar xzf /jenkins.initial.tar.gz -C / &&
                    rm /jenkins.initial.tar.gz || true',
        require => Exec['jenkins stopped'],
    }

    # ugly workaround (Duplicate declaration: Service jenkins)
    exec { 'jenkins restart':
        command => 'systemctl start jenkins',
        require => Exec['copy jenkins initial configs'],
    }

    exec {'git':
        command => '/usr/bin/apt-get -y install git',
        require => Exec['jenkins restart'],
    }

    # TODO refactor
    exec {'maven':
        command => '/usr/bin/test ! -f /usr/local/bin/mvn && 
                    wget http://apache.ip-connect.vn.ua/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz &&
                    tar xzf apache-maven-3.5.2-bin.tar.gz &&
                    mv apache-maven-3.5.2 /opt/ &&
                    ln -s /opt/apache-maven-3.5.2/bin/mvn /usr/local/bin/mvn || 
                    true',
        require => Exec['git'],
    }

}
