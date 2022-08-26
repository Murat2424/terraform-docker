variable "tenant"          {}
variable "network"          {}
variable "port"          {}
variable "sentinel-replica"          {}
variable "slave-replica"          {}


resource "docker_service" "redis-master" {
    name     = "${var.tenant}-redis"

    task_spec {
        container_spec {
            image = "bitnami/redis:latest"
                env = {
                    "REDIS_REPLICATION_MODE" = "master"
                    #"REDIS_PASSWORD" = "str0ng_passw0rd"
                    "ALLOW_EMPTY_PASSWORD" = "yes"
                    


                }
                

        }

        restart_policy = {
        condition    = "on-failure"
        delay        = "3s"
        max_attempts = 4
        window       = "10s"
    }
      networks = ["${var.network}"]


    }
        endpoint_spec {
      ports {
        name = "master"
        target_port = "${var.port}"
        published_port = "${var.port}"
        
      }
      

    }


         
}
resource "docker_service" "redis-slave" {
    name     = "${var.tenant}-redis-slave"

    task_spec {
        container_spec {
            image = "bitnami/redis:latest"
                env = {
                    "REDIS_REPLICATION_MODE" = "slave"
                    "REDIS_MASTER_HOST" = "${var.tenant}-redis"
                    #"REDIS_MASTER_PASSWORD" = "str0ng_passw0rd"
                   # "REDIS_PASSWORD" = "str0ng_passw0rd"
                    "ALLOW_EMPTY_PASSWORD" = "yes"


                }

        }

        restart_policy = {
        condition    = "on-failure"
        delay        = "3s"
        max_attempts = 4
        window       = "10s"
    }
        
      networks = ["${var.network}"]
    }
    mode {
    replicated {
      replicas = "${var.slave-replica}"
    }
  }
            endpoint_spec {
      ports {
        name = "slave"
        target_port = "6379"

        
      }
      

    }
}
resource "docker_service" "redis-sentinel" {
    name     = "${var.tenant}-redis-sentinel"

    task_spec {
        container_spec {
            image = "bitnami/redis-sentinel:latest"
                env = {
                   # "REDIS_MASTER_PASSWORD" = "str0ng_passw0rd"
                    "REDIS_MASTER_HOST" = "${var.tenant}-redis"
                    "REDIS_SENTINEL_DOWN_AFTER_MILLISECONDS" = "5000"
                    "REDIS_SENTINEL_FAILOVER_TIMEOUT" = "5000"
                    "REDIS_SENTINEL_QUORUM" = "1"
                }

        }

        restart_policy = {
        condition    = "on-failure"
        delay        = "3s"
        max_attempts = 4
        window       = "10s"
    }
        networks = ["${var.network}"]

    }
        mode {
    replicated {
      replicas = "${var.sentinel-replica}"
    }
  }
    endpoint_spec {
      ports {
        name = "sentinel"
        target_port = "26379"
        
      }
      ports {
        name = "sentinel1"
        target_port = "26380"
        
      }
      ports {
        name = "sentinel2"
        target_port = "26381"
        
      }
      

    }


    
     
}

