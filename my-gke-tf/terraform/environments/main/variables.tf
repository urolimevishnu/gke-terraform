variable "region" {
  type        = string
  description = "gcp region where the resources are being created"
}

variable "cluster_name" {
  type        = string
  description = "gke cluster name, same name is used for vpc and subnets"
  default     = "platformwale"
}

variable "project" {
  type        = string
  description = " gcp project Id"
}

variable "k8s_version" {
  type        = string
  description = "k8s version"
  default     = "1.27"
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
