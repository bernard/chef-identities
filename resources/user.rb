actions :manage, :remove
default_action :manage

attribute :home_directory, :kind_of => String, :default => nil
attribute :gid, :kind_of => Integer, :default => nil
attribute :password, :kind_of => String, :default => nil
attribute :shell, :kind_of => String, :default => '/bin/bash'
attribute :system, :kind_of => [TrueClass, FalseClass], :default => false
attribute :uid, :kind_of => Integer, :default => nil
