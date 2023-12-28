resource "google_compute_firewall" "rules" {
  project = var.project
  name    = var.name
  network = var.network # Replace with a reference or self link to your network, in quotes

  allow {
    protocol = var.protocol
    ports    = [var.ports]
  }
  source_ranges = [var.source_ranges]
}