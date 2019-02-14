docker build -t superdba111/multi-client:latest -t superdba111/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t superdba111/multi-server:latest -t superdba111/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t superdba111/multi-worker:latest -t superdba111/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push superdba111/multi-client:latest
docker push superdba111/multi-server:latest
docker push superdba111/multi-worker:latest

docker push superdba111/multi-client:$SHA
docker push superdba111/multi-server:$SHA
docker push superdba111/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=superdba111/multi-server:$SHA
kubectl set image deployments/client-deployment client=superdba111/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=superdba111/multi-worker:$SHA
