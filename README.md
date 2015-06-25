[![Build Status](https://travis-ci.org/failshell/chef-identities.svg?branch=master)](https://travis-ci.org/failshell/chef-identities)

This cookbook wraps most operations related to managing users by exposing a LWRP.

## LWRP: identities_user

### Available actions

+ **cleanup:** removes home directory and CRONs
+ **manage:** creates/modifies user, manages home directory and SSH authorized_keys
+ **remove:** removes user

### Available attributes

+ **authorized_keys:** Array of authorized_keys
+ **home_directory:** user's home directory
+ **gid:** user group id
+ **password:** Password hash
+ **shell:** user shell
+ **system:** make this a system user (UID/GID below 1000 usually). This disable the uid/gid attributes.
+ **uid:** user id

## License and Authors

Author:: Jean-Francois Theroux (<me@failshell.io>)
