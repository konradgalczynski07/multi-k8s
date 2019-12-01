docker build -t konradgalczynski07/client:latest -t konradgalczynski07/client:$SHA -f ./client/Dockerfile ./client
docker build -t konradgalczynski07/server:latest -t konradgalczynski07/server:$SHA -f ./server/Dockerfile ./server
docker build -t konradgalczynski07/worker:latest -t konradgalczynski07/worker:$SHA -f ./worker/Dockerfile ./worker

docker push konradgalczynski07/client:latest
docker push konradgalczynski07/server:latest
docker push konradgalczynski07/worker:latest

docker push konradgalczynski07/client:$SHA
docker push konradgalczynski07/server:$SHA
docker push konradgalczynski07/worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=konradgalczynski07/server:$SHA
kubectl set image deployments/client-deployment client=konradgalczynski07/client:$SHA
kubectl set image deployments/worker-deployment worker=konradgalczynski07/worker:$SHA