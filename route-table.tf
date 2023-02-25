///public rt
# igw etc
resource "aws_route_table" "default_public" {
  vpc_id = aws_vpc.default.id
  tags = merge(
    var.tags,
    {
      "Name" = "${var.tags.Name}_public"
    },
  )
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.default_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.default.id
}

///private rt
resource "aws_route_table" "default_private" {
  vpc_id = aws_vpc.default.id
  tags = merge(
    var.tags,
    {
      "Name" = "${var.tags.Name}_private"
    },
  )
}

#nats etc
resource "aws_route" "nat_gateway" {
  count                  = var.nats_enabled && length(var.aws_azs) > 0 ? length(var.aws_azs) : 0
  route_table_id         = aws_route_table.default_private.id
  nat_gateway_id         = element(aws_nat_gateway.default.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  depends_on = [
    aws_route_table.default_private,
    aws_nat_gateway.default,
  ]
}