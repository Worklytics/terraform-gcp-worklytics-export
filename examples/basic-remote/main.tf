
# basic example of using this module remotely

terraform {
  backend "local" {
  }
}

module "worklytics_export" {
  source  = "Worklytics/worklytics-export/gcp"
  version = "~> 1.0.0"

  bucket_name                = var.bucket_name
  bucket_location            = var.bucket_location
  create_bucket              = var.create_bucket
  worklytics_tenant_sa_email = var.worklytics_tenant_sa_email
  worklytics_host            = var.worklytics_host
  todos_as_outputs           = var.todos_as_outputs
  todos_as_local_files       = var.todos_as_local_files
}
