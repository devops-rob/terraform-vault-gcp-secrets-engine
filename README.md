# Vault GCP Secrets Engine Terraform Module

The GCP secrets engine Terraform module configures HashiCorp Vault secrets engine for GCP and the associated Vault roleset.  This module will enable operators to implement dynamic credential provisioning for their GCP environments.

### GCP Requirements

- A GCP project.
- A GCP service account.
- The service account needs the following permissions:
    - iam.serviceAccountKeys.create
    - iam.serviceAccountKeys.delete
    - iam.serviceAccountKeys.get
    - iam.serviceAccountKeys.list
    - iam.serviceAccounts.create
    - iam.serviceAccounts.delete
    - iam.serviceAccounts.get
    - resourcemanager.projects.getIamPolicy
    - resourcemanager.projects.setIamPolicy
- A GCP credentials file for the service account.

For information about Service Accounts, Permissions and Roles, refer to the [Google Cloud documentation](https://cloud.google.com/iam/docs/creating-managing-service-accounts)

***NOTE: Credentials files should not be committed to Version Control systems.***

### Usage example

```hcl
provider "vault" {
  address = "http://localhost:8200"
  token   = var.vault_token
}

variable "vault_token" {
  description = "Set this value using the 'TF_VAR_vault_token' environment variable."
}

variable "project" {
  default     = "test"
  description = "GCP project name"
}

module "gcp_defaults" {
  source = "../../"

  path             = "gcp"
  gcp_project      = var.project
  gcp_roleset_name = "key-role"
  gcp_credentials  = file("credentials.json")
  gcp_secret_type  = "service_account_key"

  gcp_bindings = [
    {
      resource = "//cloudresourcemanager.googleapis.com/projects/${var.project}"
      roles = [
        "roles/viewer"
      ]
    }
  ]
}
```