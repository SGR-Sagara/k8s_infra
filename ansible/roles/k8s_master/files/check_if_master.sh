#!/bin/bash
## Check whther kubernetes master cluster related services are running if not initialize the cluster
if pgrep -f kube-apiserver >/dev/null && pgrep -f kube-controller-manager >/dev/null && pgrep -f kube-scheduler >/dev/null; then
    echo "This server is a Kubernetes master."
else
    echo "This server is not a Kubernetes master."
    kubeadm init --pod-network-cidr=$1 --apiserver-advertise-address=$2
fi