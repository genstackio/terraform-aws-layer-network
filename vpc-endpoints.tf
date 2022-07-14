module "vpc-endpoint-ecr" {
  count              = (true == var.ecr_support) ? 1 : 0
  source             = "genstackio/vpc-endpoint/aws"
  version            = "0.2.0"
  service            = "ecr"
  vpc_id             = aws_vpc.vpc.id
  security_group_ids = local.security_groups
  subnet_ids         = local.subnet_ids
}

module "vpc-endpoint-ecr_dkr" {
  count              = (true == var.ecr_support) ? 1 : 0
  source             = "genstackio/vpc-endpoint/aws"
  version            = "0.2.0"
  service            = "ecr_dkr"
  vpc_id             = aws_vpc.vpc.id
  security_group_ids = local.security_groups
  subnet_ids         = local.subnet_ids
}

module "vpc-endpoint-cloudwatch" {
  count              = (true == var.cloudwatch_support) ? 1 : 0
  source             = "genstackio/vpc-endpoint/aws"
  version            = "0.2.0"
  service            = "cloudwatch"
  vpc_id             = aws_vpc.vpc.id
  security_group_ids = local.security_groups
  subnet_ids         = local.subnet_ids
}

module "vpc-endpoint-s3" {
  count          = (true == var.s3_support) ? 1 : 0
  source         = "genstackio/vpc-endpoint/aws"
  version        = "0.2.0"
  service        = "s3"
  vpc_id         = aws_vpc.vpc.id
  route_table_id = aws_route_table.private.id
}

module "vpc-endpoint-dynamodb" {
  count          = (true == var.dynamodb_support) ? 1 : 0
  source         = "genstackio/vpc-endpoint/aws"
  version        = "0.2.0"
  service        = "dynamodb"
  vpc_id         = aws_vpc.vpc.id
  route_table_id = aws_route_table.private.id
}

module "vpc-endpoint-sns" {
  count              = (true == var.sns_support) ? 1 : 0
  source             = "genstackio/vpc-endpoint/aws"
  version            = "0.2.0"
  service            = "sns"
  vpc_id             = aws_vpc.vpc.id
  security_group_ids = local.security_groups
  subnet_ids         = local.subnet_ids
}

module "vpc-endpoint-sqs" {
  count              = (true == var.sqs_support) ? 1 : 0
  source             = "genstackio/vpc-endpoint/aws"
  version            = "0.2.0"
  service            = "sqs"
  vpc_id             = aws_vpc.vpc.id
  security_group_ids = local.security_groups
  subnet_ids         = local.subnet_ids
}

module "vpc-endpoint-lambda" {
  count              = (true == var.lambda_support) ? 1 : 0
  source             = "genstackio/vpc-endpoint/aws"
  version            = "0.2.0"
  service            = "lambda"
  vpc_id             = aws_vpc.vpc.id
  security_group_ids = local.security_groups
  subnet_ids         = local.subnet_ids
}

module "vpc-endpoint-eventbridge" {
  count              = (true == var.eventbridge_support) ? 1 : 0
  source             = "genstackio/vpc-endpoint/aws"
  version            = "0.2.0"
  service            = "eventbridge"
  vpc_id             = aws_vpc.vpc.id
  security_group_ids = local.security_groups
  subnet_ids         = local.subnet_ids
}

module "vpc-endpoint-secretsmanager" {
  count              = (true == var.secretsmanager_support) ? 1 : 0
  source             = "genstackio/vpc-endpoint/aws"
  version            = "0.2.0"
  service            = "secretsmanager"
  vpc_id             = aws_vpc.vpc.id
  security_group_ids = local.security_groups
  subnet_ids         = local.subnet_ids
}

module "vpc-endpoint-ses" {
  count              = (true == var.ses_support) ? 1 : 0
  source             = "genstackio/vpc-endpoint/aws"
  version            = "0.2.0"
  service            = "ses"
  vpc_id             = aws_vpc.vpc.id
  security_group_ids = local.security_groups
  subnet_ids         = local.subnet_ids
}
