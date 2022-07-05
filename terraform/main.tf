
// NETWORK
module "network" { 
  source = "./modules/network" 
  project_id = var.project_id
  region = var.region
  zone = var.zone
  network_name = var.network_name
  resource_prefix = var.resource_prefix
  ip_cidr_range = var.ip_cidr_range
  subnet_name = var.subnet_name
}

//GKE 
module "gke" {
    source = "./modules/gke"
    tf_sa = var.tf_sa
    zone = var.zone
    nodes = var.nodes
    machine_type = var.machine_type
    image_type = var.image_type
    disk_type = var.disk_type
    disk_size = var.disk_size
    resource_prefix = var.resource_prefix
    network = module.network.network
    subnetwork = module.network.subnetwork 
}


//FLUX 
module "flux_setup" {
    source = "./modules/flux" 
    project_id = var.project_id
    cluster_endpoint = module.gke.cluster_endpoint
    client_certificate = module.gke.client_certificate
    client_key = module.gke.client_key
    cluster_ca_certificate = module.gke.cluster_ca_certificate
    github_owner = "mcolomerc"
    repository_name = "cp-gke-gitops" 
    repository_visibility="public" 
    branch="main" 
    target_path = "clusters/dev" 
    flux_namespace = "flux-system" 
    cluster_name = module.gke.cluster_name
    cluster_region = var.region
    use_private_endpoint = true
    github_deploy_key_title = "flux-token" 
}

