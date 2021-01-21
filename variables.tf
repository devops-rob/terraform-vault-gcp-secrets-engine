variable "gcp_default_ttl" {
  type        = number
  default     = 3600
  description = "(Optional) Default TTL for GCP secrets backend."
}

variable "gcp_maximum_ttl" {
  type        = number
  default     = 3600
  description = "(Optional) Maximum TTL for GCP secrets backend."
}

variable "gcp_credentials" {
  description = "(Optional) The GCP service account credentials in JSON format."
  default     = null
}

variable "gcp_project" {
  type        = string
  default     = null
  description = "(Required) Name of the GCP project that this roleset's service account will belong to."
}

variable "gcp_roleset_name" {
  type        = string
  default     = null
  description = "(Required) Name of the Roleset to create."
}

variable "gcp_secret_type" {
  type        = string
  default     = "access_token"
  description = "(Optional) Type of secret generated for this role set. Accepted values: `access_token`, `service_account_key`. Defaults to `access_token`"
}

variable "gcp_token_scopes" {
  type = list(string)
  default = [
    "https://www.googleapis.com/auth/cloud-platform"
  ]
  description = "(Optional, Required for gcp_secret_type = `access_token`) List of OAuth scopes to assign to `access_token` secrets generated under this role set. Defaults to `https://www.googleapis.com/auth/cloud-platform`"
}

variable "gcp_bindings" {
  type = list(object({
    resource = string
    roles    = list(string)
  }))
  description = "(Optional) Bindings to create for this roleset."
  default     = null
}

variable "path" {
  type = string
  default = "gcp"
  description = "(Required) The Vault path that the GCP secrets engine should be mounted to."
}