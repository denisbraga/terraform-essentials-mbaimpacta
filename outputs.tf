# Retorna o IP da VM criada
output "ip" {
  value = google_compute_instance.firstvm.network_interface.0.access_config.0.nat_ip
}