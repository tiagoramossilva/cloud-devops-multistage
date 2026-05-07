☁️ Cloud DevOps Multi-Stage Pipeline — AWS + Terraform + Docker + CI/CD

End-to-end multi-stage DevOps pipeline simulating a production cloud deployment workflow using AWS, Terraform, Docker, and CI/CD principles.

🚀 Pipeline Overview

This project implements a multi-stage deployment pipeline:

Stage 1 — Infrastructure Provisioning

Terraform provisions AWS infrastructure (EC2, IAM, Security Groups)

Stage 2 — Application Build

Flask app is containerized using Docker

Stage 3 — Image Registry

Docker image is pushed to Amazon ECR

Stage 4 — Deployment

EC2 instance pulls and runs the containerized application

🧱 Architecture
AWS EC2 (Compute Layer)
Terraform (Infrastructure as Code)
Docker (Containerization)
Amazon ECR (Container Registry)
IAM Roles & Policies
AWS Systems Manager (optional access layer)
🔄 CI/CD Concept (Manual Pipeline Simulation)

Although not fully automated yet, this project simulates a CI/CD pipeline:

Build → Docker
Store → ECR
Deploy → EC2
🎯 Resultado

👉 Application running in the cloud
👉 Accessible via public EC2 IP on port 5000
👉 Fully containerized deployment
