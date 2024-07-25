provider "aws" {
  region = "eu-central-1"
}

# Security Group erstellen, die SSH, HTTP und HTTPS über IPv4 (überall) erlaubt
resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Security group allowing SSH, HTTP, and HTTPS from everywhere"
}

# Security Group Regel für SSH (Port 22)
resource "aws_security_group_rule" "ingress_ssh" {
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web_sg.id
}

# Security Group Regel für HTTP (Port 80)
resource "aws_security_group_rule" "ingress_http" {
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web_sg.id
}

# Security Group Regel für HTTPS (Port 443)
resource "aws_security_group_rule" "ingress_https" {
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web_sg.id
}

# Security Group Regel für ausgehenden Datenverkehr (Outbound)
resource "aws_security_group_rule" "egress_all" {
  from_port         = 0
  to_port           = 0
  protocol          = "-1" # -1 bedeutet alle Protokolle
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web_sg.id
}

# EC2-Instanz erstellen
resource "aws_instance" "muffin" {
  ami           = "ami-071878317c449ae48" # Amazon Linux 2023 AMI
  instance_type = "t2.micro"

  # Instanz einen Name-Tag für AWS-Management-Konsole geben
  tags = {
    Name = "Muffin"
  }

  # Instanz mit Security-Group verknüpfen
  vpc_security_group_ids = [ aws_security_group.web_sg.id ]
}

# Instanz-IP ausgeben
output "muffin_ip" {
  value = aws_instance.muffin.public_ip
}

# Name der Security Group ausgeben
output "security_group_name" {
  value = aws_security_group.web_sg.name
}

# ARN der SSH-Security-Group-Rule ausgeben
output "ssh_rule_arn" {
  value = aws_security_group_rule.ingress_ssh.id
}

# ARN der HTTP-Security-Group-Rule ausgeben
output "http_rule_arn" {
  value = aws_security_group_rule.ingress_http.id
}

# ARN der HTTPS-Security-Group-Rule ausgeben
output "https_rule_arn" {
  value = aws_security_group_rule.ingress_https.id
}

