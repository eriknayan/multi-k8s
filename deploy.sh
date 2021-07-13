#!/bin/bash
docker build -t eriknayan/multi-client:latest -t eriknayan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t eriknayan/multi-server:latest -t eriknayan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t eriknayan/multi-worker:latest -t eriknayan/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push eriknayan/multi-client:latest 
docker push eriknayan/multi-client:$SHA
docker push eriknayan/multi-server:latest 
docker push eriknayan/multi-server:$SHA
docker push eriknayan/multi-worker:latest 
docker push eriknayan/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=eriknayan/multi-client:$SHA
kubectl set image deployments/server-deployment server=eriknayan/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=eriknayan/multi-worker:$SHA

