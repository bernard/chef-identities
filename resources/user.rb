actions :manage, :remove, :lock, :unlock, :cleanup

attribute :data_bag, :kind_of => String, :default => "users"
attribute :vault_data_bag, :kind_of => String, :default => "users_vault"
attribute :system, :default => false
attribute :shell, :default => false
attribute :encrypted_databag, :default => false
attribute :secret_file, :default => '/etc/chef/encrypted_data_bag_secret'
attribute :home_dir_perms, :kind_of => Integer, :default => 0700

def initialize(*args)
  super
  @action = :manage
end
