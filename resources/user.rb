actions :manage, :remove, :lock, :unlock, :cleanup

attribute :data_bag, :kind_of => String, :default => "users"
attribute :system, :default => false
attribute :encrypted_databag, :default => false
attribute :secret_file, :default => '/etc/chef/encrypted_data_bag_secret'

def initialize(*args)
  super
  @action = :manage
end
