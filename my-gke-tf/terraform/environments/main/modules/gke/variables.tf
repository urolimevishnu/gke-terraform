variable "cluster_name" {
  type        = string
  description = "The name of the cluster, unique within the project and location."
}

variable "region" {
  type        = string
  description = "The location (region or zone) in which the cluster master will be created, as well as the default node location. If you specify a zone (such as us-central1-a), the cluster will be a zonal cluster with a single cluster master. If you specify a region (such as us-west1), the cluster will be a regional cluster with multiple masters spread across zones in the region, and with default node locations in those zones as well"
}

variable "project" {
  type        = string
  description = " gcp project Id"
}

variable "network" {
  type        = string
  description = "The name or self_link of the Google Compute Engine network to which the cluster is connected. For Shared VPC, set this to the self link of the shared network."
}

variable "subnetwork" {
  type        = string
  description = "The name or self_link of the Google Compute Engine subnetwork in which the cluster's instances are launched."
}

variable "k8s_version" {
  type        = string
  description = "kubernetes version"
  default     = "1.28"
}

variable "node_count" {
  description = "The number of nodes in the GKE cluster"
  type = number
}

variable "machine_type" {
  description = "The machine type of the GKE cluster nodes"
  type = string
}

variable "disk_size_gb" {
  description = "The size of disk"
  type =number
}


variable "node_pool_name" {
  description = "The name of the node pool in the GKE cluster"
  type = string
}
