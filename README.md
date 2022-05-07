# MINIKUBE
---
[https://kubernetes.io/docs/tasks/tools/](https://kubernetes.io/docs/tasks/tools/)

[https://minikube.sigs.k8s.io/docs/](https://minikube.sigs.k8s.io/docs/)

[https://minikube.sigs.k8s.io/docs/tutorials/multi_node/](https://minikube.sigs.k8s.io/docs/tutorials/multi_node/)

[https://howtoforge.es/aprender-kubernetes-localmente-a-traves-de-minikube-en-manjaro-archlinux/](https://howtoforge.es/aprender-kubernetes-localmente-a-traves-de-minikube-en-manjaro-archlinux/)

[https://www.digihunch.com/2021/09/single-node-kubernetes-cluster-minikube/](https://www.digihunch.com/2021/09/single-node-kubernetes-cluster-minikube/)

# Install Packages
---
```shell
sudo pacman -Sy libvirt qemu ebtables dnsmasq
```
# Add user to libvirt group
---
```shell
sudo usermod -a -G libvirt $(whoami)
newgrp libvirt
```

# Start and enable libvirtd virtlogd services
---
```shell
sudo systemctl start libvirtd.service
sudo systemctl enable libvirtd.service
 
sudo systemctl start virtlogd.service
sudo systemctl enable virtlogd.service
```
# Instal docker-machine and docker-machine-driver-kvm2 in order to manage VM Kubernetes:
---
```shell
sudo pacman -Sy docker-machine
yay -Sy docker-machine-driver-kvm2
```

# Install minikube kubectl packages:
---
```shell
yay -Sy minikube kubectl
```

# Check minikube and kubectl:
---
```shell
minikube version
whereis kubectl
kubectl -h
```

# Start kubernetes with minikube (1 Control Plane and 2 workers as example)
---
```shell
minikube start --nodes 3 --vm-driver kvm2
```
# Check kubernetes cluster:
---
```shell
minikube status
kubectl cluster-info
kubectl get nodes
minikube status -p  minikube  
```
# First deployment (Nginx):
---
```shell
mkdir -p minikube/projects/hello/
cd minikube/projects/hello/
```

# Create yaml deployment file:
---
```shell
vim hello-deployment.yaml
```
# Add the following content:
---
```yaml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hello
spec:
  replicas: 2
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 100%
  selector:
    matchLabels:
      app: hello
  template:
    metadata:
      labels:
        app: hello
    spec:
      affinity:
        # ⬇⬇⬇ This ensures pods will land on separate hosts
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchExpressions: [{ key: app, operator: In, values: [hello] }]
            topologyKey: "kubernetes.io/hostname"
      containers:
      - name: hello-from
        image: pbitty/hello-from:latest
        ports:
          - name: http
            containerPort: 80
      terminationGracePeriodSeconds: 1
```
# Create hello service in order to access hello pod:
---
```shell
vi hello-svc.yaml
```
# Add the following content to yaml file:
---
```yaml
---
apiVersion: v1
kind: Service
metadata:
  name: hello
spec:
  type: NodePort
  selector:
    app: hello
  ports:
    - protocol: TCP
      nodePort: 31000
      port: 80
      targetPort: http
```
# Deploy hello pod and service:
---
```shell
kubectl apply -f hello-deployment.yaml
kubectl rollout status deployment/hello
```

# Check out the IP addresses of our pods, to note for future reference
---
```shell
kubectl get pods -o wide
```

# Look at our service, to know what URL to hit
---
```shell
minikube service list -p multinode-demo
```

# Let’s hit the URL a few times and see what comes back
---
```shell
curl  http://192.168.49.2:31000
```

# Run minikube dashboard:
---
```shell
minikube addons list
```






# KIND
---
[https://kubernetes.io/docs/tasks/tools/](https://kubernetes.io/docs/tasks/tools/)
[https://kind.sigs.k8s.io/docs/user/quick-start/](https://kind.sigs.k8s.io/docs/user/quick-start/)


