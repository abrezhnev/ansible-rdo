#!/bin/bash


neutron net-create admin_net1     
neutron subnet-create admin_net1  10.0.0.0/24      
neutron net-create admin_net2      
neutron subnet-create admin_net2 10.0.1.0/24     
neutron router-create admin_router  

neutron subnet-list  
neutron net-list     

neutron router-interface-add admin_router [ 1 ]
neutron router-interface-add admin_router [ 2 ]

neutron net-create public --router:external=True
neutron subnet-create public 10.255.73.0/24 --disable-dhcp
neutron net-list -- --router:external=True

neutron router-gateway-set admin_router 2aff25f2-3eb5-4405-a8c1-a9e7cffb4d06  

neutron port-list -- --device_id=c31db1e3-5164-4b6d-8ff3-8af834ab0656

