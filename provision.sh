#!/bin/bash

SCRIPT_PREFIX="kitchen"
OS=rvm
STORAGE_PATH="/data/lxd/"${SCRIPT_PREFIX}
IP="10.120.11"
IFACE="eth0"
IP_SUBNET=${IP}".1/24"
POOL=${SCRIPT_PREFIX}"-pool"
SCRIPT_PROFILE_NAME=${SCRIPT_PREFIX}"-profile"
SCRIPT_BRIDGE_NAME=${SCRIPT_PREFIX}"-br"
NAME=${SCRIPT_PREFIX}
IMAGE=${OS}



# check if jq exists
if ! snap list | grep jq >>/dev/null 2>&1; then
  sudo snap install jq 
fi
# check if lxd exists
if ! snap list | grep lxd >>/dev/null 2>&1; then
  sudo snap install lxd 
fi


if ! [ -d ${STORAGE_PATH} ]; then
    sudo mkdir -p ${STORAGE_PATH}
fi

# creating the pool
lxc storage create ${POOL} btrfs 

#create network bridge
lxc network create ${SCRIPT_BRIDGE_NAME} ipv6.address=none ipv4.address=${IP_SUBNET} ipv4.nat=true

# creating needed profile
lxc profile create ${SCRIPT_PROFILE_NAME}

# editing needed profile
echo "config:
devices:
  ${IFACE}:
    name: ${IFACE}
    network: ${SCRIPT_BRIDGE_NAME}
    type: nic
  root:
    path: /
    pool: ${POOL}
    type: disk
name: ${SCRIPT_PROFILE_NAME}" | lxc profile edit ${SCRIPT_PROFILE_NAME} 


#create master container
lxc init ${IMAGE} ${NAME} --profile ${SCRIPT_PROFILE_NAME}
lxc network attach ${SCRIPT_BRIDGE_NAME} ${NAME} ${IFACE}
lxc config device set ${NAME} ${IFACE} ipv4.address ${IP}.2
lxc start ${NAME} 

lxc storage volume create ${POOL} ${NAME}
lxc config device add ${NAME} ${POOL} disk pool=${POOL} source=${NAME} path=${STORAGE_PATH}
sudo lxc config device add ${NAME} ${NAME}-script-share disk source=${PWD}/scripts path=/lxd
lxc config set ${NAME} security.nesting=true security.syscalls.intercept.mknod=true security.syscalls.intercept.setxattr=true

sudo lxc exec ${NAME} -- /bin/bash /lxd/${NAME}.sh
# adding workspace
sudo lxc config device add ${NAME} ${NAME}-worskspace-share disk source=${PWD}/workspace path=/home/ubuntu/workspace
#save container as image
lxc stop ${NAME}
lxc publish ${NAME} --alias ${NAME} 
lxc start ${NAME}









