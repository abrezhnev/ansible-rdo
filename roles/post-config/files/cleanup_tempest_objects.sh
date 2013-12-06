#!/bin/bash

. ~/clenaup_functions.sh 

openstack_purge_ports
openstack_purge_routers
openstack_purge_subnets
openstack_purge_nets
openstack_purge_instances
openstack_purge_volumes
openstack_purge_users "\-user"
openstack_purge_users "\-tenant"
