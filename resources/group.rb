actions :manage, :remove
default_action :manage

attribute :append, :default => false
attribute :data_bag, :kind_of => String, :default => 'users'
attribute :gid
attribute :members, :kind_of => Array
