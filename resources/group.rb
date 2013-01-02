actions :manage, :remove

attribute :data_bag, :kind_of => String, :default => "users"
attribute :gid
attribute :members, :kind_of => Array
attribute :system, :default => false
attribute :append, :default => false

def initialize(*args)
  super
  @action = :manage
end
