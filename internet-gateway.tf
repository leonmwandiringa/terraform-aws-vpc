resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
  tags = merge(
    var.tags,
    {
      "Name" = "${var.tags.Name} Internet Gateway"
    },
  )
  depends_on = [
    aws_vpc.default,
  ]
}