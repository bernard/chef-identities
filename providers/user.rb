use_inline_resources

action :manage do
  u = data_bag_item(new_resource.data_bag, new_resource.name)
  if new_resource.encrypted_databag
    if Chef::Config[:solo]
      secret = '/tmp/kitchen/encrypted_data_bag_secret'
    else
      secret = new_resource.secret_file
    end
    s = Chef::EncryptedDataBagItem.load_secret(secret)
    v = Chef::EncryptedDataBagItem.load(new_resource.vault_data_bag, new_resource.name, s)
  else
    v = data_bag_item(new_resource.vault_data_bag, new_resource.name)
  end

  if u['id'] == 'root'
    h = '/root'
  elsif node['users'] and node['users'][new_resource.name] and node['users'][new_resource.name]['home_dir']
    h = node['users'][new_resource.name]['home_dir']
  elsif u['home_dir']
    h = u['home_dir']
  else
    h = "/home/#{u['id']}"
  end

  user new_resource.name do
    comment u['comment'] if u['comment']
    uid u['uid'] if u['uid']
    gid u['gid'] if u['gid']
    password v['password'] if v['password']
    shell u['shell'] if u['shell']
    home h
  end

  # In some cases, the directory's ownership
  # reverts back to root during the first run.
  # Making sure we're idempotent.
  directory h do
    user new_resource.name
    group 'root'
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
    variables(:keys => v['authorized_keys'])
    not_if { v['authorized_keys'].nil? }
  end

  template "#{h}/.ssh/id_rsa.pub" do
    cookbook 'identities'
    source 'ssh_pub.erb'
    owner u['id']
    variables(:keys => v['ssh_pub'])
    not_if { v['ssh_pub'].nil? }
  end

  template "#{h}/.ssh/id_rsa" do
    cookbook 'identities'
    source 'ssh_priv.erb'
    owner u['id']
    variables(:keys => v['ssh_priv'])
    not_if { v['ssh_priv'].nil? }
    mode 0400
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

action :unlock do
  user new_resource.name do
    action :unlock
  end
end

action :cleanup do
  u = data_bag_item(new_resource.data_bag, new_resource.name)

  if u['id'] == 'root'
    h = '/root'
  elsif node['users'] and node['users'][new_resource.name] and node['users'][new_resource.name]['home_dir']
    h = node['users'][new_resource.name]['home_dir']
  elsif u['home_dir']
    h = u['home_dir']
  else
    h = "/home/#{u['id']}"
  end

  directory h do
    action :delete
    recursive true
  end
end
