Summary:

This project creates 1 Master and a few worker nodes using Terraform and Ansible playbooks.

** This repo is Terraform and Ansible-based Kubernetes cluster implementation on AWS

1. This repo allows you to deploy EC2-based Kubernetes Master and Worker nodes.
2. You can use the ansible roles to install all the Kubernetes components.
3. We use the SSM run command to join multiple worker nodes to the cluster.


![K8S infrastructure summary](k8sinfra.png)
