# Déploiement d'une application python sur le cloud GCP dans un cluster Kubernetes 

- Build image & push to docker hub

- Création d'un "Deployment" avec l'image docker nouvellement créée dans votre cluster kubernetes (dans votre namespace bien-sur)

- Authentification gcloud
- on récupère les credentials de connexion au cluster Kubernetes
- on créer le déploiement avec l'image docker (1fois, renvoie already create si existant)
- on crée le service (1fois, renvoie already create si existant)
- on récupère le deployment en yaml
- on remplace le nom de l'image par le nom de la nouvelle image (le numéro de ligne change en fonction de la longueur de la dernière config appliquée)
- Update deployment config
