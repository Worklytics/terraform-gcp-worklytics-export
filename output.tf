output "todo_markdown" {
  value       = var.todos_as_outputs ? local.todo_content : null
  description = "Actions that must be performed outside of Terraform (markdown format)."
}

output "worklytics_export_bucket" {
  value       = var.create_bucket ? google_storage_bucket.worklytics_export[0] : null
  description = "The GCS bucket used for Worklytics export, when create_bucket is true. See google_storage_bucket for details."
}
