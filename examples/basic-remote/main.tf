
# basic example of using this module remotely

terraform {
  backend "local" {
  }
}

module "worklytics_export" {
  source  = "Worklytics/worklytics-export/gcp"
  version = "~> 1.0.0"

  resource_name_prefix                        = var.resource_name_prefix
  bucket_name                                 = var.bucket_name
  bucket_location                             = var.bucket_location
  worklytics_tenant_sa_email                  = var.worklytics_tenant_sa_email
  worklytics_host                             = var.worklytics_host
  todos_as_outputs                            = var.todos_as_outputs
  todos_as_local_files                        = var.todos_as_local_files
  enable_bucket_uniform_bucket_level_access   = var.enable_bucket_uniform_bucket_level_access
  enable_bucket_versioning                    = var.enable_bucket_versioning
  storage_access_log_bucket                   = var.storage_access_log_bucket
  storage_access_log_prefix                   = var.storage_access_log_prefix
  bucket_write_iam_role                       = var.bucket_write_iam_role
}
