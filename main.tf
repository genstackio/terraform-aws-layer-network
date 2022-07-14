resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.dns_hostnames
  enable_dns_support   = var.dns_support
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_subnet" "private-subnet" {
  for_each          = local.private_subnets
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = lookup(each.value, "cidr_block", var.cidr_block)
  availability_zone = local.azs_map[each.key]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_subnet" "public-subnet" {
  for_each   = local.public_subnets
  vpc_id     = aws_vpc.vpc.id
  cidr_block = lookup(each.value, "cidr_block", var.cidr_block)
  lifecycle {
    create_before_destroy = true
  }
  map_public_ip_on_launch = true
}

resource "aws_eip" "nat" {
  for_each   = length(local.public_subnets) ? local.public_subnets : {}
  vpc        = true
  depends_on = aws_internet_gateway.igw
}

resource "aws_nat_gateway" "nat" {
  for_each      = length(local.public_subnets) ? local.public_subnets : {}
  subnet_id     = aws_subnet.public-subnet[each.key].id
  allocation_id = aws_eip.nat[each.key].id
}

resource "aws_route_table_association" "private" {
  for_each       = local.private_subnets
  subnet_id      = aws_subnet.private-subnet[each.key].id
  route_table_id = aws_route_table.private.id
}

resource "aws_security_group" "default" {
  count       = true == var.security_group ? 1 : 0
  vpc_id      = aws_vpc.vpc.id
  name        = local.name
  description = format("Security Group for %s", local.name)
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_security_group_rule" "allow-outgoing" {
  count             = (true == var.security_group && true == var.security_group_allow_outgoing) ? 1 : 0
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.default[0].id
}
resource "aws_security_group_rule" "allow-internal-https" {
  count             = (true == var.security_group && true == var.security_group_allow_internal_https) ? 1 : 0
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = [for k,v in aws_subnet.private-subnet: v.cidr_block]
  security_group_id = aws_security_group.default[0].id
}
resource "aws_security_group_rule" "allow-internal-smtps" {
  count             = (true == var.security_group && true == var.security_group_allow_internal_smtps) ? 1 : 0
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 465
  to_port           = 465
  cidr_blocks       = [for k,v in aws_subnet.private-subnet: v.cidr_block]
  security_group_id =  aws_security_group.default[0].id
}
resource "aws_internet_gateway" "igw" {
  count             = (true == var.internet_gateway) ? 1 : 0
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route" "internet_access" {
  count                  = (true == var.internet_gateway && true == var.outgoing_internet_access) ? 1 : 0
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = length(local.public_subnets) > 0 ? null : aws_internet_gateway.igw[0].id
  nat_gateway_id         = length(local.public_subnets) > 0 ? aws_nat_gateway.nat[tolist(keys(local.public_subnets))[0]].id : null
}
