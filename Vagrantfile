# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.synced_folder ".", "/home/vagrant/totaltrack-dotfiles"
  # config.vbguest.auto_update = false
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.cpus = 1
    vb.memory = 1024
  end

  config.vm.define "centos6", primary: true do |centos6|
    centos6.vm.box = "generic/centos6"
    centos6.vm.hostname = "TotalTrackDotFilesCentOS6"
    centos6.vm.provider "virtualbox" do |vb|
      vb.name = centos6.vm.hostname
    end
  end

  config.vm.define "debian11" do |debian11|
    debian11.vm.box = "generic/debian11"
    debian11.vm.hostname = "TotalTrackDotFilesDebian11"
    debian11.vm.provider "virtualbox" do |vb|
      vb.name = debian11.vm.hostname
    end
  end
end
