#/bin/bash

lsof -i :80 | grep LISTEN | awk '{print $2}' | xargs kill -9

kind create cluster --config cluster-config.yml 

echo "172.19.0.2      rabbitmq-manager.com" >> /etc/hosts
echo "127.0.0.1       mp3converter.com" >> /etc/hosts

cd python/src/auth/
kubectl apply -f manifests/

cd ../rabbit/
kubectl apply -f manifests/

cd ../gateway/
kubectl apply -f manifests/

cd ../coverter/
kubectl apply -f manifests/