def initialize(*args)
  super
  @action = :manage
end

action :manage do
  # Get user profile and vault
  u = data_bag_item(new_resource.data_bag, new_resource.name)
  if new_resource.encrypted_databag == true
    s = Chef::EncryptedDataBagItem.load_secret(new_resource.secret_file)
    v = Chef::EncryptedDataBagItem.load(new_resource.vault_data_bag, new_resource.name, s)
  else
    v = data_bag_item(new_resource.vault_data_bag, new_resource.name)
  end

  # Create/manage user
  if node['users'][new_resource.name]['home_dir']
    h = node['users'][new_resource.name]['home_dir']
  elsif u['id'] == 'root'
    h = '/root'
  elsif u['home_dir']
    h = u['home_dir']
  else
    # Set sensible default
    h = "/home/#{u['id']}"
  end

  # Required for SLES ...
  directory h do
    user new_resource.name
    mode new_resource.home_dir_perms
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
    password v['password'] if v['password']
    shell u['shell'] if u['shell']
    home h
  end

  # Manage the user's home in case it was not created already
  directory h do
    user new_resource.name
    mode new_resource.home_dir_perms
  end

  directory "#{h}/.ssh" do
    owner u['id']
    mode 0700
  end

  template "#{h}/.ssh/authorized_keys" do
    cookbook 'identities'
    source 'authorized_keys.erb'
    owner u['id']
    variables( :keys => v['authorized_keys'] )
    not_if { v['authorized_keys'].nil? }
  end

  new_resource.updated_by_last_action(true)
end

action :remove do
  user new_resource.name do
    action :remove
  end

  new_resource.updated_by_last_action(true)
end

action :lock do
  user new_resource.name do
    action :lock
  end

  new_resource.updated_by_last_action(true)
end

action :lock do
  user new_resource.name do
   action :unlock
  end

  new_resource.updated_by_last_action(true)
end

action :cleanup do
  # Get user profile
  if new_resource.encrypted_databag == false
    u = data_bag_item(new_resource.data_bag, new_resource.name)
  else
    s = Chef::EncryptedDataBagItem.load_secret(new_resource.secret_file)
    u = Chef::EncryptedDataBagItem.load(new_resource.data_bag, new_resource.name, s)
  end

  directory u['home_dir'] do
    action :delete
    recursive true
  end

  new_resource.updated_by_last_action(true)
end
