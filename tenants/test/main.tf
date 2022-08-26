variable "network"          {}
variable "tenant" {
  default = "test"
}
variable "port" {
  default = "6978"
}
variable "sentinel-replica" {
  default = "2"
}
variable "slave-replica" {
  default = "2"
}
module "redis" {
  source = "../../modules/redis"
  tenant = var.tenant
  network = var.network
  port = var.port
  sentinel-replica = var.sentinel-replica
  slave-replica = var.slave-replica
}





