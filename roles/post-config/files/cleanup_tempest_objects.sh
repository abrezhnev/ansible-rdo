#!/bin/bash

. ~/cleanup_functions.sh 

openstack_purge_routers "[0-9]\-router"
openstack_purge_ports
openstack_purge_subnets "[0-9]\-subnet"
openstack_purge_nets "[0-9]\-network"
openstack_purge_instances
openstack_purge_secgroups "\-secgroup"
openstack_purge_volumes "volume\-[0-9]"
openstack_purge_users "[0-9]\-user"
openstack_purge_users "[0-9]\-tenant"
