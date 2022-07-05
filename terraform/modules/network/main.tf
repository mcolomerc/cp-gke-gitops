
resource "google_compute_network" "vpc_network" {
  name = var.network_name
  auto_create_subnetworks = false
  routing_mode = "REGIONAL"
}

resource "google_compute_subnetwork" "subnetwork" {
  network        = google_compute_network.vpc_network.name
  project        = var.project_id  
  region         = var.region
  ip_cidr_range  = var.ip_cidr_range
  name           = var.subnet_name
  private_ip_google_access = true
}

