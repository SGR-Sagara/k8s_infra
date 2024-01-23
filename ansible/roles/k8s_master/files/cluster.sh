## Initialize Kubernetes Cluster
#!/bin/bash
# Onlt initialze the Kubernetest cluster of the server is not already a MAster
if not $K8S_MASTER; then
    kubeadm init --pod-network-cidr=$1 --apiserver-advertise-address=$2
fi
#kubeadm init --pod-network-cidr=10.0.0.0/24 --apiserver-advertise-address=10.0.2.71