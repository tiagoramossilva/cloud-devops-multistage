## 🚀 Cloud CI/CD Pipeline on AWS

This project is a fully automated CI/CD pipeline that builds, tests, scans, containerizes, and deploys a Flask application to AWS using Terraform, Docker, GitHub Actions, and EC2.

---

## 📌 Project Overview

A Flask application is deployed through a complete DevOps pipeline:

- Dockerized application
- Stored in Amazon ECR
- Deployed on AWS EC2
- Fully automated CI/CD using GitHub Actions
- Infrastructure managed with Terraform

Every push to `main` triggers the full pipeline automatically.

---

## 🧱 Architecture

GitHub Repository  
↓  
GitHub Actions (CI/CD Pipeline)  
↓  
Build + Security Scan (Trivy)  
↓  
Amazon ECR (Container Registry)  
↓  
AWS EC2 (Docker Runtime)

---

## ⚙️ Tech Stack

- Python (Flask)
- Docker
- Terraform
- AWS EC2
- Amazon ECR
- AWS IAM
- GitHub Actions
- Trivy (Security Scanner)

---

## 📋 Prerequisites

Before running locally or deploying, install:

- Docker
- Terraform
- AWS CLI
- Git
- AWS Account configured (`aws configure`)

---

## 🧪 1. Run Application Locally

Build Docker image
```bash
docker build -t flask-app .
```
Run container
```
docker run -p 5001:5000 flask-app
```
Access application
```
http://localhost:5001
```

Expected output:
CI/CD Multi-Stage Pipeline Running 🚀

## ☁️ 2. Provision AWS Infrastructure (Terraform)

Initialize Terraform
```
terraform init
```
Create infrastructure
```
terraform apply
```

This will provision:

- EC2 instance
- Security Group (port 5000 open)
- IAM Role (ECR access)
- User-data bootstrap (Docker + deployment)
- Get deployed URL

Example:
```
http://3.xx.xx.xx:5000
```

## 🔄 3. CI/CD Pipeline Execution

Trigger pipeline

Any push to main:
```
git add .
git commit -m "trigger pipeline"
git push origin main
```

Pipeline stages:
1. Build
Docker image is built
2. Security Scan
Trivy scans vulnerabilities
3. Push
Image is pushed to Amazon ECR
4. Deploy
EC2 pulls latest image
Container is restarted

## 🔐 5. AWS Components Used
EC2 → application runtime
ECR → Docker image registry
IAM → permissions
Security Groups → network access

## 🧠 6. Key Engineering Decisions
- EC2 chosen for simplicity and control
- ECR used for secure Docker storage
- Terraform used for reproducible infrastructure
- GitHub Actions for CI/CD automation
- Trivy integrated for security scanning
