variable "tf_sa" {
  default     = "<terraform-sa>@<project_id>.iam.gserviceaccount.com"
  type        = string
  description = "The service account to use for Terraform"
}
variable "project_id" {
  description = "The project ID to host the network in"
}

variable "region" {
  description = "The region to host the network in"
  type        = string
  default     = "europe-west2"
}

variable "zone" {
  description = "The zone to host the network in"
  type        = string
  default     = "europe-west2-c"
}

variable "resource_prefix" {
  description = "The prefix to use for all resources created by this module"
  type        = string
  default     = "iac-"
}

// NETWORK
variable "network_name" {
  description = "The name of the VPC network being created"
  type        = string
  default     = "-vpc"
}

variable "ip_cidr_range" {
  description = "CIDR of the subnet"
  type        = string
  default     = "10.10.0.0/16"
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
  default     = ""
}

//GKE 
variable "nodes" {
  description = "The number of nodes to create"
  type        = string
  default     = 3
}

variable "machine_type" {
  description = "The machine type to use"
  type        = string
  default     = "n1-highmem-2"
}

variable "image_type" {
  description = "The image type to use"
  type        = string
  default     = "COS"
}

variable "disk_type" {
  description = "The disk type to use"
  type        = string
  default     = "pd-standard"
}

variable "disk_size" {
  description = "The disk size to use"
  type        = number
  default     = 100
}

// OPERATOR 
variable "namespace" {
  description = "The namespace used by the Confluent operator"
  type        = string
  default     = "confluent"
}
 