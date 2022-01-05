output "app-server-private-ip" {
    value = module.portfolio-server.private-ip
  
}

output "app-server-public-ip" {
    value = aws_eip.app-server-eip.public_ip
  
}