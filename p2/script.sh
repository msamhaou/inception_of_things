#!/bin/bash

apt update
apt install -y curl
curl -fL https://get.k3s.io | sh - 
sudo kubectl apply -f kubectl_manif
