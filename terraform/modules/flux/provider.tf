terraform {
  required_version = ">= 0.13"

  required_providers {
    github = {
      source  = "integrations/github"
      version = ">= 4.5.2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.2"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.10.0"
    }
    flux = {
      source  = "fluxcd/flux"
      version = ">= 0.0.13"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.1.0"
    }

  }
}
 

# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest/submodules/auth
module "gke_auth" {
  source               = "terraform-google-modules/kubernetes-engine/google//modules/auth"
  project_id           = var.project_id
  cluster_name         = var.cluster_name
  location             = var.cluster_region
  use_private_endpoint = var.use_private_endpoint
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

provider "github" {
  owner = var.github_owner
  # token = var.github_token
}
