#!/bin/sh

HUGETBLFS_PATH=/mnt/huge
DPDK_DIR_PATH=/home/taguchi/dpdk-2.0.0
LANG=en.US_UTF-8
export RTE_SDK=${DPDK_DIR_PATH}
export RTE_TARGET=${DPDK_DIR_PATH}/x86_64-native-linuxapp-gcc

# for 2MB huge page
# 1GB 512pages

if [ ! `whoami` = 'root' ]; then
   echo "ROOT  ONLY"
   exit
fi

if [ ! -e ${HUGETBLFS_PATH} ]; then
    mkdir ${HUGETBLFS_PATH}
fi

echo 11264 > /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages
#echo 11264 > /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages

# settings for dpdk

modprobe uio
insmod ${DPDK_DIR_PATH}/x86_64-native-linuxapp-gcc/kmod/igb_uio.ko

sudo ${DPDK_DIR_PATH}/tools/dpdk_nic_bind.py --bind=igb_uio enp1s0f0
sudo ${DPDK_DIR_PATH}/tools/dpdk_nic_bind.py --bind=igb_uio enp1s0f1
sudo ${DPDK_DIR_PATH}/tools/dpdk_nic_bind.py --bind=igb_uio enp1s0f2
sudo ${DPDK_DIR_PATH}/tools/dpdk_nic_bind.py --bind=igb_uio enp1s0f3
sudo ${DPDK_DIR_PATH}/tools/dpdk_nic_bind.py --status

