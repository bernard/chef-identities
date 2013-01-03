Description
===========

Cookbook that creates LWRPs to manage users/groups. Inspired by the Opscode 'users' cookbook. But more complete.

Requirements
============

In order for this cookbook to work properly, you need to install the ruby-shadow gem.

Users data bag example
======================

	{
	  "home_dir": "/root",
	  "shell": "/bin/bash",
	  "uid": 0,
	  "groups": [
	    "root"
	  ],
	  "comment": "The all mighty root",
	  "id": "root"
	}

If keys are missing, it's not a problem. The provider will just use the user resource's defaults.

# Users vault data bag example
==============================

        {
          "authorized_keys": [
            "some SSH key"
          ],
          "password": "some password hash"
        }

NOTE: Passwords and SSH keys need to be stored in an encrypted data bag. 

User management example
=======================

	identities_user 'root' do
	  data_bag 'foo'
	  encrypted_databag true
	  secret_file '/etc/chef/example'
	end

In the above example, the values will be taken from the 'foo' data bag instead of the 'users' default.

Actions:

* :manage => create/manage user
* :remove => delete user (leaves home directory)
* :lock => lock user
* :unlock => unlock user
* :cleanup => remove home directory

Group management
================

	identities_group 'root' do
	  data_bag 'foo'
	  members [ 'foo', 'bar' ]
	  gid 0
	end

In the above example, the members of the group are specified. But the group provider will also search the specified data bag for the 'groups' key to append those members as well.

Actions:

* :manage => create/manage
* :remove => delete group
