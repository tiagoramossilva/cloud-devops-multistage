## 🚀 Cloud CI/CD Pipeline on AWS

A fully working CI/CD pipeline that builds, tests, containerizes, and deploys a Flask application using AWS infrastructure and GitHub Actions automation.

---

## 📌 Project Overview

This project demonstrates a real-world DevOps workflow where a Flask application is:

- Containerized using Docker
- Stored in Amazon ECR
- Deployed on an AWS EC2 instance
- Automatically built and pushed via GitHub Actions CI/CD pipeline

Each push to the `main` branch triggers an automated deployment pipeline.

---

## 🧱 Architecture

GitHub Repository  
↓  
GitHub Actions (CI/CD Pipeline)  
↓  
Docker Build  
↓  
Amazon ECR (Container Registry)  
↓  
AWS EC2 (Application Runtime)

---

## ⚙️ Tech Stack

- Python (Flask)
- Docker
- AWS EC2
- Amazon ECR
- Terraform (Infrastructure as Code)
- GitHub Actions (CI/CD)
- AWS IAM

---

## 🔄 CI/CD Pipeline Flow

On every push to `main`:

1. GitHub Actions is triggered
2. Docker image is built
3. Image is pushed to Amazon ECR
4. EC2 instance pulls and runs latest version

---

## 📦 Run Locally

### Build image
```bash
docker build -t flask-app .
```
Run container
```
docker run -p 5001:5000 flask-app
```
Access app
```
http://localhost:5001
```
☁️ AWS Deployment
Terraform

Initialize infrastructure:
```
terraform init
```
Deploy AWS resources:
```
terraform apply
```

## 🔐 AWS Resources Used
- EC2 (Ubuntu server)
- ECR (Docker registry)
- IAM roles & permissions
- Security Groups

## 🧠 Problems Solved
- Docker permission issues on EC2
- ECR authentication setup
- Terraform deployment errors
- Git push conflicts
- CI/CD pipeline debugging
- Container networking issues

## 🎯 Key Learnings
- Cloud infrastructure with AWS
- Infrastructure as Code (Terraform)
- CI/CD automation with GitHub Actions
- Docker container lifecycle
- AWS IAM and permissions model
- Real-world DevOps debugging
