locals {
  zone = "${var.region}-b"
}
# invoking vpc and subnets modules
module "vpc_with_subnets" {
  # invoke vpc_and_subnets module under modules directory
  source = "../modules/vpc_and_subnets"

  # create vpc and subnet with the same name as cluster name
  vpc_name    = var.cluster_name
  project     = var.project
  subnet_name = var.cluster_name

  # region where the resources need to be created
  region = var.region

  cidrBlock = var.cidrBlock
}

# invoking gke module to create gke cluster and node group
module "gke_with_node_group" {
  # invoke gke module under modules directory
  source = "../modules/gke"

  cluster_name = var.cluster_name
  k8s_version  = var.k8s_version
  region       = var.region
  project      = var.project
  node_count = var.node_count
  machine_type = var.machine_type
  disk_size_gb = var.disk_size_gb
  node_pool_name = var.node_pool_name
  network      = module.vpc_with_subnets.vpc_self_link
  subnetwork   = module.vpc_with_subnets.subnet_self_link
}

module "instance" {
  source       = "../modules/Instance" 
  instance     = var.instance
  region       = var.region
  machine_type = var.machine_type
  zone         = local.zone
  image        = var.image
  network      = module.vpc_with_subnets.vpc_self_link
  subnetwork   = module.vpc_with_subnets.subnet_self_link
}

module "firewall" {
  source       = "../modules/firewall"
  project      = var.project  
  name         = var.name
  network      = module.vpc_with_subnets.vpc_self_link
  protocol     = var.protocol
  ports        = var.ports
  source_ranges = var.source_ranges
}