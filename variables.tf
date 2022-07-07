variable "env" {
  type = string
}
variable "name" {
  type    = string
  default = "network"
}
variable "cidr_block" {
  type = string
}
variable "subnets" {
  type    = map(object({
    public: bool,
    cidr_block: string
    availability_zone: string
  }))
  default = {}
}
variable "dns_hostnames" {
  type    = bool
  default = true
}
variable "dns_support" {
  type    = bool
  default = true
}
variable "security_group" {
  type    = bool
  default = false
}
variable "security_group_allow_outgoing" {
  type    = bool
  default = false
}
variable "security_group_allow_internal_https" {
  type    = bool
  default = false
}
variable "security_group_allow_internal_smtps" {
  type    = bool
  default = false
}
variable "internet_gateway" {
  type    = bool
  default = false
}
variable "outgoing_internet_access" {
  type    = bool
  default = false
}
variable "ecr_support" {
  type    = bool
  default = false
}
variable "cloudwatch_support" {
  type    = bool
  default = false
}
variable "s3_support" {
  type    = bool
  default = false
}
