### GCP
variable "gcp_project" {
  type        = string
  description = "Projeto do GCP"
}

variable "gcp_region" {
  type        = string
  description = "Região do GCP"
  default     = "us-central1"
}

variable "gcp_zone" {
  type        = string
  description = "Zona no GCP"
  default     = "us-central1-c"
}

### AZURE

variable "rg_location" {
  type        = string
  description = "Definindo a Região do Azure"
  default     = "East US"
}
variable "azurevm_admin_pass" {
  type        = string
  description = "Senha Usuario Admin do Linux"
}

### CLOUDFLARE

#Cloudflare email
variable "cloudflare_email" {
  type = string
  description = "Cloudflare Email Address"
}

#Cloudflare API chave
variable "cloudflare_api_key" {
  type = string
  description = "Cloudflare API Key"
}

#Cloudflare zone id
variable "cloudflare_zone_id" {
  type = string
  description = "Cloudflare Zone ID"
}

#Cloudflare Record Name
variable "cloudflare_record" {
  type = string
  description = "Cloudflare Record Name"
}
