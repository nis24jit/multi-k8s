docker build -t dockerhound/multi-client:latest -t dockerhound/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dockerhound/multi-server:latest -t dockerhound/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t dockerhound/multi-worker:latest -t dockerhound/multi-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push dockerhound/multi-client:latest
docker push dockerhound/multi-server:latest
docker push dockerhound/multi-worker:latest

docker push dockerhound/multi-client:$SHA
docker push dockerhound/multi-server:$SHA
docker push dockerhound/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dockerhound/multi-server:$SHA
kubectl set image deployments/client-deployment client=dockerhound/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dockerhound/multi-worker:$SHA
