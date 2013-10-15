Vagrant.configure("2") do |config|
  config.vm.hostname = "identities-berkshelf"
  config.vm.box = "centos64-64-chef11"
  config.vm.box_url = "http://static.theroux.ca/vagrant/boxes/centos64-64-chef11.box"
  config.berkshelf.enabled = true
  # FIXME: need to update base boxe
  config.vm.provision :shell, :inline => "rpm -qi chef-11.6.2 || rpm -Uvh https://opscode-omnibus-packages.s3.amazonaws.com/el/6/x86_64/chef-11.6.2-1.el6.x86_64.rpm"

  config.vm.provision :chef_solo do |chef|
    chef.environments_path = 'environments'
    chef.environment = 'vagrant'
    chef.data_bags_path = 'data_bags'
    chef.json = {
    }

    chef.run_list = [
      "recipe[minitest-handler::default]",
      "recipe[chef-solo-search]",
      "recipe[identities::default]",
      "recipe[identities::test]"
    ]
  end
end
