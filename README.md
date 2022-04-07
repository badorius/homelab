# HOMELAB FOLLOW
[Build a lab in 36 seconds with Ansible](https://www.redhat.com/sysadmin/build-VM-fast-ansible)

Libvirt has to be installed and enabled:
[libvirt](https://wiki.archlinux.org/title/libvirt)

Ansible and virt module has to be installed:
[ansible libvirt](https://docs.ansible.com/ansible/latest/collections/community/libvirt/virt_module.html)

Optional vagrant:
[vagrant](https://wiki.archlinux.org/title/Vagrant)

Optional vagrant information:
[HashiCorp](https://learn.hashicorp.com/tutorials/vagrant/getting-started-project-setup?in=vagrant/getting-started)

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
$ git clone git@github.com:badorius/homelab.git
$ cd homelab/kvm_provision
```
Edit and change pool_dir: 

>kvmlab/kvm_provision.yaml:    pool_dir: "/home/darthv/libvirt/images"

>kvmlab/roles/kvm_provision/defaults/main.yml:libvirt_pool_dir: "/home/darthv/libvirt/images"

>kvmlab/roles/kvm_provision/defaults/main.yml:vm_root_pass:$YOURPASS


Check exactly the name of the following packages and change it if is needed on file kvmlab/roles/kvm_provision/tasks/main.yml
```yml
- name: Ensure requirements in place
  package:
    name:
      - libguestfs
      - libvirt-python
      - guestfs-tools
    state: present
  become: yes
```
Execute playbook
```shell
$ ansible-playbook -K kvm_provision.yaml 
```

Or create 5 machines:
```shell
for i in 1 2 3 4 5 ; do ansible-playbook -K kvm_provision.yaml -e vm=f34-lab0$i ; done
for i in 1 2 3 4 5 ; do virsh domifaddr f34-lab0$i ; done

```
---
