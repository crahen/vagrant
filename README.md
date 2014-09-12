# Vagrant

## Configure
### ~/.vagrant.d/Vagrantfile:

Run vagrant-bootstrap.sh and add your credentials to your personal Vagrantfile.

<pre>
&#35; Amazon Credentials - used to provision AWS Cloud environments
AMAZON_ACCESS_KEY_ID = "XXX"
AMAZON_SECRET_ACCESS_KEY = "XXX"
AMAZON_SSH_KEYPAIR_NAME = "vagrant"
AMAZON_SSH_PRIVATE_KEY = "~/.aws/vagrant.pem"

&#35; Amazon Resources
AMAZON_REGION = "us-west-2"
AMAZON_SECURITY_GROUP = "sg-8669e0e3"
AMAZON_SUBNET = "subnet-73407707"


&#35; Google Credentials - used to provision Google Cloud environments
GOOGLE_PROJECT_ID = "XXX"
GOOGLE_SERVCE_ACCOUNT_EMAIL = "XXX"
GOOGLE_SERVCE_ACCOUNT_KEY = "~/.google/vagrant.p12"

&#35; Google Resources
GOOGLE_ZONE = 'us-central2-a'


&#35; Vagrant SSH Credentials - used to SSH into environments created by Vagrant
VAGRANT_SSH_USERNAME = "vagrant"
VAGRANT_SSH_KEY = "~/.ssh/id_vagrant"
</pre>

### ~/.ssh/config:

Enable X11 forwarding in SSH.

<pre>
Host *
  ForwardX11 yes
</pre>

Create a VM

<pre>
vagrant up vbox
vagrant up ec2 --provider=aws
vagrant up gce --provider=google
</pre>


SSH into VM w/ X11 forwarding

<pre>
vagrant ssh vbox -- -Y
vagrant ssh ec2 -- -Y
vagrant ssh gce -- -Y
</pre>


Tear down VM

<pre>
vagrant destroy vbox
vagrant destroy ec2
vagrant destroy gce
</pre>
