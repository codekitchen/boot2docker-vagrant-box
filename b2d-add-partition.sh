#!/bin/sh

set -e

# Creating one partition and formating to ext4
# See https://github.com/boot2docker/boot2docker/issues/531#issuecomment-61740859
echo "n
p
1


w
p
q
"| /sbin/fdisk /dev/sda
/sbin/mkfs.ext4 -L boot2docker-data /dev/sda1

/etc/rc.d/automount