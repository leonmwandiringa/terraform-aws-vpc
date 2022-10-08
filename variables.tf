variable "aws_azs" {
  type = list(string)
  description = "list of aws azs supported"
}

variable "vpc_instance_tenancy" {
  type = string
  description = "desired vpc tenancy"
  default = "default"
}

variable "global_tags" {
  type = object({
    Name = string
    Author      = string
    Environment = string
    Provisioner = string
    Region      = string
  })
  description = "base tags required in every resource"
}

variable "vpc_enable_dns_support" {
  type = bool
  default = true
  description = "dns support for name resolution"
}

variable "vpc_enable_dns_hostnames" {
  type = bool
  default = true
  description = "dns names creation"
}

variable "vpc_enable_classiclink" {
  type = bool
  default = false
  description = "enable classic links"
}

variable "vpc_cidr_block"{
  type = bool
  description = "vpc cidr block range"
}

variable "default_sg_rules_ingress" {
  type= list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []  
}

variable "default_sg_rules_egress" {
  type= list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []  
}

variable "sg_description" {
  type = string
  description = "sg meta desription"
  default = "Allow HTTP, HTTPS and SSH traffic"
}

variable "public_subnet_cidrs" {
  type = list(string)
  description = "public subnet cidrs"
}

variable "private_subnet_cidrs" {
  type = list(string)
  description = "private subnet cidrs"
}

variable "nats_enabled" {
  default = false
  type = bool
  description = "nats enabled"
}

