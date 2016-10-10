#!/bin/sh
## one script to be used by travis, jenkins, packer...

umask 022

rolesdir=$(dirname $0)/..

[ ! -d $rolesdir/sketchy ] && git clone https://github.com/juju4/ansible-sketchy $rolesdir/sketchy
[ ! -d $rolesdir/zzet.rbenv ] && git clone https://github.com/juju4/ansible-rbenv-role.git $rolesdir/zzet.rbenv
[ ! -d $rolesdir/adduser ] && git clone https://github.com/juju4/ansible-adduser $rolesdir/adduser
[ ! -d $rolesdir/geerlingguy.postgresql ] && git clone https://github.com/geerlingguy/ansible-role-postgresql.git $rolesdir/geerlingguy.postgresql

