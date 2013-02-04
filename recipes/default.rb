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
    [ 'make', 'gcc', 'ruby-devel' ].each do |pkg|
      package pkg do
      end
    end
  when 'debian'
    [ 'make', 'gcc', 'ruby-dev' ].each do |pkg|
      package pkg do
      end
    end
end

execute 'install_ruby_shadow' do
  command 'gem install ruby-shadow'
end
