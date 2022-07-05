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

variable "network_name" {
  description = "The name of the VPC network being created"
  type        = string
  default     = "-vpc"
}

variable "resource_prefix" {
  description = "The prefix to use for all resources created by this module"
  type        = string
  default     = "iac-"
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

 