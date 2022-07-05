
output "network" {
    value = module.network.network
}

output "subnetwork" {
    value = module.network.subnetwork
}

output "cidr" {
    value = module.network.cidr
}

output "gke" {
    value = module.gke.cluster_name
} 

 