class haproxy {

    if  !($::operatingsystem in ['Debian', 'Ubuntu']) {
         fail('This module only works on Debian or derivatives like Ubuntu')
    }

    Exec { path => ['/usr/local/bin', '/usr/local/sbin', '/usr/bin', '/usr/sbin', '/bin', '/sbin']}

    exec { 'apt update':
        command => 'apt-get update',
    }

    # TODO firewall

    package { 'haproxy':
        ensure  => latest,
    }

    # TODO copy config /etc/haproxy/haproxy.cfg

    service { 'haproxy':
        ensure  => running,
        require => Package['haproxy'],
    }


    # TODO 
    # wget https://releases.hashicorp.com/consul-template/0.19.4/consul-template_0.19.4_linux_amd64.tgz &&
    # tar xzf consul-template_0.19.4_linux_amd64.tgz && rm consul-template_0.19.4_linux_amd64.tgz && 
    # ./consul-template -consul-addr "192.168.52.10:8500" -template "/etc/haproxy/haproxy.cfg.ctmpl:/etc/haproxy/haproxy.cfg:service ha

}