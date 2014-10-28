#
# Cookbook Name:: identities
# Recipe:: test_manage
#
# Copyright (C) 2013 Jean-Francois Theroux
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

%w(test root jdoe).each { |user| identities_user user }

identities_user 'jsmith' do
  encrypted_databag true
  home_dir_perms 0755
end

identities_group 'operators' do
  gid 20000
end

group 'testers' do
  members ['root']
end

user 'joebob'

identities_group 'testers' do
  append true
  members ['joebob']
end
