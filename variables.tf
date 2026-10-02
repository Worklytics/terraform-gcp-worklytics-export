variable "bucket_name" {
  type        = string
  description = "Exact GCS bucket name for Worklytics data export (eg 'acme-co-worklytics-export'). Use the full bucket name you want, not a prefix."
}

variable "bucket_location" {
  type        = string
  description = "GCS location for the export bucket (eg 'US', 'EU', 'us-central1'). Required when create_bucket is true."
  default     = null

  validation {
    condition     = !var.create_bucket || var.bucket_location != null
    error_message = "bucket_location is required when create_bucket is true."
  }
}

variable "create_bucket" {
  type        = bool
  description = <<-EOT
    Whether this module creates and manages the GCS export bucket.
    Defaults to true. Set to false if the bucket already exists outside this module and you only
    want IAM bindings managed here.
  EOT
  default     = true
}

variable "worklytics_tenant_sa_email" {
  type        = string
  description = "Email address of your Worklytics tenant's service account (obtain from Worklytics App)."
}

variable "worklytics_host" {
  type        = string
  description = "host of worklytics instance where tenant resides. (e.g. app.worklytics.co for prod; but may differ for dev/staging)"
  default     = "app.worklytics.co"
}

variable "todos_as_outputs" {
  type        = bool
  description = "whether to render TODOs as outputs (former useful if you're using Terraform Cloud/Enterprise, or somewhere else where the filesystem is not readily accessible to you)"
  default     = false
}

variable "todos_as_local_files" {
  type        = bool
  description = "whether to render TODOs as flat files"
  default     = true
}

variable "bucket_write_iam_role" {
  type        = string
  description = <<-EOT
    IAM role to grant the Worklytics tenant service account on the export bucket.
    Defaults to roles/storage.objectAdmin (the Worklytics-documented role).

    Minimum permissions required (PoLP) — use these to create a custom role if you
    prefer not to grant the broader objectAdmin:
      - storage.objects.create  (write/upload export files)
      - storage.objects.delete  (required for overwrite; GCS models overwrite as delete+create)
      - storage.objects.list    (enumerate objects in bucket)

    Pass a custom role as a fully-qualified ID, e.g.:
      bucket_write_iam_role = "projects/my-project/roles/worklyticsExportWriter"
  EOT
  default     = "roles/storage.objectAdmin"

  validation {
    condition = can(regex(
      "^(roles/|projects/[^/]+/roles/|organizations/[^/]+/roles/)[a-zA-Z0-9_.]+$",
      var.bucket_write_iam_role
    ))
    error_message = "bucket_write_iam_role must be a built-in role (roles/...) or a custom role (projects/{project}/roles/{id} or organizations/{org}/roles/{id})."
  }
}

