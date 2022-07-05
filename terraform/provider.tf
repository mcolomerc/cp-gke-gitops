terraform {
  required_version = ">= 1.1.7"  
  experiments = [module_variable_optional_attrs]
  backend "gcs" {
    bucket = "mcolomer-tf-state" 
    prefix = "cp-tf-gke-state" 
  } 
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    } 
  }
} 
 
provider "google" {
  alias = "impersonate"

  scopes = [
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/userinfo.email",
  ]
}

data "google_service_account_access_token" "default" {
  provider               = google.impersonate
  target_service_account = var.tf_sa
  scopes                 = ["userinfo-email", "cloud-platform"]
  lifetime               = "3600s"
} 

provider "google" {
  project = var.project_id
  region  = var.region
  access_token    = data.google_service_account_access_token.default.access_token
  request_timeout = "60s"
}

provider "google-beta" {
  project = var.project_id
  region  = var.region

  access_token    = data.google_service_account_access_token.default.access_token
  request_timeout = "60s"
} 

