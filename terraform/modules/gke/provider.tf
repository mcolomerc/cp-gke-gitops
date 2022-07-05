terraform {
  required_version = ">= 1.1.7"  
  experiments = [module_variable_optional_attrs]
  
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
    http = {
      source = "hashicorp/http"
      version = "2.2.0"
    }
  }
}
