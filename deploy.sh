#!/bin/sh
set -e

ENV=$1
TITLE=$(echo $ENV | tr a-z A-Z)

aws eks update-kubeconfig --name $ENV-cluster --region eu-west-1
kubectl config set-context --current --namespace=default

sed "s/__ENV__/$TITLE/g" site/index.html > index.html

kubectl create configmap website --from-file=index.html --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -f k8s/
kubectl rollout restart deployment/website
kubectl rollout status deployment/website

kubectl get service website
