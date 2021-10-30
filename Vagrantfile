Vagrant.configure("2") do |config|
# Define VMs with static private IP addresses, vcpu, memory and vagrant-box.
  servers = [
    {
      :name => "web1.devopscafe.com",
      :box => "centos/8",
      :ram => 1024,
      :vcpu => 1,
      :ip => "192.168.50.14"
    },
    {
      :name => "web2.devopscafe.com",
      :box => "centos/8",
      :ram => 1024,
      :vcpu => 1,
      :ip => "192.168.50.19"
    },
    {
      :name => "db.devopscafe.com",
      :box => "bento/ubuntu-18.04",
      :ram => 1024,
      :vcpu => 1,
      :ip => "192.168.50.26"
    },
    {
      :name => "ansible-server",
      :box => "centos/8",
      :ram => 8048,
      :vcpu => 1,
      :ip => "192.168.50.13"
    }
  ]

  # Provision each of the VMs.
  servers.each do |machine|
    config.vm.define machine[:name] do |config|

# => OS and machine name decalartion

      config.vm.box = machine[:box]
      config.vm.hostname = machine[:name]

# => Memory and Cpu decalartion
      config.vm.provider :virtualbox do |v|
        v.memory = machine[:ram]
        v.cpus = machine[:vcpu]
      end

# => Network ip decalartion
      config.vm.network :private_network, ip: machine[:ip]
      #config.vm.network "forwarded_port", guest: 22, host: machine[:ssh_port], id: "ssh"

# => ssh key decalartion
      #config.vm.synced_folder ".", "/vagrant", id: "vagrant-root", disabled: true
      id_rsa_key_pub = File.read(File.join(Dir.home, ".ssh", "vagrant_id_rsa.pub"))
      
      # config.vm.provision "shell", inline: <<-SHELL
      #    "echo 'Creating SSH key path' && mkdir -p ~/vagrant/.ssh/ && chmod 600 ~/vagrant/.ssh/"
      # SHELL

      # config.vm.provision "shell", inline: <<-SHELL
      #    "echo 'appending SSH public key to ~/vagrant/.ssh/authorized_keys' && echo '#{id_rsa_key_pub}' >> ~/vagrant/.ssh/authorized_keys && chmod 600 ~/vagrant/.ssh/authorized_keys"
      # SHELL
    config.vm.provision "shell", inline: <<-SHELL
      echo 'Copying public SSH Keys to the VM'
      mkdir -p /home/vagrant/.ssh
      chmod 600 /home/vagrant/.ssh
      echo '#{id_rsa_key_pub}' >> /home/vagrant/.ssh/authorized_keys
      chmod -R 600 /home/vagrant/.ssh/authorized_keys
      echo 'Host 192.168.*.*' >> /home/vagrant/.ssh/config
      echo 'StrictHostKeyChecking no' >> /home/vagrant/.ssh/config
      echo 'UserKnownHostsFile /dev/null' >> /home/vagrant/.ssh/config
      chmod -R 600 /home/vagrant/.ssh/config
      SHELL
    
    end
  end

      config.ssh.insert_key = false

  # if [:name] == "ansible-server" then
  #     config.vm.provision machine[:name] do |shell|
  #       shell.path = "scripts/install_ansible.sh"
  # end
end