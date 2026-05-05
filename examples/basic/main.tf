
# basic example of using this module; really as much for dev/testing as a real example of practical
# usage

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0, < 8"
    }
  }
}

provider "google" {

}


module "worklytics_export" {
  source = "../../"

  bucket_name                = var.bucket_name
  worklytics_tenant_sa_email = var.worklytics_tenant_sa_email
}
