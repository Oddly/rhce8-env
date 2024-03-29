# RHCE 8 Practice environment
_Powered by Ansible and Vagrant

IMPORTANT! Due to a change in a recent Virtualbox update, you need to do a manual edit to make this happen. See https://github.com/Oddly/rhce8-env/issues/1#issue-1046757903 .

## macOS

#### Installation

_Gatekeeper can block virtualbox from installing. All you have to do is go into Security & Privacy of System Preferences and click Allow under the General tab and rerun the installation._

1. Cd to the target directory: `cd /opt`.  (The location doesn't have to be `/opt`, it can be anything you want.)
2. Clone the environment repo: `git clone https://github.com/Oddly/rhce8-env.git`
3. Change to the `rhce8-env` directory that is now in your `/opt` directory: `cd rhce8-env`
4. Run the following code:
`/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && xcode-select --install &&brew install ansible ; brew install python ; brew install vagrant ; brew install VirtualBox ; brew install virtualbox-extension-pack ; vagrant plugin install vagrant-guest_ansible ;`

#### Usage

1. Run `ansible-playbook -i localhost, vagrant.yml -K` to deploy the environment, you will need to provide your password. Downloads approximately 7 GiB the first time and this will take a while (without seeing progress). The installer will eventually ask you which version you want to install.
Version differences are:

	- **Version 1**: Everything is set up, user `automation` has passwordless sudo and SSH access on control and the nodes.
	- **Version 2**:  User `automation` does not have passwordless SSH and sudo access on the nodes. The password is `devops`.

If you want to use version 1 and you want see the output of Vagrant, you can substitute the ansible-playbook command with `vagrant up`.

2. Run `vagrant destroy -f node1 node2 node3 node4 node5` to destroy all nodes and run `vagrant up` to bring them back up, clean installed.
3. `vagrant destroy -f` removes all (including control and repo) machines (without confirmation!)

##### Alternatively, you can install everything individually below.
- [Install the Latest Version of Vagrant](https://www.vagrantup.com/downloads.html) - (`brew cask install vagrant`)
    - Vagrant Plugin - `vagrant plugin install vagrant-guest_ansible`
- [Install the Latest Version of Virtualbox](https://www.virtualbox.org/wiki/Downloads) (`brew cask install VirtualBox`)
    - Virtual Box Extension Pack (`brew cask install virtualbox-extension-pack`)


### CentOS7/RHEL7/Manjaro/Arch - Install all at once by Copy/Pasting the below command into your terminal as root.
_NOTE - If it's been awhile since you've run yum update, do that first. Reboot if the kernel was updated. There may be some dependencies errors but don't be alarmed as this won't stop the environment from working._
```
systemctl stop packagekit; yum install -y epel-release && yum install -y git binutils gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms libvirt libvirt-devel ruby-devel libxslt-devel libxml2-devel libguestfs-tools-c ; mkdir ~/Vagrant ; cd ~/Vagrant ; curl -o  vagrant_2.2.6_x86_64.rpm https://releases.hashicorp.com/vagrant/2.2.6/vagrant_2.2.6_x86_64.rpm && yum install -y vagrant_2.2.6_x86_64.rpm && vagrant plugin install vagrant-guest_ansible ; vagrant plugin install vagrant-guest-ansible ; wget -O /etc/yum.repos.d/virtualbox.repo wget http://download.virtualbox.org/virtualbox/rpm/rhel/virtualbox.repo ; yum install -y VirtualBox-6.0 && systemctl start packagekit
```
##### Also, install the Virtualbox extension pack below
- [Install the Virtual Box Extension Pack](https://www.virtualbox.org/wiki/Downloads)

### Usage on CentOS7/RHEL7/Manjaro/Arch
1. Run `vagrant up` to deploy the environment. Downloads approximately 7 GiB the first time. You can specify which version you want to install in the file `playbooks/vagrant_ansible.yml`.
Version differences are:
        - **Version 1**: Everything is set up, user `automation` has passwordless sudo and SSH access on control and the nodes.
        - **Version 2**:  User `automation` does not have passwordless SSH and sudo access on the nodes.
2. Run `vagrant destroy -f node1 node2 node3 node4 node5` to destroy all nodes and run `vagrant up` to bring them back up, clean installed.
3. `vagrant destroy -f` removes all machines (without confirmation!)

### Windows/RHEL 8/Fedora 30
- [Install the Latest Version of Vagrant](https://www.vagrantup.com/downloads.html)
- [Install the Latest Version of Virtualbox and Virtual Box Extension Pack](https://www.virtualbox.org/wiki/Downloads)
- If on Windows, install the following vagrant plugin via PowerShell as Administrator `vagrant plugin install vagrant-guest_ansible` 
- If on Linux, install the remaining dependencies:
```
vagrant plugin install vagrant-guest_ansible ; sudo dnf install -y git binutils gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms libvirt libvirt-devel ruby-devel libxslt-devel libxml2-devel 
```

##### Once the above software is installed. Do the following if you're running the environment on Windows:
1. Create a separate `~/bin` directory and `cd` to it using the same PowerShell/Terminal as Administrator/Root.  (The directory doesn't have to be ~/bin, it can be anything you want.)
2. Use your browser of choice and navigate to https://github.com/rdbreak/rhce8env, press the green “Clone or download” button then the “Download ZIP” button. Or use Github Desktop (See below).
3. Once downloaded, unzip the file and move it to the directory you created earlier, `~/bin` in the above example.
4. Use PowerShell/Terminal as Administrator/Root again and cd to the `~/bin/rhce8env` directory then run `vagrant up` to deploy the environment. (If the environment has a designated repo VM it will take the longest to deploy the first time only, this is because the repo system has all the packages available to the base release but will be quicker on subsequent deployments.)


### Debian
_NOTE - If it's been awhile since you've run apt update, do that first. Reboot if the kernel was updated._

##### Install all at once by Copy/Pasting the below command into your terminal as root.
```
sudo snap install ruby ; sudo apt install ruby-bundler git -y; wget -c https://releases.hashicorp.com/vagrant/2.2.5/vagrant_2.2.6_x86_64.deb ; sudo dpkg -i vagrant_2.2.6_x86_64.deb ; wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add - ; wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add - ; sudo add-apt-repository "deb http://download.virtualbox.org/virtualbox/debian bionic contrib"; sudo apt update; sudo apt install -y virtualbox-6.0 ; vagrant plugin install vagrant-guest_ansible
```
##### Also, install the Virtualbox extension pack below
- [Virtual Box Extension Pack](https://www.virtualbox.org/wiki/Downloads)

#### Next step:
1. Create a separate `~/bin` directory and `cd` to it.  (The directory doesn't have to be ~/bin, it can be anything you want.)
2. Clone the environment repo to it with `git clone https://github.com/rdbreak/rhce8env.git`
3. Change to the `rhce8env` directory that is now in your `~/bin` directory.
4. Run `vagrant up` to deploy the environment (If the environment has a designated repo VM it will take the longest to deploy the first time only, this is because the repo system has all the packages available to the base release but will be quicker on subsequent deployments.)

_Now the deployment should be up and running!_

### Other Useful Information:
You can also use the VirtualBox console to interact with the VMs or through a terminal. If you need to reset the root password, you would need to use the console. I'm constantly making upgrades to the environments, so every once and awhile run `git pull` in the repo directory to pull down changes. The first time you run the vagrant up command, it will download the OS images for later use. In other words, it will take longest the first time around but will be faster when it is deployed again. You can run `vagrant destroy -f` to destroy your environment at anytime. **This will erase everything**. This environment is meant to be reuseable, If you run the `vagrant up` command after destroying the environment, the OS image will already be downloaded and environment will deploy faster. Deployment should take around 15 minutes depending on your computer. Everything should be provided that you would normally need during an actual exam. Hope this helps in your studies!

