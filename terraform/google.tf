variable "GOOGLE_CLOUD_PROJECT" {}
variable "GOOGLE_CLOUD_REGION_DEFAULT" {}

provider "google" {
  project     = var.GOOGLE_CLOUD_PROJECT
  region      = var.GOOGLE_CLOUD_REGION_DEFAULT
}

resource "google_compute_network" "kubernetes-the-hard-way" {
  name = "kubernetes-the-hard-way"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "kubernetes" {
  name = "kubernetes"
  network = google_compute_network.kubernetes-the-hard-way.self_link
  ip_cidr_range = "10.240.0.0/24"
}

resource "google_compute_firewall" "kubernetes-the-hard-way-allow-internal" {
  name = "kubernetes-the-hard-way-allow-internal"
  network = google_compute_network.kubernetes-the-hard-way.self_link
  
  allow { protocol = "icmp" }
  allow { protocol = "tcp" }
  allow { protocol = "udp" }
}

resource "google_compute_firewall" "kubernetes-the-hard-way-allow-external" {
  name = "kubernetes-the-hard-way-allow-external"
  network = google_compute_network.kubernetes-the-hard-way.self_link
  allow { protocol = "icmp" }
  allow { 
    protocol = "tcp" 
    ports = [ "22","6443" ]
  }
}

resource "google_compute_address" "ip_address" {
  name = "kubernetes-the-hard-way"
}

data "google_compute_zones" "available" {}

data "google_compute_image" "ubuntu-1804-lts" {
  family = "ubuntu-minimal-1804-lts"
  project = "ubuntu-os-cloud"
}

resource "google_compute_instance" "controller" {
  count = 3
  name = "controller-${count.index}"
  zone = data.google_compute_zones.available.names[1]
  machine_type = "f1-micro"
  boot_disk {
    initialize_params {
      size = 200
      image = data.google_compute_image.ubuntu-1804-lts.self_link
    }
  }
  can_ip_forward = true
  network_interface {
    subnetwork = google_compute_subnetwork.kubernetes.self_link
    network_ip = "10.240.0.1${count.index}"
  }
  service_account {
    scopes = [ "compute-rw", "storage-ro", "service-management", "service-control", "logging-write", "monitoring"  ]
  }
  tags = [ "kubernetes-the-hard-way", "controller"  ]
}

resource "google_compute_instance" "worker" {
  count = 3
  name = "worker-${count.index}"
  zone = data.google_compute_zones.available.names[1]
  machine_type = "n1-standard-1"
  boot_disk {
    initialize_params {
      size = 200
      image = data.google_compute_image.ubuntu-1804-lts.self_link
    }
  }
  can_ip_forward = true
  network_interface {  
    subnetwork = google_compute_subnetwork.kubernetes.self_link
    network_ip = "10.240.0.2${count.index}"
  }
  service_account {
    scopes = [ "compute-rw", "storage-ro", "service-management", "service-control", "logging-write", "monitoring"  ]
  }
  metadata = { pod-cidr = "10.200.${count.index}.0/24" }
  tags = [ "kubernetes-the-hard-way", "worker"  ]
}

