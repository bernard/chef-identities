#
# Cookbook Name:: identities
# Recipe:: test_unlock
#
# Copyright (C) 2014 Jean-Francois Theroux
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

%w(test jdoe jsmith).each do |user|
  identities_user user do
    action :lock
  end
end

%w(test jdoe jsmith).each do |user|
  identities_user user do
    action :unlock
  end
end
