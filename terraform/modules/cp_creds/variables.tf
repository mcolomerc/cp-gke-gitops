
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

variable "namespace" {
  description = "The namespace to host the network in"
  type        = string
  default     = "confluent"
}

 
variable "bearers" {
  description = "The bearers to use"
  type        = map(string)
  default     = {
       "mds-client": "bearer.txt",
       "c3-mds-client": "c3-mds-client.txt",
       "connect-mds-client": "connect-mds-client.txt",
       "sr-mds-client": "sr-mds-client.txt",
       "ksqldb-mds-client": "ksqldb-mds-client.txt",
       "krp-mds-client": "krp-mds-client.txt", 
  } 
}

 