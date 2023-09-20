
output "todo_markdown" {
  value       = var.todos_as_outputs ? local.todo_content : null
  description = "Actions that must be performed outside of Terraform (markdown format)."
}
