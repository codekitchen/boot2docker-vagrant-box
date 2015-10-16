#!/bin/sh

set -e

# Inserting vagrant key in the userdata.tar which should be deployed when boot2docker boot
B2D_PERSISTENT_DIR=/var/lib/boot2docker
TMP_USERDATA_DIR=/tmp/userdata

mkdir -p ${TMP_USERDATA_DIR}/.ssh

cat <<KEY >${TMP_USERDATA_DIR}/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key
KEY
chmod 0600 ${TMP_USERDATA_DIR}/.ssh/authorized_keys


cd ${TMP_USERDATA_DIR}
tar cf ${B2D_PERSISTENT_DIR}/userdata.tar ./.ssh


## I want to re-use the bootlocal.sh stuff, but adding one optionnaly from the /vagrant folder
cat <<EOF >${B2D_PERSISTENT_DIR}/bootlocal.sh
sudo /usr/local/etc/init.d/nfs-client start

# Ensure mount.vmhgfs is present for non-interactive shells
# Fixes issue with Vagrant unable to mount shared directories automatically
ln -s /usr/local/sbin/mount.vmhgfs /bin/mount.vmhgfs
EOF
sudo chmod a+x ${B2D_PERSISTENT_DIR}/bootlocal.sh

echo "all done"