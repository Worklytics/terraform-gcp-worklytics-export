variable "bucket_name" {
  type        = string
  description = "Name to be used for GCS bucket to which Worklytics data will be exported (eg 'acme-co-worklytics-export')."
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

