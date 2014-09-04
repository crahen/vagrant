Vagrant.require_version ">= 1.6"


# Create minimal VMs with Docker installed
Vagrant.configure("2") do |config|


  # Virtual Box - VM
  config.vm.define :vbox do |v|

    v.vm.box = "ubuntu/trusty64"
    v.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
    v.vm.provider :virtualbox do |virtualbox, override|

      # Resource Configuration
      virtualbox.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]

      # SSH
      override.ssh.username = VAGRANT_SSH_USERNAME
      #override.ssh.private_key_path = File.expand_path(VAGRANT_SSH_KEY)
      #override.ssh.pty = true

    end

    # Docker
    v.vm.provision "shell", inline: "sudo apt-get -y update"
    v.vm.provision "shell", inline: "sudo apt-get -y install docker.io"
    v.vm.provision "shell", inline: "sudo ln -s /usr/bin/docker.io /usr/bin/docker"
    v.vm.provision "shell", inline: "sudo usermod -aG docker " + VAGRANT_SSH_USERNAME

  end


  # GCE
  config.vm.define :gce do |g|

    g.vm.box = "gce"
    g.vm.provider :google do |google, override|

      # Credentials
      google.google_project_id = GOOGLE_PROJECT_ID
      google.google_client_email = GOOGLE_SERVCE_ACCOUNT_EMAIL
      google.google_key_location = GOOGLE_SERVCE_ACCOUNT_KEY
      google.image = GOOGLE_IMAGE
      google.machine_type = GOOGLE_INSTANCE_TYPE

      # Resource Configuration
      google.metadata = {
        'sshKeys' => 'vagrant: ' + File.read(File.expand_path(VAGRANT_SSH_KEY + '.pub'))
      }

      # SSH
      override.ssh.username = VAGRANT_SSH_USERNAME
      override.ssh.private_key_path = File.expand_path(VAGRANT_SSH_KEY)
      override.ssh.pty = true

    end

    # Docker
    g.vm.provision "shell", inline: "sudo apt-get -y upgrade"
    g.vm.provision "shell", inline: "sudo apt-get -y update"
    g.vm.provision "shell", inline: "sudo apt-get -y install curl"
    g.vm.provision "shell", inline: "curl get.docker.io | sudo bash"
    g.vm.provision "shell", inline: "sudo usermod -a -G docker " + VAGRANT_SSH_USERNAME

  end


  # EC2
  config.vm.define :ec2 do |a|

    a.vm.box = "dummy"
    a.vm.provider :aws do |aws, override|

      # Credentials
      aws.access_key_id = AMAZON_ACCESS_KEY_ID
      aws.secret_access_key = AMAZON_SECRET_ACCESS_KEY

      # Resource Configuration
      aws.keypair_name = AMAZON_SSH_KEYPAIR_NAME
      aws.ami = AMAZON_IMAGE
      aws.instance_type = AMAZON_INSTANCE_TYPE
      aws.region = AMAZON_REGION
      aws.subnet_id = AMAZON_SUBNET
      aws.security_groups = [AMAZON_SECURITY_GROUP]
      aws.associate_public_ip = "true"
      aws.user_data = "#cloud-config\nsystem_info:\n  default_user:\n    name: vagrant"

      # SSH
      override.ssh.username = VAGRANT_SSH_USERNAME
      override.ssh.private_key_path = File.expand_path(VAGRANT_SSH_KEY)
      override.ssh.pty = true

    end

    # Docker
    a.vm.provision "shell", inline: "sudo yum -y update"
    a.vm.provision "shell", inline: "sudo yum -y install docker"
    a.vm.provision "shell", inline: "sudo usermod -a -G docker " + VAGRANT_SSH_USERNAME

  end


end
