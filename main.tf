terraform {
  required_version = ">= 1.3, < 2"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.0"
    }
  }
}


# Worklytics export requires write + overwrite access to the bucket.
# GCS implements overwrite as delete+create, so the minimum permissions (PoLP) are:
#   - storage.objects.create  (upload/write new objects)
#   - storage.objects.delete  (required for in-place overwrite of existing exports)
#   - storage.objects.list    (needed to enumerate existing objects)
#
# `roles/storage.objectAdmin` satisfies these and is the Worklytics-documented role, but
# also includes storage.objects.get/update/getIamPolicy/setIamPolicy which aren't required.
# If you prefer tighter permissions, create a custom role with the three permissions above
# and pass its fully-qualified ID via the `bucket_write_iam_role` variable, e.g.:
#
#   bucket_write_iam_role = "projects/my-project/roles/worklyticsExportWriter"
#
# See: https://docs.worklytics.co/analytics/data-export/google-cloud-storage
#trivy:ignore:AVD-GCP-0007 - objectAdmin is the documented minimum for GCS export (overwrite requires delete+create); see comment above
resource "google_storage_bucket_iam_member" "worklytics_export" {
  bucket = var.bucket_name
  member = "serviceAccount:${var.worklytics_tenant_sa_email}"
  role   = var.bucket_write_iam_role
}


locals {
  todo_content = <<EOT
# TODO : Configure Data Export in Worklytics

1. Ensure you're authenticated with Worklytics. Either sign-in at [https://${var.worklytics_host}](https://${var.worklytics_host})
  with your organization's SSO provider *or* request OTP link from your Worklytics support team.
2. Visit `https://${var.worklytics_host}/analytics/data-export/connect?type=GOOGLE_CLOUD_STORAGE&bucket=${var.bucket_name}`
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
