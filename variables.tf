variable "credentials_file" {
  description = "TF_VAR = Path to the service account key file in JSON format"
  type        = string
}
variable "project_id" {
  description = "TF_VAR = The ID of the project"
  type        = string
}
variable "region" {
  description = "Default project region"
  default     = "europe-west4"
}
variable "zone" {
  description = "Default project zone"
  default     = "europe-west4-b"
}
variable "static_ip" {
  description = "This is static_ip setings for instances(name and region)"
  type = list(object({
    name   = string
    region = string
  }))
}
variable "network_tier" {
  description = "The networking tier used for configuring this address."
  default     = "STANDARD"
}
variable "dns_record" {
  description = "The DNS name for instances"
  type = list(object({
    name = string
  }))
}
variable "dns_name" {
  description = "The DNS name of the project"
  type        = string
}
variable "dns_type" {
  description = "The DNS record set type"
  default     = "A"
}
variable "dns_ttl" {
  description = "TThe time-to-live of this record set (seconds)"
  default     = 300
}
variable "dns_zone_name" {
  description = "The name of the zone in which this record set will reside"
  type        = string
}
variable "default_disk" {
  description = "This is default disk setings for instances (his name and zone)"
  type = list(object({
    name = string
    zone = string
  }))
}
variable "disk_type" {
  description = "URL of the disk type resource describing which disk type to use to create the disk(pd-standard or pd-ssd)"
  default     = "pd-standard"
}
variable "disk_image" {
  description = " The image from which to initialize this disk"
  default     = "ubuntu-os-cloud/ubuntu-1804-lts"
}
variable "disk_size" {
  description = "Size of the persistent disk, specified in GB"
  default     = 25
}
variable "firewall_name" {
  description = "Name for firewall rule"
  default     = "web-firewall"
}
variable "firewall_web" {
  description = "Firewall tag name for icmp and tcp[80,443] protocols"
  default     = "web"
}
variable "network_name" {
  description = "The default zone to manage resources in"
  default     = "default"
}

variable "cluster_name" {
  description = "The name of the cluster, unique within the project and location."
  default     = "demo"
}
variable "cluster_location" {
  description = "The location (region or zone) in which the cluster master will be created, as well as the default node location."
  default     = "us-central1-a"
}
variable "initial_node_count" {
  description = "The number of nodes to create in this cluster's default node pool."
  default     = 1
}
variable "remove_default_node_pool" {
  description = "If true, deletes the default node pool upon cluster creation."
  default     = true
}
variable "client_certificate" {
  description = "Whether client certificate authorization is enabled for this cluster"
  default     = false
}
variable "node_count" {
  description = "The number of nodes to create in this cluster's"
  default     = 4
}
variable "node_name" {
  description = "The name of the node pool. If left blank, Terraform will auto-generate a unique name."
  default     = "my-node-pool"
}
variable "preemptible" {
  description = "A boolean that represents whether or not the underlying node VMs are preemptible."
  default     = true
}
variable "node_machine_type" {
  description = "The name of a Google Compute Engine machine type. Defaults to n1-standard-1."
  default     = "n1-standard-1"
}
variable "legacy_endpoints" {
  description = "From GKE 1.12 onwards, disable-legacy-endpoints is set to true by the API"
  default     = "true"
}
variable "instance" {
  description = "A unique name for the resource and zone that the machine should be created in"
  type = list(object({
    name = string
    zone = string
  }))
}
variable "machine_type" {
  description = "The machine type to create"
  default     = "n1-standard-2"
}
variable "connection_type" {
  description = "The connection type that should be used. Valid types are ssh and winrm"
  default     = "ssh"
}
variable "agent_ssh" {
  description = "Using ssh-agent or not"
  default     = "false"
}
variable "user_name" {
  description = "TF_VAR = The user that we should use for the SSH connection"
  type        = string
}
variable "p_key" {
  description = "TF_VAR = The path of an SSH key to use for the connection"
  type        = string
}
variable "home_dir" {
  description = "TF_VAR = Home user directory on tf machine"
  type        = string
}
variable "ansible_vault_key" {
  description = " TF_VAR = Path to the ansible vault key file."
  type        = string
}
