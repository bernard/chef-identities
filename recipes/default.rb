#
# Cookbook Name:: identities
# Recipe:: default
#
# Copyright 2013, THX Systems
#
# License: GPLv2

package 'rubygems' do
end

case node[:platform_family]
  when 'rhel', 'suse'
    package 'ruby-devel' do
    end
  when 'debian'
    package 'ruby-dev' do
    end
end

execute 'install_ruby_shadow' do
  command 'gem install ruby-shadow'
end
