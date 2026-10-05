
# basic example of using this module; really as much for dev/testing as a real example of practical
# usage

module "worklytics_export" {
  source = "../../"

  resource_name_prefix        = var.resource_name_prefix
  worklytics_tenant_sa_email  = var.worklytics_tenant_sa_email
  bucket_name                 = var.bucket_name
  bucket_location             = var.bucket_location
}
