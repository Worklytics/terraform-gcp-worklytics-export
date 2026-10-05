locals {
  bucket_name_prefix_normalized = replace(lower(var.resource_name_prefix), "_", "-")

  # bucket_name when set; otherwise derive from resource_name_prefix.
  export_bucket_name = coalesce(
    var.bucket_name,
    "${local.bucket_name_prefix_normalized}${random_id.bucket_suffix[0].hex}"
  )

  export_bucket_location = var.bucket_location
}
