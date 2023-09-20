variable "bucket_name" {
  type        = string
  description = "Name to be used for GCS bucket to which Worklytics data will be exported (eg 'acme-co-worklytics-export')."
}

variable "worklytics_tenant_sa_email" {
  type        = string
  description = "Email address of your Worklytics tenant's service account (obtain from Worklytics App)."
}
