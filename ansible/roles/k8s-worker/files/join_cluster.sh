## Add worker nodes to kubernetes master 
#!/bin/bash

kubeadm join $1:$2 --token $3 --discovery-token-ca-cert-hash $4
