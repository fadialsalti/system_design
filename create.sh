#/bin/bash

sudo lsof -i :80 | grep LISTEN | awk '{print $2}' | xargs kill -9

kind create cluster --config cluster-config.yml 

kubectl apply --filename https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/kind/deploy.yaml

echo "172.19.0.2      rabbitmq-manager.com" >> /etc/hosts
echo "127.0.0.1       mp3converter.com" >> /etc/hosts

cd python/src/auth/
kubectl create configmap mysql-init-script --from-file=init.sql
kubectl apply -f manifests/

cd ../rabbit/
kubectl apply -f manifests/

cd ../gateway/
kubectl apply -f manifests/

cd ../converter/
kubectl apply -f manifests/


# curl -X POST http://mp3converter.com/login -u georgio@email.com:Admin123 -i  -v
# curl -X POST -F 'file=@./videoplayback.mp4' -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6Imdlb3JnaW9AZW1haWwuY29tIiwiZXhwIjoxNzEwMzU0NjgwLCJpYXQiOjE3MTAyNjgyODAsImFkbWluIjp0cnVlfQ.WZIsOsyePF441jvKNSyXFVIOG-EjfdJD-n2oWHCDoYI' http://mp3coverter.com/upload