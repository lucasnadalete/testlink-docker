# Making a Docker Image


## Build Image

Creating the docker image.

```bash
cd ./testlink # Access the root directory
docker-compose build
```

## Run

```bash
docker-compose up -d
```

## Stop
```bash
docker-compose down
```

## Kubernetes
```bash
# Connected in the local cluster (Minikube) or 
# cloud cluster (GCP or AWS)
kubectl create -f namespace.yml
kubectl create -f volumes.yml
kubectl create -f deployment.yml
kubectl create -f servico.yml
```
