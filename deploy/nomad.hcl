job "traefik-job" {
    region = "eu-west-1"
    datacenters = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
    type = "system"
    group "traefik-group" {
        task "traefik-task" {
            driver = "raw_exec"
            config {
                command = "/usr/bin/docker"
                args = ["run", "--net=host", "traefik",  "--consulCatalog", "--entryPoints='Name:http Address:0.0.0.0:8080'","--entryPoints='Name:https Address:0.0.0.0:8443'","--defaultEntryPoints=http","--web", "--web.address=${NOMAD_IP_traefikMonitoring}:8081"]
            }
            resources {
                cpu = 500
                memory = 128
                network {
                    mbits = 100
                    port "traefikHttp" {
                      static = 8080
                    }
                    port "traefikMonitoring" {
                      static = "8081"
                    }
                    port "traefikHttps" {
                      static = 8443
                    }
                }
            }
        }
    }
}
