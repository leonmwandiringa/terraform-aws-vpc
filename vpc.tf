resource "aws_vpc" "default" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = var.vpc_instance_tenancy
  enable_dns_support   = var.vpc_enable_dns_support
  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  tags = merge(
    var.tags,
    {
      "Name" = "${var.tags.Name} VPC"
    },
  )
}
