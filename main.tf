provider "google" {
  region      = var.region
  zone        = var.zone
}
# ----------Static IP-----------------------
resource "google_compute_address" "static-ip-address" {
  count        = length(var.static_ip)
  name         = var.static_ip[count.index].name
  region       = var.static_ip[count.index].region
  network_tier = var.network_tier
}
# -----------------Dns records--------------
resource "google_dns_record_set" "dnsrecord" {
  count        = length(var.dns_record)
  name         = "${var.dns_record[count.index].name}.${var.dns_name}"
  type         = var.dns_type
  ttl          = var.dns_ttl
  managed_zone = var.dns_zone_name
  rrdatas      = [element(google_compute_address.static-ip-address.*.address, count.index)]
}
resource "google_compute_disk" "def_disk" {
  count = length(var.default_disk)
  name  = var.default_disk[count.index].name
  type  = var.disk_type
  image = var.disk_image
  zone  = var.default_disk[count.index].zone
  size  = var.disk_size
}
#-------------------Firewall------------------
resource "google_compute_firewall" "default" {
  name    = var.firewall_name
  network = var.network_name

  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web"]
}

# -------------------------Cluster ---------------
resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.cluster_location

  remove_default_node_pool = var.remove_default_node_pool
  initial_node_count       = var.initial_node_count

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = var.client_certificate
    }
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = var.node_name
  location   = var.cluster_location
  cluster    = google_container_cluster.primary.name
  node_count = var.node_count

  node_config {
    preemptible  = var.preemptible
    machine_type = var.node_machine_type
    metadata = {
      disable-legacy-endpoints = var.legacy_endpoints
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
# -------------------------Jenkins Instances ---------------
resource "google_compute_instance" "Jenkins" {

  name         = var.instance[0].name
  machine_type = var.machine_type
  zone         = var.instance[0].zone
  tags         = [var.firewall_web]

  boot_disk {
    source = element(google_compute_disk.def_disk.*.name, 0)
  }
  network_interface {
    network = var.network_name
    access_config {
      nat_ip       = element(google_compute_address.static-ip-address.*.address, 0)
      network_tier = var.network_tier
    }
  }
  metadata = {
    ssh-keys = "${var.user_name}:${file("./files/id_rsa.pub")}"
  }
  metadata_startup_script = "apt install -y python"
}
#-------------------Ansible instance------------------
resource "google_compute_instance" "ansible" {
  name         = var.instance[1].name
  machine_type = var.machine_type
  zone         = var.instance[1].zone

  boot_disk {
    source = element(google_compute_disk.def_disk.*.name, 1)
  }
  network_interface {
    network = var.network_name
    access_config {
      network_tier = var.network_tier
      nat_ip       = element(google_compute_address.static-ip-address.*.address, 1)
    }
  }
  metadata = {
    ssh-keys = "${var.user_name}:${file("~/.ssh/id_rsa.pub")}"
  }

  provisioner "file" {
    source      = "~/.ssh/${var.ansible_vault_key}"
    destination = "~/${var.ansible_vault_key}"

    connection {
      type        = var.connection_type
      user        = var.user_name
      private_key = file("${var.home_dir}/${var.p_key}")
      agent       = var.agent_ssh
      host        = element(google_compute_address.static-ip-address.*.address, 1)
    }
  }
  provisioner "file" {
    source      = "./scripts/installansible.sh"
    destination = "installansible.sh"

    connection {
      type        = var.connection_type
      user        = var.user_name
      private_key = file("${var.home_dir}/${var.p_key}")
      agent       = var.agent_ssh
      host        = element(google_compute_address.static-ip-address.*.address, 1)
    }
  }
  metadata_startup_script = "chmod u+x ${var.home_dir}/installansible.sh && ${var.home_dir}/./installansible.sh"
}
