# at42IoT

This project introduces to kubernetes (k3s and k3d), Vagrant and ArgoCD. \
You will have to set up small clusters and discover the mechanics of DevOps through three parts.

## Part one:

Using **Vagrant** to run Virtual Machines, we have to connect two machines. \
One running k3s as the controller and a second one being its k3s agent.

## Part two:

Running one single machine, we want to run **three simple applications** with **k3s**. \
According to some **Ingress** rules about the request's host, we can use different apps.

## Part three:

This time we're using **k3d** to manage our kubernetes clusters. \
We want to setup **Argo CD**, a continuous delivery tool for Kubernetes, that will automatically deploys an app.

The best video about ArgoCD: https://www.youtube.com/watch?v=MeU5_k9ssrs
