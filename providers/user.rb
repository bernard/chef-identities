if Chef::Config[:solo]
  Chef::Log.warn("This recipe does not support Chef Solo. It requires search and data bags.")
else
  action :manage do
    u = data_bag_item(new_resource.data_bag, new_resource.name)
    user new_resource.name do
      begin
        Etc.getpwnam(new_resource.name)
        action :manage
      rescue ArgumentError
        action :create
      end
      # Options based on the data bag item
      comment u['comment'] if u['comment']
      uid u['uid'] if u['uid']
      gid u['gid'] if u['gid']
      password u['password'] if u['password']
      home u['home_dir'] if u['home_dir']
    end
  end

  action :remove do
    user new_resource.name do
      action :remove
    end
  end

  action :lock do
    user new_resource.name do
      action :lock
    end
  end

  action :lock do
    user new_resource.name do
      action :unlock
    end
  end
end
