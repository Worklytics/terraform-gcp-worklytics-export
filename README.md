# Worklytics Export to GCP Terraform Module

[![Latest Release](https://img.shields.io/github/v/release/Worklytics/terraform-gcp-worklytics-export)](https://github.com/Worklytics/terraform-gcp-worklytics-export/releases/latest)
[![tests](https://img.shields.io/github/actions/workflow/status/Worklytics/terraform-gcp-worklytics-export/terraform_integration.yaml?label=tests)](https://github.com/Worklytics/terraform-gcp-worklytics-export/actions?query=branch%3Amain)

This module sets IAM policy to support exporting data from Worklytics to a pre-existing GCS bucket
and provisions instructions for doing so.

It is published in the [Terraform Registry](https://registry.terraform.io/modules/Worklytics/worklytics-export/gcp/latest).

It is arguably too minimal to be its own module, but we did so to make it analogous to [AWS case](https://github.com/Worklytics/terraform-aws-worklytics-export)
and provide for potential future provisioning of the connection from the Worklytics side.

## Usage

from Terraform registry:
```hcl
resource "google_storage_bucket" "worklytics_export" {
  name     = "worklytics-export"

  # customize as needed; see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket#argument-reference
}

module "worklytics-export" {
  source  = "terraform-gcp-worklytics-export"
  version = "~> 0.2.0"

  # email address of your Worklytics Tenant's Service Account (obtain from Worklytics)
  worklytics_tenant_sa_email = "YOUR_SA_EMAIL@YOUR_PROJECT_ID.iam.gserviceaccount.com"
  bucket_name                = google_storage_bucket.worklytics_export.name
}
```

via GitHub:
```hcl
module "worklytics-export" {
  source  = "git::https://github.com/worklytics/terraform-gcp-worklytics-export/?ref=v0.1.0"

  # email address of your Worklytics Tenant's Service Account (obtain from Worklytics)
  worklytics_tenant_sa_email = "YOUR_SA_EMAIL@YOUR_PROJECT_ID.iam.gserviceaccount.com"
  bucket_name                = google_storage_bucket.worklytics_export.name
}
```

## Outputs

#### `todo_markdown`

If `todo_as_outputs` is set to true, this will be a markdown-formatted string of TODOs for you to
complete outside of Terraform.


## Compatibility

This module is meant for use with Terraform 1.0+. If you find incompatibilities using Terraform >=
1.0, please open an issue.

## Usage Tips

### Existing Bucket

If you wish to export Worklytics data to an existing bucket, use a Terraform import as follows:

```bash
terraform import module.worklytics_export.google_storage_bucket.worklytics_export <bucket_name>
```

## Development

This module is written and maintained by [Worklytics, Co.](https://worklytics.co/) and intended to
guide our customers in setting up their own infra to export data from Worklytics to AWS.

As this is [published as a Terraform module](https://developer.hashicorp.com/terraform/registry/modules/publish),
we will strive to follow [standard Terraform module structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)
and [style conventions](https://developer.hashicorp.com/terraform/language/syntax/style).

See [examples/basic/](examples/basic/) for a simple example of how to use this module.

Developing:
  1. branch from `main`; open a PR to `main` when ready for review.
  2. releases will be periodically cut from `main` by tagging with semantic version
     (v{MAJOR}.{MINOR}.{PATCH}), push to origin (GitHub), and create a release (hopefully automatic
     via GitHub Actions; via GitHub UI if not).
  3. releases should be automatically picked up by Terraform Registry (some lag here)

## Non-Terraform Instructions

If you don't wish to use Terraform to prepare your infrastructure for receiving exports from
Worklytics, you can do the following.

  1. Create a GCS bucket or choose a preexisting one that you wish to export to. (GCP Console or CLI)
  2. Grant the `roles/storage.objectAdmin` IAM role to your Worklytics Tenant's Service Account
     (obtain from Worklytics) on the bucket.
  3. Create an Export connection via the Worklytics web app.


