variable "tenant" {
  default = "test"
}


module "tenant-test" {
  source = "./tenants/test"
  network = "l535z252e0smzlrfu3vn31fp4"
}


module "tenant-prod" {
  source = "./tenants/prod"
  network = "l535z252e0smzlrfu3vn31fp4"
}

