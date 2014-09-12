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
