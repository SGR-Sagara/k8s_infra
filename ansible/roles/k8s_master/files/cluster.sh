## Initialize Kubernetes Cluster
#!/bin/bash

kubeadm init --pod-network-cidr=$1 --apiserver-advertise-address=$2
#kubeadm init --pod-network-cidr=10.0.0.0/24 --apiserver-advertise-address=10.0.2.71