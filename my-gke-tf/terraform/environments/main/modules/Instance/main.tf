locals {
  zone = "${var.region}-b"
}

resource "google_compute_instance" "jump_host" {
  name         = var.instance
  machine_type = var.machine_type
  zone         = local.zone
 
  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = var.network
    subnetwork = var.subnetwork
    access_config {
    }
  }
}