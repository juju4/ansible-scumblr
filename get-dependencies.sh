#!/bin/sh
## one script to be used by travis, jenkins, packer...

umask 022

rolesdir=$(dirname $0)/..

[ ! -d $rolesdir/juju4.sketchy ] && git clone https://github.com/juju4/ansible-sketchy $rolesdir/juju4.sketchy
[ ! -d $rolesdir/zzet.rbenv ] && git clone https://github.com/juju4/ansible-rbenv-role.git $rolesdir/zzet.rbenv
[ ! -d $rolesdir/juju4.adduser ] && git clone https://github.com/juju4/ansible-adduser $rolesdir/juju4.adduser
[ ! -d $rolesdir/geerlingguy.postgresql ] && git clone https://github.com/geerlingguy/ansible-role-postgresql.git $rolesdir/geerlingguy.postgresql

