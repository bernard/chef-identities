#
# Cookbook Name:: identities
# Recipe:: user_manage_test
#
# Copyright (C) 2015 Jean-Francois Theroux
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

# basic user
identities_user 'user'

# custom home
identities_user 'user2' do
  home_directory '/opt/user2'
end

# make sure root's home is /root
identities_user 'root'

# system user
identities_user 'user3' do
  system true
end

# uid/gid
group 'user4' do
  gid 10000
end

identities_user 'user4' do
  uid 10000
  gid 10000
end

# login shell
identities_user 'user5' do
  shell '/sbin/nologin'
end

# password
identities_user 'user6' do
  password '$1$usao0TkK$jAJeH39oym.Bn37APZh.T/'
end

# change existing user
user 'user7' do
  uid 20000
end

identities_user 'user7' do
  uid 30000
end

# authorized_keys
identities_user 'user8' do
  authorized_keys %w(foo bar)
end
