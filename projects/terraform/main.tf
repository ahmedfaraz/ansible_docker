provider "aws" {
  region = var.aws_region
}

resource "aws_key_pair" "rdp_connect" {
  key_name   = "RDP_Connect"
  public_key = var.public_key
}

resource "aws_instance" "app_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.rdp_connect.key_name
  security_groups = [aws_security_group.allow_ssh.name]

  tags = {
    Name = "DockerServer"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH and Docker inbound traffic"

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

# Generate inventory file from template
resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventory.tmpl", {
    public_ip = aws_instance.app_server.public_ip
  })
  filename = "../ansible/inventory/hosts.yml"
}