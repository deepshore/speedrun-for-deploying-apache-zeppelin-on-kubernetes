# speedrun-for-deploying-apache-zeppelin-on-kubernetes

## Provide infrastructure

For this speedrun, the minikube cluster was created as follows:

```bash
minikube start -p zeppelin --driver=virtualbox --memory=8g --cpus=4 --disk-size=30000mb 
```

This configuration is also due to the fact that the Docker images are built directly on the node.
To point your shell to minikube's docker-daemon, run the following command:

```bash
eval $(minikube -p zeppelin docker-env)
```

## Get this code

Clone this repo:

```bash
git clone https://github.com/deepshore/speedrun-for-deploying-apache-zeppelin-on-kubernetes
```

and join it:

```bash
cd speedrun-for-deploying-apache-zeppelin-on-kubernetes
```

## Build the Distribution Image

For the creation of the Zeppelin images a so-called distribution image is needed, 
which is built on the basis of the source code.

```bash
git clone git clone https://github.com/apache/zeppelin.git
cd zeppelin
docker build -t zeppelin-distribution:latest .
```

## Build the Server Image

After building the Distribution Image, the image for the Zeppelin server can be built like this:

```bash
cd ../docker/zeppelin-server
docker build -t zeppelin-server-custom:0.11.0-SNAPSHOT --build-arg version=0.11.0-SNAPSHOT .
```

## Build the Interpreter Image

The interpreter image is created in the same way:

```bash
cd ../zeppelin-interpreter
docker build -t zeppelin-interpreter-custom:0.11.0-SNAPSHOT --build-arg version=0.11.0-SNAPSHOT .
```

By editing `conda_packages.txt` and `pip_packages.txt` before the build, 
Python packages can optionally be added or removed.

## Deploy Postgres

A script is included for deploying Postgres:

```bash
cd ../../kubernetes
./deploy-postgres.sh
```

## Deploy Zeppelin

Make sure that the images have been referenced in the Kubernetes resources 
of the `zeppelin-server.yaml` file and deploy it:

```bash
kubectl apply -f zeppelin-server.yaml
```

## Using Zeppelin

Set up port forwarding like this:

```bash
kubectl port-forward svc/zeppelin-server 8080:80
```

Configure the interpreters and start to enjoy creating notes!
