#!/bin/bash
## K8S cluster nodes
sudo apt-get update
sudo apt install net-tools -y
# check MAC
ip link show
# check product_uuid 
sudo cat /sys/class/dmi/id/product_uuid

### K8S Install
##Update the apt package index and install packages needed to use the Kubernetes apt repository:
#sudo apt-get update
#sudo apt-get install -y apt-transport-https ca-certificates curl
##Download the Google Cloud public signing key:
#curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg
##Add the Kubernetes apt repository:
#echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
##Update apt package index, install kubelet, kubeadm and kubectl, and pin their version:
#sudo apt-get update
#sudo apt-get install -y kubelet kubeadm kubectl
#sudo apt-mark hold kubelet kubeadm kubectl
echo "1. SWAP OFF"
## Swap Off
swapoff -a
sed -i '/swap/d' /etc/fstab

###########################################
# Forwarding IPv4 and letting iptables see bridged traffic
###########################################
echo "2. Forwarding IPv4"
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

# sysctl params required by setup, params persist across reboots
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system

sysctl net.bridge.bridge-nf-call-iptables net.bridge.bridge-nf-call-ip6tables net.ipv4.ip_forward

###########################################
# Insytall containerd
###########################################
echo "3. Set up repository"
#Set up the repository
#Update the apt package index and install packages to allow apt to use a repository over HTTPS:
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
#Add Docker’s official GPG key:
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
#Use the following command to set up the repository:
echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# Install containerd
echo "4. Install ContainerD"
sudo apt-get install -y containerd.io



#### Container runtime configuration setup
#sudo vi /etc/containerd/config.toml
echo "5. Create /etc/containerd/config.toml"
sudo mkdir -p /etc/containerd
sudo touch /etc/containerd/config.toml
echo "6. Set containerd toml config"
cat << EOF > sudo /etc/containerd/config.toml
[plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc]
  [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options]
    SystemdCgroup = true
EOF

echo "7. Check /etc/containerd/config.toml"
sudo cat /etc/containerd/config.toml
#Add:
#[plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc]
#  [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options]
#    SystemdCgroup = true
echo "8. Restart containerd"
# Restart containerd
sudo systemctl restart containerd

echo "9. Install kubeadm"
## Install kubeadm
#Update the apt package index and install packages needed to use the Kubernetes apt repository:
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl

#Download the Google Cloud public signing key:
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg

#Add the Kubernetes apt repository:
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

#Update apt package index, install kubelet, kubeadm and kubectl, and pin their version:
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl


