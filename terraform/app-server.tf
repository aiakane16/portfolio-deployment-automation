resource "aws_eip" "app-server-eip" {
    instance = module.portfolio-server.instance-id
  
}

module "portfolio-server" {
    source = "./app-server"

    ami-id = "ami-00f7e5c52c0f43726"
    key-pair = aws_key_pair.app-server-key.key_name
    name = "portfolio-server"
    subnet-id = aws_subnet.app-server-vpc-public.id

    vpc-security-group-ids = [
        aws_security_group.allow-http.id,
        aws_security_group.allow-ssh.id,
        aws_security_group.allow-all-outbound.id,
    ]
}