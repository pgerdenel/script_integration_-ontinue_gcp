#!/bin/bash

## VAR
nom_repo="app/flask"
rim_name="$nom_repo:${TRAVIS_COMMIT::6}"
namespace=name_nmsp
nom_deployment="my-dep-travis"
nom_svc="my-cs-travis"
public_tcp_port=8080
private_tcp_port=8000

## Build 
echo "image build name : $rim_name"

## Build image & push to docker hub
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker build -t $rim_name .
docker push $rim_name

## Création d'un "Deployment" avec l'image docker nouvellement créée dans votre cluster kubernetes (dans votre namespace bien-sur)

# Authentification gcloud
gcloud auth activate-service-account --key-file=key.json

# On assigne le projet 'project-012345' comme current projet
gcloud config set project project-012345

# on récupère les credentials de connexion au cluster Kubernetes
gcloud container clusters get-credentials --zone=europe-west4-c my-first-cluster-1

# on set notre namespace personel
kubectl config set-context --current --namespace=name_nmsp

# on créer le déploiement avec l'image docker (1fois, renvoie already create si existant)
kubectl create deployment "$nom_deployment" --image=$rim_name --replicas=3
# on crée le service (1fois, renvoie already create si existant)
kubectl create service clusterip $nom_svc --tcp=8080:8000

# on récupère le deployment en yaml
kubectl get deployment "$nom_deployment" -o yaml >> dpl.yaml
# on remplace le nom de l'image par le nom de la nouvelle image (le numéro de ligne change en fonction de la longueur de la dernière config appliquée)
sed -i -E "s/app\/flask:[a-z0-9]+/app\/flask:${TRAVIS_COMMIT::6}/" dpl.yaml

# Update deployment config
kubectl apply -f dpl.yaml