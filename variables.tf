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
