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
  description = "host of worklytics instance where tenant resides. (e.g. intl.worklytics.co for prod; but may differ for dev/staging)"
  default     = "intl.worklytics.co"
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
