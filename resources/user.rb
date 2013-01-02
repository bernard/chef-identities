actions :manage, :remove, :lock, :unlock

attribute :data_bag, :kind_of => String, :default => "users"
attribute :system, :default => false

def initialize(*args)
  super
  @action = :manage
end
