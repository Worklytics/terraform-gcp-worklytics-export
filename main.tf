

resource "google_storage_bucket_iam_member" "worklytics_export" {
  bucket = var.bucket_name
  member = "serviceAccount:${var.worklytics_tenant_sa_email}"
  role   = "roles/storage.objectAdmin"
}


locals {
  todo_content = <<EOT
# TODO : Configure Data Export in Worklytics

1. Ensure you're authenticated with Worklytics. Either sign-in at [https://${var.worklytics_host}](https://${var.worklytics_host})
  with your organization's SSO provider *or* request OTP link from your Worklytics support team.
2. Visit `https://${var.worklytics_host}/analytics/data-export/connect?bucket=${var.bucket_name}`
3. Review any additional settings (such as the Dataset type you'd like to export) and adjust
  values as you see fit, then click "Create Data Export".

Alternatively, you may follow the manual instructions below:

1. Visit [https://${var.worklytics_host}/analytics/data-export](https://${var.worklytics_host}/analytics/data-export)
  (or login into Worklytics, and navigate to Manage --> Export Data).
2. Click on the 'Create New Data Export' button in the upper right.
3. Fill in the form with the following values:
  - **Data Export Name** - choose a name that will help you identify this export in the future.
  - **Data Export Type** - choose the type of data you'd like to export. Check our
    [Data Export Documentation](https://${var.worklytics_host}/docs/data-export) for a complete
    description of all the available datasets.
  - **Data Destination** - choose 'Google Cloud Storage', use `${var.bucket_name}`
    for the **Bucket** field

EOT
}


resource "local_file" "readme" {
  count = var.todos_as_local_files ? 1 : 0

  filename = "TODO - configure export in worklytics.md"

  content = local.todo_content
}
