
// *****************************************************************************
// GKE
resource "google_container_cluster" "cp_gke" {
  name               = "${var.resource_prefix}-cp-gke"
  location           = var.zone
  initial_node_count = var.nodes // 3
  network            = var.network
  subnetwork         = var.subnetwork
  // default_max_pods_per_node = 110  # Cannot set max pods constraint on cluster for route-based clusters

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  addons_config {
    http_load_balancing {
      disabled = true
    }
    horizontal_pod_autoscaling {
      disabled = true
    }
    network_policy_config {
      disabled = false
    }
  }

  node_config {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = var.tf_sa
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/trace.append"
    ]
    labels = {
      node = "${var.resource_prefix}"
    }
    tags         = ["${var.resource_prefix}"]
    machine_type = var.machine_type
    image_type   = var.image_type
    disk_type    = var.disk_type
    disk_size_gb = var.disk_size
    metadata = {
      disable-legacy-endpoints = true
    }
  }
  timeouts {
    create = "30m"
    update = "40m"
  }

}
// *****************************************************************************
data "google_client_config" "current" {}

provider "kubernetes" {
  host                   = "https://${google_container_cluster.cp_gke.endpoint}"
  token                  = data.google_client_config.current.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.cp_gke.master_auth.0.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = "https://${google_container_cluster.cp_gke.endpoint}"
    token                  = data.google_client_config.current.access_token
    client_certificate     = base64decode(google_container_cluster.cp_gke.master_auth.0.client_certificate)
    client_key             = base64decode(google_container_cluster.cp_gke.master_auth.0.client_key)
    cluster_ca_certificate = base64decode(google_container_cluster.cp_gke.master_auth.0.cluster_ca_certificate)
  }
}

provider "kubectl" {
  host                   = "https://${google_container_cluster.cp_gke.endpoint}"
  token                  = data.google_client_config.current.access_token
  load_config_file       = false
  cluster_ca_certificate = base64decode(google_container_cluster.cp_gke.master_auth.0.cluster_ca_certificate)
}

 
 
 