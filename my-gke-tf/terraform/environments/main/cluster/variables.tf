variable "cluster_name" {
  type        = string
  description = "vpc, subnet and gke cluster name"
}

variable "k8s_version" {
  type        = string
  description = "kubernetes version"
  default     = "1.27"
}

variable "region" {
  type        = string
  description = "gcp region where the gke cluster must be created, this region should match where you have created the vpc and subnet"
}

variable "project" {
  type        = string
  description = " gcp project Id"
}

variable "cidrBlock" {
  type        = string
  description = "The cidr block for subnet"
  default     = "10.1.0.0/16"
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

variable "instance" { }
variable "image" {}
variable "name" {}
variable "protocol" {}
variable "ports" {}
variable "source_ranges" {}

