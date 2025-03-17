###
# What Does This File Do?

## VPC and Networking
- Creates a VPC with two public subnets in different Availability Zones.
- Adds an Internet Gateway and a Route Table to provide internet access for the subnets.

## Security Group
- Defines rules for HTTP traffic (port 80), SSH (port 22), and any outbound traffic.

## EC2 and Autoscaling
- Creates a Launch Template with a simple user-data script that installs an HTTP server (Apache) and serves a basic webpage.
- Configures an Autoscaling Group to maintain a specified number of instances across two subnets.

## Application Load Balancer (ALB)
- Creates an ALB in public subnets.
- Adds a Target Group and a Listener that routes traffic on port 80 to instances in the ASG.
- Configures health checks for the Target Group.

## Outputs
- Returns the ALB DNS name for easy application access via a web browser.
- Returns the VPC ID.

## How to Use?

1. Ensure you have AWS credentials configured (e.g., `~/.aws/credentials` or environment variables).
2. Insert your public SSH key in `aws_key_pair`.
3. Verify the AMI ID (`image_id`) for your region—the provided AMI (`ami-0c55b159cbfafe1f0`) may be outdated.
4. Save the code in a file, e.g., `main.tf`.

Run the following commands:

```sh
terraform init
terraform apply

###
# Wersja Terraform i provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Konfiguracja providera AWS
provider "aws" {
  region = "eu-west-1" # Możesz zmienić region
}

# Zmienne
variable "instance_type" {
  description = "Typ instancji EC2"
  default     = "t2.micro"
}

variable "desired_capacity" {
  description = "Żądana liczba instancji w autoscaling group"
  default     = 2
}

# VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main-vpc"
  }
}

# Subnety publiczne
resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-1b"

  tags = {
    Name = "public-subnet-2"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

# Route Table dla publicznych subnetów
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Powiązanie route table z subnetami
resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}

# Security Group dla EC2 i ALB
resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.main.id

  # HTTP od świata
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH dla admina (możesz ograniczyć CIDR do swojego IP)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Wyjście na świat
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}

# Klucz SSH do EC2
resource "aws_key_pair" "deployer_key" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC..." # Wstaw swój klucz publiczny
}

# Launch Template dla Autoscaling Group
resource "aws_launch_template" "web_template" {
  name_prefix   = "web-template-"
  image_id      = "ami-0c55b159cbfafe1f0" # AMI dla Amazon Linux 2 w eu-west-1 (sprawdź aktualne AMI w Twoim regionie)
  instance_type = var.instance_type
  key_name      = aws_key_pair.deployer_key.key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.web_sg.id]
  }

  user_data = base64encode(<<EOF
#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>Hello from $(hostname -f)</h1>" > /var/www/html/index.html
EOF
  )

  lifecycle {
    create_before_destroy = true
  }
}

# Autoscaling Group
resource "aws_autoscaling_group" "web_asg" {
  desired_capacity    = var.desired_capacity
  max_size            = 4
  min_size            = 1
  vpc_zone_identifier = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

  launch_template {
    id      = aws_launch_template.web_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "web-instance"
    propagate_at_launch = true
  }
}

# Application Load Balancer
resource "aws_lb" "web_alb" {
  name               = "web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_sg.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

  tags = {
    Name = "web-alb"
  }
}

# Target Group dla ALB
resource "aws_lb_target_group" "web_tg" {
  name     = "web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

# Listener dla ALB
resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

# Powiązanie ASG z Target Group
resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.web_asg.name
  lb_target_group_arn    = aws_lb_target_group.web_tg.arn
}

# Outputy
output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.web_alb.dns_name
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}
