output "network" {
    value = google_compute_network.vpc_network.name
}

output "subnetwork" {
  value = google_compute_subnetwork.subnetwork.name
}

output "cidr" {
    value = google_compute_subnetwork.subnetwork.ip_cidr_range
}
 

