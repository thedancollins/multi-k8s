docker build -t currentanalyticsio/multi-client:latest -t currentanalyticsio/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t currentanalyticsio/multi-server:latest -t currentanalyticsio/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t currentanalyticsio/multi-worker:latest -t currentanalyticsio/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push currentanalyticsio/multi-client:latest
docker push currentanalyticsio/multi-server:latest
docker push currentanalyticsio/multi-worker:latest

docker push currentanalyticsio/multi-client:$SHA
docker push currentanalyticsio/multi-server:$SHA
docker push currentanalyticsio/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=currentanalyticsio/multi-server:$SHA
kubectl set image deployments/client-deployment client=currentanalyticsio/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=currentanalyticsio/multi-worker:$SHA