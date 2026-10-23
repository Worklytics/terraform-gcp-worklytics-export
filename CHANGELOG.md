# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2026-10-23

### Changed

- Minimum supported Terraform version is now `> 1.11.0` (was `>= 1.3`).
- `todo_markdown` is always populated; it is no longer optional via `todos_as_outputs`.
- Examples write `TODO - configure export in worklytics.md` from the **root** module using
  `hashicorp/local`, wired to `todo_markdown`.

### Removed

- `hashicorp/local` from the module's `required_providers` and the in-module `local_file` resource.
- Module input variables `todos_as_outputs` and `todos_as_local_files`.

### Added

- Trivy configuration scanning in CI (SARIF upload to GitHub Security; `Terraform security` gate
  job fails on HIGH and CRITICAL findings).

## [1.0.0] - 2026-08-17

### Changed

- Require `hashicorp/google` `>= 6.0` (Google provider 5.x is no longer supported).
- Require Terraform `>= 1.3`.
- Optional `bucket_write_iam_role` for a custom IAM role instead of `roles/storage.objectAdmin`.

### Added

- Expanded Terraform version matrix in CI; initial Trivy IaC scanning workflow.
