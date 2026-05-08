provider "aws" {
  region = "eu-central-1"
}

# -------------------------
# SECURITY GROUP
# -------------------------
resource "aws_security_group" "app_sg" {
  name = "app-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# -------------------------
# IAM ROLE (ECR ACCESS)
# -------------------------
resource "aws_iam_role" "ec2_role" {
  name = "ec2-ecr-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecr_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.ec2_role.name
}

# -------------------------
# EC2 INSTANCE
# -------------------------
resource "aws_instance" "app" {
  ami           = "ami-0f7804991cb8f07c4"
  instance_type = "t3.micro"

  vpc_security_group_ids = [aws_security_group.app_sg.id]

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

user_data = <<-EOF
        #!/bin/bash
        exec > /var/log/user-data.log 2>&1
        set -x

        apt update -y
        apt install -y docker.io awscli

        systemctl start docker
        systemctl enable docker

        usermod -aG docker ubuntu

        aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin 481719141129.dkr.ecr.eu-central-1.amazonaws.com

        docker pull 481719141129.dkr.ecr.eu-central-1.amazonaws.com/flask-app:latest

        docker stop app || true
        docker rm app || true

        docker run -d -p 5000:5000 --name app 481719141129.dkr.ecr.eu-central-1.amazonaws.com/flask-app:latest
        EOF

  tags = {
    Name = "ci-cd-multistage"
  }
}

# -------------------------
# OUTPUTS
# -------------------------
output "instance_public_ip" {
  value = aws_instance.app.public_ip
}

output "application_url" {
  value = "http://${aws_instance.app.public_ip}:5000"
}