# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANT_API_VERSION = "2"
VAGRANT_DEFAULT_PROVIDER = "virtualbox"


$install_puppet = <<SCRIPT
echo "deb http://ftp.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list && \
apt-get update && \
apt-get -t jessie-backports install puppet -y
SCRIPT


Vagrant.configure(VAGRANT_API_VERSION) do |config|

    Vagrant.require_version '>= 1.8.7'

    config.vm.box = "debian/jessie64"

    if Vagrant::Util::Platform.linux? then
        # Memory, 15% of RAM or 1Gb on big mem amount
        memTotal = `grep MemTotal /proc/meminfo | awk '{print $2}'`
        vmMem = memTotal.to_i * 0.15 / 1024 / 1024
        vmMem = (vmMem > 1) ? 1 : vmMem
        vmMem *= 1024 #to MB
        vmCores = `nproc`
    else
        vmMem = 512
        vmCores = 1
    end
    
    config.vm.provider VAGRANT_DEFAULT_PROVIDER do |vb|
        vb.memory = vmMem
        vb.cpus = vmCores
        vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
    end

    ["jenkins", "code", "code2", "haproxy"].each_with_index do |roleName, index|
        config.vm.define "#{roleName}-vm" do |vm_env|
            # hostname = "#{roleName}#{index}-vm.staging.vagrant"
            hostname = "#{roleName}-vm.staging.vagrant"
            vm_env.vm.hostname = hostname

            # start from 192.168.52.10
            vm_env.vm.network :private_network, ip: "192.168.52.#{index+10}"

            if roleName == "jenkins"
                vm_env.vm.network "forwarded_port", guest: 8080, host: "8090"
                vm_env.vm.network "forwarded_port", guest: 8100, host: "8100"
            end
            
            vm_env.vm.provision "shell", inline: $install_puppet

            vm_env.vm.provision "puppet" do |puppet|
                puppet.manifests_path = "puppet/manifests"
                puppet.module_path = ["puppet/modules", "puppet/my_modules"]
                puppet.manifest_file  = "#{roleName}.pp"
            end

        end
    end

end
