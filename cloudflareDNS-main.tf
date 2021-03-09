#Cria uma entrada DNS para o Azure 
resource "cloudflare_record" "azure-dns" { 
  zone_id = var.cloudflare_zone_id 
  name = var.cloudflare_record 
  value = azurerm_public_ip.myterraformpublicip.ip_address
  type = "A" 
  proxied = true 
  depends_on = [azurerm_public_ip.myterraformpublicip] 
}

#Cria uma entrada DNS para o Google Cloud 
resource "cloudflare_record" "gcp-dns" { 
  zone_id = var.cloudflare_zone_id 
  name = var.cloudflare_record
  value = google_compute_instance.firstvm.network_interface.0.access_config.0.nat_ip 
  type = "A" 
  proxied = true 
  depends_on = [google_compute_instance.firstvm] 
}