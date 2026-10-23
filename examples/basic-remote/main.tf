# basic example of using this module remotely

terraform {
  backend "local" {
  }

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = ">= 2.0"
    }
  }
}

module "worklytics_export" {
  source  = "Worklytics/worklytics-export/gcp"
  version = "~> 2.0.0"

  bucket_name                = var.bucket_name
  worklytics_tenant_sa_email = var.worklytics_tenant_sa_email
  worklytics_host            = var.worklytics_host
}

resource "local_file" "worklytics_export_todo" {
  filename = "TODO - configure export in worklytics.md"
  content  = module.worklytics_export.todo_markdown
}
