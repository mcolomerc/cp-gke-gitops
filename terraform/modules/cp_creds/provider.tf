terraform {
  required_version = ">= 0.13"

  required_providers {
    
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.2"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.10.0"
    }
     
  }
}

provider "kubernetes" {  
  host                   = "https://${var.cluster_endpoint}"
  token                  = "${data.google_client_config.current.access_token}" 
  cluster_ca_certificate = var.cluster_ca_certificate 
} 

provider "kubectl" {  
  host                   = "https://${var.cluster_endpoint}"
  token                  = "${data.google_client_config.current.access_token}"
  load_config_file       = false
  cluster_ca_certificate = var.cluster_ca_certificate 
}