###Recursos do GCP### 
# Cria uma VM no Google Cloud
resource "google_compute_instance" "firstvm" {
  name         = "website"
  machine_type = "n1-standard-1"
  zone         = var.gcp_zone
  tags         = ["website", "impacta"]
  
  # Define a Imagem da VM
  boot_disk {
    initialize_params {
      image = "ubuntu-1804-bionic-v20201014"
    }
  }

  # Habilita rede para a VM com um IP público
  network_interface {
    network = "default" # Estamos usando a VPC default que já vem por padrão no projeto.

    access_config {
      // A presença do bloco access_config, mesmo sem argumentos, garante que a instância estará acessível pela internet.
    }
  }
}
