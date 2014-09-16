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


## Vagrant w/ X11 Support

Create a VM

<pre>
vagrant up vbox
vagrant up ec2 --provider=aws
vagrant up gce --provider=google
</pre>


SSH into VM w/ X11 forwarding

<pre>
vagrant ssh vbox -- -Y
vagrant ssh ec2 --  -Y
vagrant ssh gce --  -Y
</pre>


Tear down VM

<pre>
vagrant destroy vbox
vagrant destroy ec2
vagrant destroy gce
</pre>


## Vagrant + Xpra (Resumable X11 Session)

Create X11 session running in docker

<pre>
vagrant ssh vbox -- -Y xpra start :$SESSION
vagrant ssh ec2 --  -Y xpra start :$SESSION
vagrant ssh gce --  -Y xpra start :$SESSION
</pre>


Attach to X11 session running in docker

<pre>
vagrant ssh vbox -- -Y xpra attach :$SESSION
vagrant ssh ec2 --  -Y xpra attach :$SESSION
vagrant ssh gce --  -Y xpra attach :$SESSION
</pre>


Destroy X11 session

<pre>
vagrant ssh vbox -- -Y xpra stop :$SESSION
vagrant ssh ec2 --  -Y xpra stop :$SESSION
vagrant ssh gce --  -Y xpra stop :$SESSION
</pre>


## Vagrant + Docker w/ X11 Support

Start a docker container connected to an X11 session

<pre>
DISPLAY=:$SESSION
XAUTH=/tmp/Xauthority-$SESSION
XSOCK=/tmp/.X11-unix/X$SESSION
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
TAG=ubuntu
CMD=true
</pre>

<pre>
vagrant ssh vbox -- -Y docker run -e DISPLAY=:$DISPLAY -e XAUTHORITY=$XAUTH -v $XSOCK:$XSOCK -v $XAUTH:$XAUTH -i -t $TAG $CMD
vagrant ssh ec2 --  -Y docker run -e DISPLAY=:$DISPLAY -e XAUTHORITY=$XAUTH -v $XSOCK:$XSOCK -v $XAUTH:$XAUTH -i -t $TAG $CMD
vagrant ssh gce --  -Y docker run -e DISPLAY=:$DISPLAY -e XAUTHORITY=$XAUTH -v $XSOCK:$XSOCK -v $XAUTH:$XAUTH -i -t $TAG $CMD
</pre>

Stop / kill a docker container

<pre>
vagrant ssh vbox -- -Y docker stop|kill $CONTAINER
vagrant ssh ec2 --  -Y docker stop|kill $CONTAINER
vagrant ssh gce --  -Y docker stop|kill $CONTAINER
</pre>




