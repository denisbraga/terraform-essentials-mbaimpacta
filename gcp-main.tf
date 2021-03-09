#### RECURSOS NO GCP #####

# Define bootstrap file
data "template_file" "apache_script" {
    template = file("gcp-user-data.sh")
}

# Cria uma VM no Google Cloud
resource "google_compute_instance" "firstvm" {
  name         = "website"
  machine_type = "n1-standard-1"
  zone         = var.gcp_zone
  tags         = ["website", "impacta", "http-server", "https-server"]

  # Defini a Imagem da VM
  boot_disk {
    initialize_params {
      image = "ubuntu-1804-bionic-v20201014"
    }
  }

  metadata_startup_script = data.template_file.apache_script.rendered

  # Habilita rede para a VM com um IP público
  network_interface {
    network = "default" # Estamos usando a VPC default que já vem por padrão no projeto.

    access_config {
    }
    // A presença do bloco access_config, mesmo sem argumentos, garante que a instância estará acessível pela internet.
  }
}