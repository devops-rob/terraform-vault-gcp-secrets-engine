provider "vault" {
  address = "http://localhost:8200"
  token   = var.vault_token
}

variable "vault_token" {
  description = "Set this value using the 'TF_VAR_vault_token' environment variable."
}

variable "project" {
  default     = "vault-test"
  description = "GCP project name"
}

module "gcp_defaults" {
  source = "devops-rob/gcp-secrets-engine/vault"

  path = "gcp"
  gcp_project      = var.project
  gcp_roleset_name = "oauth-role"
  gcp_credentials  = file("credentials.json")

  gcp_bindings = [
    {
      resource = "//cloudresourcemanager.googleapis.com/projects/${var.project}"
      roles = [
        "roles/viewer"
      ]
    }
  ]
}
