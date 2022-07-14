locals {
  private_subnets = {for k,v in var.subnets: k => v if true != lookup(v, "public", false)}
  public_subnets = {for k,v in var.subnets: k => v if true == lookup(v, "public", false)}
  private_subnet_names = tolist(keys(local.private_subnets))
  public_subnet_names = tolist(keys(local.public_subnets))
  private_azs_map = {for k,v in data.aws_availability_zones.available.names: local.private_subnet_names[k] => v if k <= length(local.private_subnet_names)}
  public_azs_map  = {for k,v in data.aws_availability_zones.available.names: local.public_subnet_names[k] => v if k <= length(local.public_subnet_names)}
  name         = format("%s-%s-sg", var.env, var.name)
  has_public_subnets = length(tolist(keys(local.public_subnets))) > 0
  has_private_subnets = length(tolist(keys(local.private_subnets))) > 0
}

locals {
  subnet_ids      = [for k,v in aws_subnet.private-subnet: v.id]
  security_groups = [for k,v in aws_security_group.default: v.id]
}