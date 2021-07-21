terraform {
  backend "remote" {
    organization = "muz4k-learning"

    workspaces {
      name = "project"
    }
  }
}