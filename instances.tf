resource "google_compute_instance" "mg_instance" {
  name         = "marys-instance"
  machine_type = "g1-small"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
      size = 15
    }
  }
  network_interface {
    network = "${google_compute_network.vpc_network.self_link}"
    access_config = {}
  }
  tags = ["ssh"]
}