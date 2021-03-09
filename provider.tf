#### SETUP GOOGLE ####
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.58.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.49.0"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "2.18.0"
    }
  }
}

# Configura o Provider Google Cloud com o Projeto
provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
  zone    = var.gcp_zone
}

# Configura o Provider Microsoft Azure
provider "azurerm" {
  features {}
}

# Configura o Provider CloudFlare
provider "cloudflare" {
  email   = var.cloudflare_email
  api_key = var.cloudflare_api_key
}