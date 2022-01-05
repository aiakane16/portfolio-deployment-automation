variable "ami-id" {
  type = string
}

variable "iam-instance-profile" {
  type    = string
  default = ""
}

variable "instance-type" {
  type    = string
  default = "t2.micro"
}

variable "key-pair" {
  type = string
}

variable "name" {
  type = string
}

variable "private-ip" {
  type    = string
  default = ""
}

variable "subnet-id" {
  type    = string
  default = ""
}

variable "vpc-security-group-ids" {
  type    = list(string)
  default = []
}
