variable "bucket_name" {
  type        = string
  description = "Exact GCS bucket name for Worklytics data export (eg 'acme-co-worklytics-export')."
}

variable "bucket_location" {
  type        = string
  description = "GCS location for the export bucket (eg 'US', 'EU', 'us-central1'). Required when create_bucket is true."
  default     = null
}

variable "create_bucket" {
  type        = bool
  description = "Whether the module creates and manages the GCS export bucket."
  default     = false
}

variable "worklytics_tenant_sa_email" {
  type        = string
  description = "Email address of your Worklytics tenant's service account (obtain from Worklytics App)."
}
