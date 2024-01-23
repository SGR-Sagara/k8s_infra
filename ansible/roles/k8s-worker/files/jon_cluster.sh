## Add worker nodes to kubernetes master 
#!/bin/bash

kubeadm join {{master_host}}:{{api_port}} --token {{token_id}} --discovery-token-ca-cert-hash {{cert_hash}
