locals {
  subnet_names = tolist(keys(var.subnets))
  azs_map      = {for k,v in data.aws_availability_zones.available.names: local.subnet_names[k] => v}
  name         = format("%s-%s-sg", var.env, var.name)
}

locals {
  subnets = aws_subnet.private-subnet
  security_groups = [aws_security_group.default.id]
}