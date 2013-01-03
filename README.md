Description
===========
<<<<<<< HEAD

=======
>>>>>>> e9e095aa1b9755e34948bc48cdf87529bebc74e0
Cookbook that creates LWRPs to manage users/groups. Inspired by the Opscode 'users' cookbook. But more complete.

Requirements
============
<<<<<<< HEAD

In order for this cookbook to work properly, you need to install the ruby-shadow gem.

Data bag example
================

{
  "authorized_keys": [
    "some SSH key"
  ],
  "home_dir": "/root",
  "shell": "/bin/bash",
  "uid": 0,
  "password": "some password hash",
  "groups": [
    "root"
  ],
  "comment": "The all mighty root",
  "id": "root"
}

If keys are missing, it's not a problem. The provider will just use the user resource's defaults.

User management example
=====

identities_user 'root' do
  data_bag 'foo'
  encrypted_databag true
  secret_file '/etc/chef/example'
end

In the above example, the values will be taken from the 'foo' data bag instead of the 'users' default.

Group management
=====

identities_group 'root' do
  data_bag 'foo'
  members [ 'foo', 'bar' ]
  gid 0
end

In the above example, the members of the group are specified. But the group provider will also search the specified data bag for the 'groups' key to append those members as well.
=======
In order for this cookbook to work properly, you need to install the ruby-shadow gem.

User management
=====
To come...

Group management
=====
To come...
>>>>>>> e9e095aa1b9755e34948bc48cdf87529bebc74e0
