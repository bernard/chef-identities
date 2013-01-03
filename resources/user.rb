actions :manage, :remove, :lock, :unlock, :cleanup

attribute :data_bag, :kind_of => String, :default => "users"
attribute :system, :default => false
<<<<<<< HEAD
attribute :encrypted_databag, :default => false
attribute :secret_file, :default => '/etc/chef/encrypted_data_bag_secret'
=======
>>>>>>> e9e095aa1b9755e34948bc48cdf87529bebc74e0

def initialize(*args)
  super
  @action = :manage
end
