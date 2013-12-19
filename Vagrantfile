Vagrant.configure("2") do |config|
  config.vm.hostname = "identities-berkshelf"
  config.vm.box = "centos64-64-chef11"
  config.vm.box_url = "http://static.theroux.ca/vagrant/boxes/centos64-64-chef11.box"
  config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest

  config.vm.provision :chef_solo do |chef|
    chef.environments_path = 'environments'
    chef.environment = 'vagrant'
    chef.data_bags_path = 'data_bags'
    chef.json = {
      "users" => {
        "test" => {
          "home_dir" => "/tmp/test"
        }
      }
    }

    chef.run_list = [
      "recipe[minitest-handler::default]",
      "recipe[chef-solo-search]",
      "recipe[identities::default]",
      "recipe[identities::test]"
    ]
  end
end
