///public rt
# igw etc
resource "aws_route_table" "default_public" {
  vpc_id = aws_vpc.default.id
  tags = merge(
    var.global_tags,
    {
      "Name" = "${var.global_tags.name}_public"
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
  count  = length(var.aws_azs)
  vpc_id = aws_vpc.default.id
  tags = merge(
    var.global_tags,
    {
      "Name" = "${var.global_tags.name}_private_az${count.index + 1}"
    },
  )
}

#nats etc
resource "aws_route" "private_nat_gateway" {
  count                  = var.nats_enabled && length(var.aws_azs) > 0 ? var.az_count : 0
  route_table_id         = element(aws_route_table.default_private.*.id, count.index)
  nat_gateway_id         = element(aws_nat_gateway.default.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  depends_on = [
    aws_route_table.default_private,
    aws_nat_gateway.default,
  ]
}