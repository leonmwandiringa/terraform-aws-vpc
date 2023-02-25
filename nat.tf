resource "aws_nat_gateway" "default" {
  count         = var.nats_enabled && length(var.aws_azs) > 0 ? length(var.aws_azs) : 0
  subnet_id     = element(aws_subnet.default_public_subnet.*.id, count.index)
  allocation_id = element(aws_eip.nat.*.id, count.index)
  tags          = merge(
    var.tags,
    {
      Name = "${var.tags.Name}_Nat_${count.index}"
    }
  )
  depends_on = [
    aws_internet_gateway.default,
    aws_eip.nat,
    aws_subnet.default_public_subnet,
  ]
  lifecycle {
    ignore_changes = [tags]
  }
}