echo '[yum]' > hosts
for srv in $(virsh -c qemu:///system list --all|grep f34|awk '{print $2}') ; do virsh -c qemu:///system domifaddr $srv |grep vnet|awk '{print $4}'|cut -f 1 -d "/"; done >> hosts
