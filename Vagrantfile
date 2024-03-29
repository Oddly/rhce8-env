# All disks that are added as second harddisk to the virtual machines.
file_to_disk1 = './disk-0-1.vdi'
file_to_disk2 = './disk-0-2.vdi'
file_to_disk3 = './disk-0-3.vdi'
file_to_disk4 = './disk-0-4.vdi'
file_to_disk5 = './disk-0-5.vdi'
# Vagrant configuration
Vagrant.configure(2) do |config|
# Use same SSH key for each machine
  config.ssh.insert_key = false
  config.vm.box_check_update = false

#input = STDIN.gets.chomp
# Configure the first VM, which acts as a repository.
config.vm.define "repo" do |repo|
  repo.vm.box = "rdbreak/rhel8repo"
  repo.vm.provision :shell, :inline => "sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config; sudo systemctl restart sshd;", run: "once"
  repo.vm.provision :shell, :inline => "yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y; sudo yum install -y sshpass python3-pip python3-devel httpd sshpass vsftpd createrepo policycoreutils-python-utils", run: "once"
  repo.vm.provision :shell, :inline => "python3 -m pip install -U pip; /usr/local/bin/pip3.6 install pexpect; /usr/local/bin/pip3.6 install ansible", run: "once"
  repo.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: "disk-*", rsync_auto: true, run: "always"
  repo.vm.network "private_network", ip: "192.168.56.199"
  repo.vm.provider "virtualbox" do |repo|
    repo.memory = "1024"
  end
  repo.trigger.after :up do |t|
    t.info = "rsync auto"
    t.run = {inline: "bash -c 'vagrant rsync-auto repo &'"}
  end
end

config.vm.define "node1" do |node1|
  node1.vm.box = "rdbreak/rhel8node"
  node1.vm.network "private_network", ip: "192.168.56.201"
  node1.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: "disk-*", rsync_auto: true, run: "always"
  node1.vm.provider "virtualbox" do |node1|
    node1.memory = "1024"

    if not File.exist?(file_to_disk1)
      node1.customize ['createhd', '--filename', file_to_disk1, '--variant', 'Fixed', '--size', 5 * 1024]
    end
    node1.customize ['storagectl', :id, '--name', 'SATA Controller', '--add', 'sata', '--portcount', 2]
    node1.customize ['storageattach', :id,  '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', file_to_disk1]
  end
  
    node1.vm.provision "shell", inline: <<-SHELL
    yes| sudo mkfs.ext4 /dev/sdb
    SHELL
 end

config.vm.define "node2" do |node2|
  node2.vm.box = "rdbreak/rhel8node"
  node2.vm.network "private_network", ip: "192.168.56.202"
  node2.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: "disk-*", rsync_auto: true, run: "always"
  node2.vm.provider "virtualbox" do |node2|
    node2.memory = "1024"

    if not File.exist?(file_to_disk2)
      node2.customize ['createhd', '--filename', file_to_disk2, '--variant', 'Fixed', '--size', 2 * 100]
    end
    node2.customize ['storagectl', :id, '--name', 'SATA Controller', '--add', 'sata', '--portcount', 2]
    node2.customize ['storageattach', :id,  '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', file_to_disk2]
  end
  
    node2.vm.provision "shell", inline: <<-SHELL
    yes| sudo mkfs.ext4 /dev/sdb
    SHELL
end
config.vm.define "node3" do |node3|
  node3.vm.box = "rdbreak/rhel8node"
  node3.vm.network "private_network", ip: "192.168.56.203"
  node3.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: "disk-*", rsync_auto: true, run: "always"
  node3.vm.provider "virtualbox" do |node3|
    node3.memory = "1024"

    if not File.exist?(file_to_disk3)
      node3.customize ['createhd', '--filename', file_to_disk3, '--variant', 'Fixed', '--size', 5 * 100]
    end
    node3.customize ['storagectl', :id, '--name', 'SATA Controller', '--add', 'sata', '--portcount', 2]
    node3.customize ['storageattach', :id,  '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', file_to_disk3]
  end
  
    node3.vm.provision "shell", inline: <<-SHELL
    yes| sudo mkfs.ext4 /dev/sdb
    SHELL
end

config.vm.define "node4" do |node4|
  node4.vm.box = "rdbreak/rhel8node"
  node4.vm.network "private_network", ip: "192.168.56.204"
  node4.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: "disk-*", rsync_auto: true, run: "always"
  node4.vm.provider "virtualbox" do |node4|
    node4.memory = "1024"

    if not File.exist?(file_to_disk4)
      node4.customize ['createhd', '--filename', file_to_disk4, '--variant', 'Fixed', '--size', 2 * 100]
    end
    node4.customize ['storagectl', :id, '--name', 'SATA Controller', '--add', 'sata', '--portcount', 2]
    node4.customize ['storageattach', :id,  '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', file_to_disk4]
  end

    node4.vm.provision "shell", inline: <<-SHELL
    yes| sudo mkfs.ext4 /dev/sdb
    SHELL
end

config.vm.define "node5" do |node5|
  node5.vm.box = "rdbreak/rhel8node"
  node5.vm.network "private_network", ip: "192.168.56.205"
  node5.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: "disk-*", rsync_auto: true, run: "always"
  node5.vm.provider "virtualbox" do |node5|
    node5.memory = "1024"

    if not File.exist?(file_to_disk5)
      node5.customize ['createhd', '--filename', file_to_disk5, '--variant', 'Fixed', '--size', 5 * 1024]
    end
    node5.customize ['storagectl', :id, '--name', 'SATA Controller', '--add', 'sata', '--portcount', 2]
    node5.customize ['storageattach', :id,  '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', file_to_disk5]
  end

    node5.vm.provision "shell", inline: <<-SHELL
    yes| sudo mkfs.ext4 /dev/sdb
    SHELL
end

config.vm.define "control" do |control|
  control.vm.box = "rdbreak/rhel8node"
  control.vm.network "private_network", ip: "192.168.56.200"
  control.vm.provider :virtualbox do |control|
    control.customize ['modifyvm', :id,'--memory', '2048']
  end
# Insert the previously selected exam environment into a file to be used by Ansible below.
#  control.vm.provision :shell, inline: "echo exam_version: #{input} > /vagrant/playbooks/vagrant_ansible.yml", run: "always"
  control.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: "disk-*", rsync_auto: true, run: "always"
  control.vm.provision :ansible_local, :run => "always" do |ansible|
  ansible.playbook = "/vagrant/playbooks/master.yml"
  ansible.install = false
  ansible.compatibility_mode = "2.0"
  ansible.inventory_path = "/vagrant/inventory"
  ansible.config_file = "/vagrant/ansible.cfg"
  ansible.limit = "all"
 end
end
end
