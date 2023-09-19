# Worklytics Export to GCP Terraform Module

[![Latest Release](https://img.shields.io/github/v/release/Worklytics/terraform-gcp-worklytics-export)](https://github.com/Worklytics/terraform-aws-worklytics-export/releases/latest)
[![tests](https://img.shields.io/github/actions/workflow/status/Worklytics/terraform-gcp-worklytics-export/terraform_integration.yaml?label=tests)](https://github.com/Worklytics/terraform-aws-worklytics-export/actions?query=branch%3Amain)

This module creates infra to support exporting data from Worklytics to GCP.

It is published in the [Terraform Registry](https://registry.terraform.io/modules/Worklytics/worklytics-export/gcp/latest).

## Usage

from Terraform registry:
```hcl
module "worklytics-export" {
  source  = "terraform-gcp-worklytics-export"
  version = "~> 0.1.0"

  # email address of your Worklytics Tenant's Service Account (obtain from Worklytics)
  worklytics_tenant_sa_email_ = "YOUR_SA_EMAIL@YOUR_PROJECT_ID.iam.gserviceaccount.com"
}
```

via GitHub:
```hcl
module "worklytics-export" {
  source  = "git::https://github.com/worklytics/terraform-gcp-worklytics-export/?ref=v0.1.0"

  # email address of your Worklytics Tenant's Service Account (obtain from Worklytics)
  worklytics_tenant_sa_email_ = "YOUR_SA_EMAIL@YOUR_PROJECT_ID.iam.gserviceaccount.com"
}
```

## Outputs

#### `worklytics_export_bucket`
The Terraform resource created as the export bucket. See [`google_storage_bucket`](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_storage_bucket) for details.

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


