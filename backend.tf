# backend.tf

terraform {
  backend "gcs" {
    bucket  = "vladan-tourist-agency-tfstate"
    prefix  = "terraform/state"
  }
}