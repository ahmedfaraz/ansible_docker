output "instance_public_ip" {
  description = "Public IP of EC2 instance"
  value       = aws_instance.app_server.public_ip
}

output "key_pair_name" {
  description = "Name of the key pair"
  value       = aws_key_pair.rdp_connect.key_name
}