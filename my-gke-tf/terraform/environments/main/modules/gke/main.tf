# setup google terraform provider
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.74.0"
    }
  }
}

locals {

  zones = slice(data.google_compute_zones.available.names, 0, 3)

  # we only care about compute and container service here hence only enabling these project services
  # without cloudresourcemanager we get errors
  services = toset(["compute", "container", "cloudresourcemanager"])

  # we will pick the latest k8s version
  master_version = data.google_container_engine_versions.main.valid_master_versions[0]
}

# allows management of a single API service for a Google Cloud Platform project.
# official documentation - https://registry.terraform.io/providers/hashicorp/google/4.74.0/docs/resources/google_project_service
resource "google_project_service" "main" {
  for_each           = local.services
  project     = var.project
  service            = "${each.value}.googleapis.com"
  disable_on_destroy = false
}

# to extract the UP available compute zones for the provided region
# official documentation - https://registry.terraform.io/providers/hashicorp/google/4.74.0/docs/data-sources/compute_zones
data "google_compute_zones" "available" {
  region     = var.region
  project     = var.project
  status     = "UP"
  depends_on = [google_project_service.main]
}

# to retrieve the latest k8s version supported for the provided k8s version in a region
# official documentation - https://registry.terraform.io/providers/hashicorp/google/4.74.0/docs/data-sources/container_engine_versions
data "google_container_engine_versions" "main" {
  location = var.region
  project     = var.project

  # Since this is just a string match, it's recommended that you append a . after minor versions 
  # to ensure that prefixes such as 1.1 don't match versions like 1.12.5-gke.10 accidentally.
  version_prefix = "${var.k8s_version}."

  depends_on = [google_project_service.main]
}

# GKE cluster - https://registry.terraform.io/providers/hashicorp/google/4.74.0/docs/resources/container_cluster
resource "google_container_cluster" "gke" {
  name               = var.cluster_name
  location           = var.region
  project            = var.project
  min_master_version = local.master_version
  network    = var.network
  subnetwork = var.subnetwork
  
  # to prevent automatic updates to cluster
  release_channel {
    channel = "UNSPECIFIED"
  }

  node_pool {
    name       = var.node_pool_name
    node_count = var.node_count
    
    autoscaling {
      min_node_count = "0"
      max_node_count = "5"
    }

    management {
      auto_repair  = true
      auto_upgrade = false
    }

    node_config {
      machine_type = var.machine_type
      disk_size_gb = var.disk_size_gb
    }

  }
}
