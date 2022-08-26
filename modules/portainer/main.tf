resource "docker_service" "portainer" {
    name     = "portainer"

    task_spec {
        container_spec {
            image = "portainer/portainer"
            mounts {
                    source      = "/var/run/docker.sock"
                    target      = "/var/run/docker.sock"
                    type        = "bind"
                }
                
                
        }
            restart_policy = {
      condition    = "on-failure"
      delay        = "3s"
      max_attempts = 4
      window       = "10s"
    }


    }

    endpoint_spec {
      ports {
        name = "portainer"
        target_port = "8000"
        published_port = "8000"
      }
       ports {
        name = "portainers"
        target_port = "9000"
        published_port = "9000"
      }
    }
     
    
}