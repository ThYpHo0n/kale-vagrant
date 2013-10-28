# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
	config.vm.box = "precise64"
	config.vm.box_url = "http://files.vagrantup.com/precise64.box"
	config.vm.share_folder "kale", "/opt/kale", "."
	config.vm.host_name = "kale.local"

	config.vm.provision :puppet, :options => "--modulepath=/opt/kale/puppet/modules" do |puppet|
		puppet.manifests_path = "puppet"
		puppet.manifest_file = "init.pp"
	end
end
