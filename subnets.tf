//////public subnet
resource "aws_subnet" "default_public_subnet" {
  count             = length(var.aws_azs)
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = trimspace(var.aws_azs[count.index])
  map_public_ip_on_launch = true
  tags = merge(
    var.tags,
    {
      "Name" = "${var.tags.Name}_public_subnet_az${count.index + 1}"
    },
  )
  depends_on = [
    aws_vpc.default,
  ]
}

resource "aws_route_table_association" "default_public_assoc" {
  count          = length(var.aws_azs)
  subnet_id      = element(aws_subnet.default_public_subnet.*.id, count.index)
  route_table_id = aws_route_table.default_public.id
}


//////// private subnets
resource "aws_subnet" "default_private_subnet" {
  count             = length(var.aws_azs)
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = trimspace(var.aws_azs[count.index])
  tags = merge(
    var.tags,
    {
      "Name" = "${var.tags.Name}_private_subnet_az${count.index + 1}"
    },
  )
  depends_on = [
    aws_vpc.default,
  ]
}

resource "aws_route_table_association" "default_private_assoc" {
  count          = length(var.aws_azs)
  subnet_id      = element(aws_subnet.default_private_subnet.*.id, count.index)
  route_table_id = aws_route_table.default_private.id
}