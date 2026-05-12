export _USER=vagrant
sudo apt-get update && sudo apt-get install -y curl
#docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $_USER
#kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/bin
echo "alias k=kubectl" >> ~/.bashrc

#k3d
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
sudo k3d cluster create mycluster -p "443:443@loadbalancer" -p "80:80@loadbalancer" --k3s-arg "--disable=traefik@server:*"

#kubeconf
mkdir /home/$_USER/.kube
sudo k3d kubeconfig get mycluster > /home/$_USER/.kube/config.yaml
sudo chown -R $_USER:$_USER /home/$_USER/.kube
export KUBECONFIG=/home/$_USER/.kube/config.yaml

kubectl create ns argocd
kubectl create ns dev
kubectl apply -n argocd --server-side --force-conflicts -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "export KUBECONFIG=/home/$_USER/.kube/config.yaml" >> /home/$_USER/.bashrc

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
kubectl apply -f manifest
