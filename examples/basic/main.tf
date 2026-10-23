# basic example of using this module; really as much for dev/testing as a real example of practical
# usage

module "worklytics_export" {
  source = "../../"

  bucket_name                = var.bucket_name
  worklytics_tenant_sa_email = var.worklytics_tenant_sa_email
}

# Write post-apply TODOs to the filesystem from the root module (not from the shared module).
resource "local_file" "worklytics_export_todo" {
  filename = "TODO - configure export in worklytics.md"
  content  = module.worklytics_export.todo_markdown
}
