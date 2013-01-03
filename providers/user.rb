def initialize(*args)
  super
  @action = :manage
end

if Chef::Config[:solo]
  Chef::Log.warn("This recipe does not support Chef Solo. It requires search and data bags.")
else
  action :manage do
    # Get user profile
    if new_resource.encrypted_databag == false
      u = data_bag_item(new_resource.data_bag, new_resource.name)
    else
      s = Chef::EncryptedDataBagItem.load_secret(new_resource.secret_file)
      u = Chef::EncryptedDataBagItem.load(new_resource.data_bag, new_resource.name, s)
    end

    # Create/manage user
    if u['home_dir']
      h = u['home_dir']
    else
      # Set sensible default
      h = "/home/#{u['id']}"
    end

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
      home h
    end

    # Manage SSH authorized keys
    if u['authorized_keys']
      directory "#{h}/.ssh" do
        owner u['id']
        mode 0700
      end

      template "#{h}/.ssh/authorized_keys" do
        cookbook 'identities'
        source 'authorized_keys.erb'
        owner u['id']
        variables( :keys => u['authorized_keys'] )
      end
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

  action :cleanup do
    # Get user profile
    if new_resource.encrypted_databag == false
      u = data_bag_item(new_resource.data_bag, new_resource.name)
    else
      s = Chef::EncryptedDataBagItem.load_secret(new_resource.secret_file)
      u = Chef::EncryptedDataBagItem.load(new_resource.data_bag, new_resource.name, s)
    end
    directory "#{u['home_dir']}" do
      action :delete
      recursive true
    end
  end
end
