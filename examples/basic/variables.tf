variable "resource_name_prefix" {
  type        = string
  description = "Prefix to give to names of infra created by this module, where applicable."
  default     = "worklytics-export-"
}

variable "bucket_name" {
  type        = string
  description = "Exact GCS bucket name. Set when using a pre-existing bucket (import before apply)."
  default     = null
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
