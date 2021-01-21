resource "vault_gcp_secret_backend" "gcp" {
  path  = var.path

  default_lease_ttl_seconds = var.gcp_default_ttl
  max_lease_ttl_seconds     = var.gcp_maximum_ttl
  credentials               = var.gcp_credentials
}

resource "vault_gcp_secret_roleset" "gcp" {
  backend = vault_gcp_secret_backend.gcp.path

  project = var.gcp_project
  roleset = var.gcp_roleset_name

  dynamic "binding" {
    for_each = var.gcp_bindings
    content {
      resource = binding.value["resource"]
      roles    = binding.value["roles"]
    }
  }

  secret_type  = var.gcp_secret_type
  token_scopes = var.gcp_token_scopes
}