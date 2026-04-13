# Basic Worklytics Export to GCS Example

We don't recommend *direct* use of this example, but rather use it as a reference for how to add
the Worklytics Export module to your own Terraform configuration or as a working example when
developing the module itself.


## Usage for Development

Within `examples/basic/` (eg, here), create a `terraform.tfvars` file with the following content,
customizing your Worklytics's tenant SA ass needed.

```hcl
bucket_name = "my-bucket"
worklytics_tenant_sa_email = "my-worklytics-tenant-sa@eval-engin.iam.gserviceaccount.com"

```

Then test the example:

```shell
terraform init
terraform apply
```
