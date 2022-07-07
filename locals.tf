locals {
  subnet_names = tolist(keys(var.subnets))
  azs_map      = {for k,v in data.aws_availability_zones.available.names: local.subnet_names[k] => v}
  name         = format("%s-%s-sg", var.env, var.name)
}

locals {
  subnet_ids      = [for k,v in aws_subnet.private-subnet: v.id]
  security_groups = [for k,v in aws_security_group.default: v.id]
}