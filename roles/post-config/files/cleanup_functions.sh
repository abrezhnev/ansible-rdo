

function openstack_purge_tenants()
{
   SEARCH_STRING="${1: }"
   TENANTIDS=$( keystone tenant-list  | grep -v "\-\-\-\-" | grep -v admin | grep -v services | \
               grep "${SEARCH_STRING}" | \
               awk '{print $4}' | grep -v id )
   for ID in ${TENANTIDS}
   do    
       echo "Deleting tenant ${USERID}"
       keystone tenant-delete ${ID}
   done
}

function openstack_purge_users()
{
   SEARCH_STRING="${1: }"
   USERIDS=$( keystone user-list | grep -v "\-\-\-\-" | \
               grep -v " admin " | \
               grep -v " keystone " | \
               grep -v " cinder " | \
               grep -v " glance " | \
               grep -v " nova " | \
               grep -v " neutron " | \
               grep -v " heat " | \
               grep -v " ceilometer " | \
               grep "${SEARCH_STRING}" | \
               awk '{print $2}' | grep -v id )
   for USERID in ${USERIDS}
   do
       echo "Deleting user ${USERID}"
       keystone user-delete ${USERID}
   done
}

function openstack_purge_images()
{
   SEARCH_STRING="${1: }"
   IMAGEIDS=$( glance image-list| grep -v "\-\-\-\-" | grep -v "^| ID" | grep "${SEARCH_STRING}" | awk '{print $2}'  )
   for ID in ${IMAGEIDS}
   do
       echo "Deleting image ${ID}"
       glance image-delete ${ID}
   done
}

function openstack_purge_volumes()
{
    SEARCH_STRING="${1: }"
    for volume in `cinder list | egrep -v '\-\-|ID' | grep "${SEARCH_STRING}" | awk '{print $2}'`
    do
       echo "deleteing volume ${volume}"
       cinder delete ${volume}
    done
}

function openstack_purge_secgroups)
{
    SEARCH_STRING="${1: }"
    SGIDS=$( nova  secgroup-list | egrep -iv '\-\-\-\-|\| ID' | grep "${SEARCH_STRING}" | awk '{print $2}' )
    for sg in ${SGIDS}
    do
      echo deleting security-group ${sg}
      nova secgroup-delete ${sg}
    done
}


function openstack_purge_instances()
{
    SEARCH_STRING="${1: }"
    INSTIDS=$( nova list | egrep -v '\-\-\-\-|\| ID' | grep "${SEARCH_STRING}" | awk '{print $2}' )
    for inst in ${INSTIDS}
    do
      echo deleting instance ${inst}
      nova delete ${inst}
    done
}

function openstack_purge_ports()
{
    SEARCH_STRING="${1: }"
    for port in `neutron port-list -c id | egrep -v '\-\-|id' | grep "${SEARCH_STRING}" | awk '{print $2}'`
    do
        neutron port-delete ${port}
    done
}

function openstack_purge_routers()
{
    SEARCH_STRING="${1: }"
    for router in `neutron router-list -c id | egrep -v '\-\-|id' | grep "${SEARCH_STRING}" | awk '{print $2}'`
    do
        for subnet in `neutron router-port-list ${router} -c fixed_ips -f csv | egrep -o '[0-9a-z\-]{36}'`
        do
            neutron router-interface-delete ${router} ${subnet}        
        done
        neutron router-gateway-clear ${router}
        neutron router-delete ${router}
    done
}

function openstack_purge_subnets()
{
    SEARCH_STRING="${1: }"
    for subnet in `neutron subnet-list -c id | egrep -v '\-\-|id' | grep "${SEARCH_STRING}" | awk '{print $2}'`
    do
        neutron subnet-delete ${subnet}
    done
}

function openstack_purge_nets()
{
    SEARCH_STRING="${1: }"
    NETS=$( neutron net-list -c id -c name | egrep -v '\-\-\-\-|id' | grep "${SEARCH_STRING}" | awk '{print $2}'` )
    for net in $NETS
    do
        neutron net-delete ${net}
    done
}



