resource "aws_key_pair" "app-server-key" {
  key_name   = "app-server-key"
  public_key = file("./app-server.pem")
}
