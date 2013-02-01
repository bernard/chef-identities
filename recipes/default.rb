#
# Cookbook Name:: identities
# Recipe:: default
#
# Copyright 2013, THX Systems
#
# License: GPLv2

package 'rubygems' do
end

execute 'install_ruby_shadow' do
  command 'gem install ruby-shadow'
end
