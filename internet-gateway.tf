resource "aws_eip" "nat" {
  count = var.nats_enabled && length(var.aws_azs) > 0 ? length(var.aws_azs) : 0
  tags  = var.tags
  vpc   = true
}