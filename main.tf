provider "aws" {
  region = "eu-central-1"
}

# -------------------------
# IAM ROLE (usa count pra evitar duplicação)
# -------------------------
data "aws_iam_role" "existing_role" {
  name = "ec2-ssm-role"
}

# Se a role NÃO existir, cria ela
resource "aws_iam_role" "ec2_role" {
  count = length(data.aws_iam_role.existing_role.id) == 0 ? 1 : 0

  name = "ec2-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

# SSM Policy
resource "aws_iam_role_policy_attachment" "ssm" {
  role = "ec2-ssm-role"

  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# ECR read access
resource "aws_iam_role_policy_attachment" "ecr" {
  role = "ec2-ssm-role"

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-instance-profile"
  role = "ec2-ssm-role"
}

# -------------------------
# SECURITY GROUP
# -------------------------
resource "aws_security_group" "app_sg" {
  name = "app-sg"

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
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
# EC2 INSTANCE
# -------------------------
resource "aws_instance" "app" {
  ami           = "ami-0f7804991cb8f07c4"
  instance_type = "t3.micro"

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y docker.io awscli
              systemctl start docker
              systemctl enable docker
              usermod -aG docker ubuntu
              EOF

  tags = {
    Name = "ci-cd-multistage"
  }
}