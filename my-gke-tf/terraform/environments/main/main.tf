# to use s3 backend 
# s3 bucket is configured at command line
terraform {
  backend "gcs" {
    bucket = "gcp-argo-bucket"
    prefix = "tfstate"
    credentials = "cred.json"
  }
}

# setup google provider
# the environment variables below will be set before invoking the module
#GOOGLE_CREDENTIALS = "cred.json"
# GOOGLE_PROJECT - google project id where the resources need to be created
terraform {
  required_version = ">= 0.15.0"
}
provider "google" {
  region      = var.region
  project     = var.project
  credentials = file("cred.json")
}

# invoke cluster module which creates vpc, subnet and gke cluter with a default worker nodepool
module "cluster" {
  source = "./cluster"

  region       = var.region
  project      = var.project
  cluster_name = var.cluster_name
  k8s_version  = var.k8s_version
  node_count = var.node_count
  machine_type = var.machine_type
  disk_size_gb = var.disk_size_gb
  node_pool_name = var.node_pool_name
  instance     = var.instance
  image        = var.image
  name         = var.name
  protocol     = var.protocol
  ports        = var.ports
  source_ranges = var.source_ranges
}
