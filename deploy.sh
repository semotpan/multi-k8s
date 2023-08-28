docker build -t motpansergiu/multi-client:latest -t motpansergiu/multi-client:$SHA ./client/Dockerfile ./client
docker build -t motpansergiu/multi-server:latest -t motpansergiu/multi-server:$SHA ./server/Dockerfile ./server
docker build -t motpansergiu/multi-worker:latest -t motpansergiu/multi-worker:$SHA ./worker/Dockerfile ./worker

docker push motpansergiu/multi-client:latest
docker push motpansergiu/multi-server:latest
docker push motpansergiu/multi-worker:latest

docker push motpansergiu/multi-client:$SHA
docker push motpansergiu/multi-server:$SHA
docker push motpansergiu/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=motpansergiu/multi-server:$SHA
kubectl set image deployments/client-deployment client=motpansergiu/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=motpansergiu/multi-worker:$SHA
