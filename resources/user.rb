actions :manage, :remove, :lock, :unlock, :cleanup
default_action :manage

attribute :data_bag, :kind_of => String, :default => 'users'
attribute :encrypted_databag, :default => false
attribute :home_dir_perms, :kind_of => Integer, :default => 0700
attribute :secret_file, :default => '/etc/chef/encrypted_data_bag_secret'
attribute :shell, :kind_of => String
attribute :vault_data_bag, :kind_of => String, :default => 'users_vault'
