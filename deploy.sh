#!/bin/bash

aws ecr get-login-password --region eu-central-1 | \
docker login --username AWS --password-stdin $ECR_URL

docker pull $ECR_URL/flask-app:latest

docker stop app || true
docker rm app || true

docker run -d -p 5000:5000 --name app $ECR_URL/flask-app:latest