# TF SA 
 tf_sa = "mcolomer-cp-tf-sa@solutionsarchitect-01.iam.gserviceaccount.com"
# Variables for the project
project_id = "solutionsarchitect-01"
region = "europe-west1"
zone = "europe-west1-c"
resource_prefix="mcolomer"

#Network 
network_name = "mcolomer-vpc" 
ip_cidr_range = "10.10.0.0/16" # CIDR range for the VPC
subnet_name = "mcolomer-subnet"

# Kubernetes cluster - GKE
nodes= 5
machine_type = "n1-highmem-2"
image_type = "COS"
disk_size = 300
disk_type = "pd-standard" 

# CFK Operator namespace  
namespace="confluent"
 