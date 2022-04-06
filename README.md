# HOMELAB FOLLOW
[Build a lab in 36 seconds with Ansible](https://www.redhat.com/sysadmin/build-VM-fast-ansible)
[libvirt](https://wiki.archlinux.org/title/libvirt)
[ansible libvirt](https://docs.ansible.com/ansible/latest/collections/community/libvirt/virt_module.html)
[vagrant](https://wiki.archlinux.org/title/Vagrant)
[HashiCorp](https://learn.hashicorp.com/tutorials/vagrant/getting-started-project-setup?in=vagrant/getting-started)

--- 

# Build a lab in 36 seconds with Ansible

Create a project directory for this automation and switch to it:
```shell
mkdir -p kvmlab/roles && cd kvmlab/roles
```
Then, initialize the role using the command ansible-galaxy:
```shell
$ ansible-galaxy role init kvm_provision

- Role kvm_provision was created successfully
```
```shell
$ cd kvm_provision
$ ls
defaults files handlers meta README.md tasks templates tests vars
rm -r files handlers vars
virsh -c qemu:///system dumpxml archlinux_default > archlinux_default.xml
```


 
---
# ANSIBLE

```shell
pacman -S ansible-core ansible vim-ansible
mkdir ansible
ansible-config init --disabled -t all > ansible.cfg
ansible all -m ping
ansible-galaxy collection list|grep -i libvirt

```
>NOTE: PYTHON3 and PYTHON2 needed on ansible clients.

---
# VAGRANT
```shell
pacman -S vagrant
systemctl start libvirtd

vagrant plugin install vagrant-vbguest vagrant-share
vagrant plugin install vagrant-libvirt

mkdir -p $HOME/vagrant/archlinux
cd $HOME/vagrant/archlinux
vagrant init archlinux/archlinux
vagrant box add archlinux/archlinux --provider=libvirt
vagrant up --provider=libvirt
vagrant ssh
```shell
---
