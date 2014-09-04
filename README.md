# Vagrant

## Configure

Run vagrant-bootstrap.sh and add your credentials to your personal Vagrantfile

### ~/.vagrant.d/Vagrantfile:

> &#35; Amazon Credentials - used to provision AWS Cloud environments
> AMAZON_ACCESS_KEY_ID = "XXX"
> AMAZON_SECRET_ACCESS_KEY = "XXX"
> AMAZON_SSH_KEYPAIR_NAME = "vagrant"
> AMAZON_SSH_PRIVATE_KEY = "~/.aws/vagrant.pem"
> 
> &#35; Amazon Resources
> AMAZON_IMAGE = "ami-d13845e1"
> AMAZON_REGION = "us-west-2"
> AMAZON_INSTANCE_TYPE = "t2.micro"
> AMAZON_SECURITY_GROUP = "sg-8669e0e3"
> AMAZON_SUBNET = "subnet-73407707"
> 
> 
> &#35; Google Credentials - used to provision Google Cloud environments
> GOOGLE_PROJECT_ID = "XXX"
> GOOGLE_SERVCE_ACCOUNT_EMAIL = "XXX"
> GOOGLE_SERVCE_ACCOUNT_KEY = "~/.google/vagrant.p12"
> 
> &#35; Google Resources
> GOOGLE_IMAGE = 'debian-7-wheezy-v20140619'
> GOOGLE_INSTANCE_TYPE = 'n1-standard-1'
> GOOGLE_ZONE = 'us-central2-a'
> 
> 
> &#35; Vagrant SSH Credentials - used to SSH into environments created by Vagrant
> VAGRANT_SSH_USERNAME = "vagrant"
> VAGRANT_SSH_KEY = "~/.ssh/id_vagrant"


## Usage

Create VM

> vagrant up vbox
> vagrant up ec2 --provider=aws
> vagrant up gce --provider=google


Control VM

> vagrant ssh vbox
> vagrant ssh ec2
> vagrant ssh gce


Destroy VM

> vagrant destroy vbox
> vagrant destroy ec2
> vagrant destroy gce
