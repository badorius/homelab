#!/bin/bash
HOSTS="rpi rpi2 rpi3"

export COMMAND='sudo systemctl stop k3s ; sudo /usr/local/bin/k3s-uninstall.sh ; sudo systemctl stop k3s-agent ; sudo /usr/local/bin/k3s-agent-uninstall.sh ; sudo rm -rf /usr/local/bin/arkade /usr/local/bin/k3sup /home/darthv/.kube ; sudo apt -y remove kubernetes-client ; sudo reboot'

for HOST in $HOSTS ; do
	ssh $HOST "$COMMAND"
done
