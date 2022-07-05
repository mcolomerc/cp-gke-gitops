variable "project_id" {
  description = "The project ID to host the network in"
}

variable "cluster_endpoint" {
  description = "The cluster endpoint"
  type        = string
}

variable "client_certificate" {
  description = "The client certificate to use"
  type        = string
}

variable "client_key" {
  description = "The client key to use"
  type        = string
}

variable "cluster_ca_certificate" {
  description = "The cluster ca certificate to use"
  type        = string
}

variable "github_owner" {
  description = "The github owner to use"
  type        = string
}
variable "repository_name" {
  description = "The github repository name to use"
  type        = string
}

variable "repository_visibility" {
  description = "The github repository visibility to use"
  type        = string
}

variable "branch" {
  description = "The github branch to use"
  type        = string
}

variable "target_path" {
  description = "The target path to use"
  type        = string
}

variable "flux_namespace" {
  type        = string
  default     = "flux-system"
  description = "the flux namespace"
}

variable "cluster_name" {
  type        = string
  description = "cluster name"
}

variable "cluster_region" {
  type        = string
  description = "cluster region"
}

variable "use_private_endpoint" {
  type        = bool
  description = "Connect on the private GKE cluster endpoint"
  default     = false
}

variable "github_deploy_key_title" {
  type        = string
  description = "Name of github deploy key"
}