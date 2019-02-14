docker build -t sujono91/multi-client:latest -t sujono91/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sujono91/multi-server:latest -t sujono91/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sujono91/multi-worker:latest -t sujono91/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sujono91/multi-client:latest
docker push sujono91/multi-server:latest
docker push sujono91/multi-worker:latest

docker push sujono91/multi-client:$SHA
docker push sujono91/multi-server:$SHA
docker push sujono91/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sujono91/multi-server:$SHA
kubectl set image deployments/client-deployment client=sujono91/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sujono91/multi-worker:$SHA
