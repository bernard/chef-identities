def initialize(*args)
  super
  @action = :manage
end

if Chef::Config[:solo]
  Chef::Log.warn("This recipe does not support Chef Solo. It requires search and data bags.")
else
  action :manage do
    # Get user profile
<<<<<<< HEAD
    if new_resource.encrypted_databag == false
      u = data_bag_item(new_resource.data_bag, new_resource.name)
    else
      s = Chef::EncryptedDataBagItem.load_secret(new_resource.secret_file)
      u = Chef::EncryptedDataBagItem.load(new_resource.data_bag, new_resource.name, s)
    end
=======
    u = data_bag_item(new_resource.data_bag, new_resource.name)
>>>>>>> e9e095aa1b9755e34948bc48cdf87529bebc74e0

    # Create/manage user
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

    # Manage SSH authorized keys
    if u['authorized_keys']
      directory "#{u['home_dir']}/.ssh" do
        owner u['id']
        mode 0700
      end

      template "#{u['home_dir']}/.ssh/authorized_keys" do
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
<<<<<<< HEAD
    # Get user profile
    if new_resource.encrypted_databag == false
      u = data_bag_item(new_resource.data_bag, new_resource.name)
    else
      s = Chef::EncryptedDataBagItem.load_secret(new_resource.secret_file)
      u = Chef::EncryptedDataBagItem.load(new_resource.data_bag, new_resource.name, s)
    end
=======
    u = data_bag_item(new_resource.data_bag, new_resource.name)
>>>>>>> e9e095aa1b9755e34948bc48cdf87529bebc74e0
    directory "#{u['home_dir']}" do
      action :delete
      recursive true
    end
  end
end
