#!/bin/bash -xe

######################################################################################
# Install Vagrant, Plugins and Boxes required to start VMs in EC2, GCE or Virtual Box


VAGRANT_DEB=https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.4_x86_64.deb
VAGRANT_SSH_KEY=~/.ssh/id_vagrant


#############################################################
# Generate an SSH host keypair, this will be used by Vagrant
# to issue commands over SSH to guest machines.
if [ ! -e $VAGRANT_SSH_KEY ]; then
  mkdir -p ~/.ssh
  ssh-keygen -t rsa -f $VAGRANT_SSH_KEY -N '' -C 'vagrant@cloud'
fi


##########################
# Install/Upgrade Vagrant
vagrant_upgrade() {
  sudo apt-get install vagrant
  wget $VAGRANT_DEB
  sudo dpkg -i vagrant_1.6.4_x86_64.deb
  rm vagrant_1.6.4_x86_64.deb
}
dpkg -l vagrant | grep -q 1.6 || vagrant_upgrade


###################################
# Bootstrap Vagrant Amazon Support 
vagrant_amazon_bootstrap() {
  vagrant plugin install vagrant-aws
  vagrant box add dummy https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box
}
vagrant plugin list | grep -q vagrant-aws || vagrant_amazon_bootstrap


###################################
# Bootstrap Vagrant Google Support
vagrant_google_bootstrap() {
  vagrant plugin install vagrant-google
  vagrant box add gce https://github.com/mitchellh/vagrant-google/raw/master/google.box
}
vagrant plugin list | grep -q vagrant-google || vagrant_google_bootstrap


###############################
# Bootstrap VirtualBox Support
vagrant_virtualbox_bootstrap() {
  # Create an ISO to mount w/ virtualbox machine that contains cloud-config
  # that bootstraps the instance.
  # Install the public key from: ~/.ssh/id_vagrant.pub
  localds_url="http://bazaar.launchpad.net/~cloud-utils-dev/cloud-utils/trunk/download/head:/cloudlocalds-20120823015036-zkgo0cswqhhvener-1/cloud-localds"
  which cloud-localds ||
  { sudo wget "$localds_url" -O /usr/bin/cloud-localds &&
    sudo chmod 755 /usr/bin/cloud-localds; }
  config_iso="my-user-data.iso"
  if [ ! -e $config_iso ]; then
cat > my-user-data <<EOF
#cloud-config
#default_user:
#  name: vagrant
#  ssh_authorized_keys:
#    - $(cat $HOME/.ssh/id_vagrant.pub)
runcmd:
  - [ sh, "-c", "echo \"$(cat $HOME/.ssh/id_vagrant.pub)\" > /home/vagrant/.ssh/authorized_keys; chown vagrant:vagrant /home/vagrant/.ssh/authorized_keys; chmod 644 /home/vagrant/.ssh/authorized_keys;" ]
EOF
    cloud-localds "$config_iso" my-user-data && rm my-user-data
  fi
}
vagrant_virtualbox_bootstrap
