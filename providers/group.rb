use_inline_resources

action :manage do
  members_list = []
  search(new_resource.data_bag, "groups:#{new_resource.name}") do |m| # ~FC003
    members_list << m['id']
  end

  members_list += new_resource.members unless new_resource.members.nil?

  group new_resource.name do
    gid new_resource.gid if new_resource.gid
    members members_list if members_list
    append new_resource.append if new_resource.append
  end
end

action :remove do
  group new_resource.name do
    action :remove
  end
end
