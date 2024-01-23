#!/bin/bash
if pgrep -f kube-apiserver >/dev/null && pgrep -f kube-controller-manager >/dev/null && pgrep -f kube-scheduler >/dev/null; then
    echo "This server is a Kubernetes master."
    export K8S_MASTER="true"
else
    echo "This server is not a Kubernetes master."
    export K8S_MASTER="false"
fi