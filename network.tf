resource "google_compute_network" "vpc_network" {
  name = "testing-projects"
  routing_mode = "REGIONAL"
}

resource "google_compute_subnetwork" "subnet_1" {
  name          = "subnet-1"
  ip_cidr_range = "172.17.0.0/24"
  region        = "us-central1"
  network       = "${google_compute_network.vpc_network.self_link}"
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "subnet_2" {
  name          = "subnet-2"
  ip_cidr_range = "172.17.1.0/24"
  region        = "us-central1"
  network       = "${google_compute_network.vpc_network.self_link}"
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "subnet_3" {
  name          = "subnet-3"
  ip_cidr_range = "172.17.2.0/24"
  region        = "us-central1"
  network       = "${google_compute_network.vpc_network.self_link}"
  private_ip_google_access = true
}

resource "google_compute_router" "router" {
    name = "mg-router"
    region = "us-central1"
    network = "${google_compute_network.vpc_network.self_link}"
}

resource "google_compute_router_nat" "nat" {
    name                               = "mary-router-nat"
    router                             = "${google_compute_router.router.name}"
    region                             = "${google_compute_router.router.region}"
    nat_ip_allocate_option             = "AUTO_ONLY"
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

resource "google_compute_firewall" "ssh" {
  name    = "marys-firewall"
  network = "${google_compute_network.vpc_network.name}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["ssh"]
}