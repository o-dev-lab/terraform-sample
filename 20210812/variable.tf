variable "access_key" {
  description = "access_key"
}
variable "secret_key" {
  description = "secret_key"
}
variable "region" {
  default = "us-west-2"
}

data "aws_availability_zones" "available" {
  state = "available"
}