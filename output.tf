output "todo_markdown" {
  value       = var.todos_as_outputs ? local.todo_content : null
  description = "Actions that must be performed outside of Terraform (markdown format)."
}

output "worklytics_export_bucket" {
  value       = google_storage_bucket.worklytics_export
  description = "The GCS bucket used for Worklytics export. See google_storage_bucket for details."
}
