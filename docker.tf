terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "2.11.0"
    }
      null = {
      source = "hashicorp/null"
    }

  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
 
}

