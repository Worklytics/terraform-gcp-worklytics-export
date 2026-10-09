variable "bucket_name" {
  type        = string
  description = "GCS bucket name for Worklytics export (import before apply when using a pre-existing bucket)."
}

variable "bucket_location" {
  type        = string
  description = "GCS location for the export bucket (eg 'US', 'EU', 'us-central1')."
  default     = "US"
}

variable "worklytics_tenant_sa_email" {
  type        = string
  description = "Email address of your Worklytics tenant's service account (obtain from Worklytics App)."
}
