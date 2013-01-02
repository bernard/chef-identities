if Chef::Config[:solo]
  Chef::Log.warn("This recipe does not support Chef Solo. It requires search and data bags.")
else
  action :manage do
    members_list = Array.new
    search(new_resource.data_bag, "groups:#{new_resource.name}") do |m|
      members_list << m['id']
    end

    unless new_resource.members.nil?
      new_resource.members.each do |e|
        members_list << e
      end
    end

    group new_resource.name do
      begin
        Etc.getgrnam(new_resource.name)
        action :manage
      rescue ArgumentError
        action :create
      end
      gid new_resource.gid if new_resource.gid
      members members_list if members_list
      append new_resource.append if new_resource.append
      system new_resource.system if new_resource.system
    end
  end

  action :remove do
    group new_resource.name do
      action :remove
    end
  end
end
