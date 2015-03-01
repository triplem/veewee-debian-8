# Set up Vagrant.

date > /etc/phreevpn_box_build_time

# Create the user phreevpn with password phreevpn
useradd -G sudo -p $(perl -e'print crypt("phreevpn", "phreevpn")') -m -s /bin/bash -N phreevpn

# Install vagrant keys
# This is pretty unsecure, please use another key for connecting to the vagrant box
#mkdir -pm 700 /home/phreevpn/.ssh
#curl -Lo /home/phreevpn/.ssh/authorized_keys \
#  'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub'
#chmod 0600 /home/phreevpn/.ssh/authorized_keys
#chown -R phreevpn:phreevpn /home/phreevpn/.ssh

# Customize the message of the day
echo 'Welcome to your PhreeVPN-built virtual machine.' > /var/run/motd

# Install NFS client
#apt-get -y install nfs-common
