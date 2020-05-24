docker build -t ashwinikumarmishra/multi-client:latest -t ashwinikumarmishra/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ashwinikumarmishra/multi-server:latest -t ashwinikumarmishra/multi-server:$SHA -f ./client/Dockerfile ./server
docker build -t ashwinikumarmishra/multi-worker:latest -t ashwinikumarmishra/multi-worker:$SHA -f ./client/Dockerfile ./worker

docker push ashwinikumarmishra/multi-client:latest
docker push ashwinikumarmishra/multi-server:latest
docker push ashwinikumarmishra/multi-worker:latest

docker push ashwinikumarmishra/multi-client:$SHA
docker push ashwinikumarmishra/multi-server:$SHA
docker push ashwinikumarmishra/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=ashwinikumarmishra/multi-server:$SHA
kubectl set image deployments/client-deployment client=ashwinikumarmishra/multi-client:$SHA
kubectl set image deployments/worker-deployment server=ashwinikumarmishra/multi-worker:$SHA