#!/usr/bin/env bash

set -eo pipefail

echo "Init the k3d cluster..."
k3d cluster create iot -p "8888:80@loadbalancer"

kubectl wait deployment/metrics-server -n kube-system --for=condition=Available --timeout=300s 2>/dev/null

echo "Install Argo CD"
kubectl create namespace argocd
kubectl apply -n argocd -f ../confs/install-argocd.yaml
kubectl wait --for=condition=Ready --timeout=300s -n argocd --all pod
kubectl apply -n argocd -f ../confs/argo-application.yaml

echo "Setup dev namespace application"
kubectl create namespace dev
kubectl apply -n dev -f ../confs/ingress.yaml

# Access ArgoCD UI
kubectl wait deployment/argocd-server -n argocd --for=condition=Available
kubectl port-forward svc/argocd-server -n argocd 8090:443 --address=0.0.0.0 &

ARGOCD_PASS=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo)
echo "The service can be accessed using https://localhost:8080"
echo "The credentials for ArgoCD are:"
echo "- login: admin"
echo "- passwd: ${ARGOCD_PASS}"
echo

echo "kubectl get ns"
echo "kubectl get all -n argocd"
echo "kubectl get all -n dev"
echo "curl localhost:8888; echo"
