module "vpc-endpoint-ecr" {
  count              = (true == var.ecr_support) ? 1 : 0
  source             = "genstackio/vpc-endpoint/aws"
  version            = "0.2.0"
  service            = "ecr"
  vpc_id             = aws_vpc.vpc.id
  security_group_ids = local.security_groups
  subnet_ids         = local.subnets
}

module "vpc-endpoint-ecr_dkr" {
  count              = (true == var.ecr_support) ? 1 : 0
  source             = "genstackio/vpc-endpoint/aws"
  version            = "0.2.0"
  service            = "ecr_dkr"
  vpc_id             = aws_vpc.vpc.id
  security_group_ids = local.security_groups
  subnet_ids         = var.subnets
}

module "vpc-endpoint-cloudwatch" {
  count              = (true == var.cloudwatch_support) ? 1 : 0
  source             = "genstackio/vpc-endpoint/aws"
  version            = "0.2.0"
  service            = "cloudwatch"
  vpc_id             = aws_vpc.vpc.id
  security_group_ids = local.security_groups
  subnet_ids         = var.subnets
}

module "vpc-endpoint-s3" {
  count          = (true == var.s3_support) ? 1 : 0
  source         = "genstackio/vpc-endpoint/aws"
  version        = "0.2.0"
  service        = "s3"
  vpc_id         = aws_vpc.vpc.id
  route_table_id = aws_route_table.private.id
}
