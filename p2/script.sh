#!/bin/bash

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/bin/
curl -fL https://get.k3s.io | sh -s - --kubelet-arg="cgroup-driver=cgroupfs"
sudo chown -R vagrant:vagrant /etc/rancher/k3s
echo "alias k=kubectl" >> /home/vagrant/.bashrc
echo "export KUBECONFIG=/etc/rancher/k3s/k3s.yaml" >> /home/vagrant/.bashrc
source /home/vagrant/.bashrc