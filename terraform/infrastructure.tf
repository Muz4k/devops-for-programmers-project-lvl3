resource "digitalocean_droplet" "servers" {
  count  = 2
  image  = "docker-20-04"
  name   = format("project-%02d", count.index + 1)
  region = "ams3"
  size   = "s-1vcpu-1gb"
  ssh_keys = [
    data.digitalocean_ssh_key.victory.id
  ]
}

resource "digitalocean_loadbalancer" "project" {
  name   = "project"
  region = "ams3"

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = var.application_port
    target_protocol = "http"
  }

  forwarding_rule {
    entry_port     = 443
    entry_protocol = "https"

    target_port     = var.application_port
    target_protocol = "http"

    certificate_name = digitalocean_certificate.project.name
  }

  healthcheck {
    port     = var.application_port
    path     = "/"
    protocol = "http"
  }

  droplet_ids = digitalocean_droplet.servers.*.id
}

resource "digitalocean_domain" "default" {
  name       = "project.gitpushforce.club"
  ip_address = digitalocean_loadbalancer.project.ip
}

resource "digitalocean_certificate" "project" {
  name = "project-certificate"
  type = "lets_encrypt"
  domains = [
    "project.gitpushforce.club"
  ]
}

output "webserver_ips" {
  value = digitalocean_droplet.servers.*.ipv4_address
}

resource "digitalocean_database_db" "database" {
  cluster_id = digitalocean_database_cluster.postgres.id
  name       = "strapi"
}

resource "digitalocean_database_cluster" "postgres" {
  name       = "postgres-cluster"
  engine     = "pg"
  version    = "11"
  size       = "db-s-1vcpu-1gb"
  region     = "ams3"
  node_count = 1
}
