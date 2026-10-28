# cambridge-aerospace-website

Sample website deployed by Jenkins to the three EKS clusters from [flighttest-platform](https://github.com/rohanyagnik10/flighttest-platform).

The page is plain nginx. The html goes into a ConfigMap with the environment name in the heading, so there is no image to build.

## How it deploys

On a push to main, GitHub calls the Jenkins webhook and the pipeline runs:

```
uat -> preprod -> prod
```

deploy.sh does the work for each environment:

1. gets the kubeconfig for `<env>-cluster`
2. replaces `__ENV__` in site/index.html with UAT, PREPROD or PROD
3. applies the configmap, deployment and service
4. restarts the deployment and waits for it

## Get the url

```
kubectl get service website
```
