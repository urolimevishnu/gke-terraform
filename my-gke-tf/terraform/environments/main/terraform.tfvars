# gcp region
region = "us-east1"
project = "test-argo-poc"

# gke cluster name, this is the same name used to create the vpc and subnet
# hence this name must be unique
cluster_name = "argo-cd-cluster"
node_count = "1"
machine_type = "e2-medium"
node_pool_name = "cluster-nodepool"
disk_size_gb =  "10"

#instance 
instance = "jump-host"
image    = "ubuntu-os-cloud/ubuntu-2204-lts"

#firewall
name      = "allow-ssh"
protocol      = "tcp"
ports         = "22"
source_ranges = "0.0.0.0/0"