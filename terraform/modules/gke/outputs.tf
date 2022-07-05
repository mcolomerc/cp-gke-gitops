output "cluster_name" {
    value = google_container_cluster.cp_gke.name
}  

output "cluster_endpoint" {
  value = "${google_container_cluster.cp_gke.endpoint}"
}

output "client_certificate" {
   value = "${base64decode(google_container_cluster.cp_gke.master_auth.0.client_certificate)}"
}

output "client_key" {
   value = "${base64decode(google_container_cluster.cp_gke.master_auth.0.client_key)}"
}

output "cluster_ca_certificate" {
   value = "${base64decode(google_container_cluster.cp_gke.master_auth.0.cluster_ca_certificate)}"
} 