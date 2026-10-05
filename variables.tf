# Variables aligned with terraform-aws-worklytics-export where applicable.
# Platform-specific prefixes (aws_s3_*, etc.) are omitted — the module implies GCP.

variable "resource_name_prefix" {
  type        = string
  description = "Prefix to give to names of infra created by this module, where applicable."
  default     = "worklytics-export-"
}

variable "bucket_name" {
  type        = string
  description = <<-EOT
    Exact GCS bucket name. When set, used instead of a name derived from resource_name_prefix.
    Set when adopting an existing bucket (via terraform import) or when you need a specific name.
  EOT
  default     = null
}

variable "bucket_location" {
  type        = string
  description = "GCS location for the export bucket (eg 'US', 'EU', 'us-central1')."
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

variable "enable_bucket_uniform_bucket_level_access" {
  type        = bool
  description = <<-EOT
    Whether to enable uniform bucket-level access on the export bucket. Set to `false` if you wish
    to configure something equivalent outside this module.
  EOT
  default     = true
}

variable "enable_bucket_versioning" {
  type        = bool
  description = <<-EOT
    Whether to enable versioning on the export bucket. Set to `false` if you wish to configure
    something equivalent outside this module.
  EOT
  default     = false
}

variable "storage_access_log_bucket" {
  type        = string
  description = <<-EOT
    Optional destination bucket name for access logs of the export bucket. When `null`, access
    logging is not configured by this module (you may add logging yourself using the
    `worklytics_export_bucket` output).
  EOT
  default     = null
}

variable "storage_access_log_prefix" {
  type        = string
  description = "Prefix for access log object keys. Only used when `storage_access_log_bucket` is set."
  default     = "log/"
}

# GCP-specific: tenant auth uses a service account email (vs numeric tenant ID on AWS).
variable "worklytics_tenant_sa_email" {
  type        = string
  description = "Email address of your Worklytics tenant's service account (obtain from Worklytics App)."
}

# GCP-specific: IAM role on the bucket (AWS module uses an inline IAM policy instead).
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
