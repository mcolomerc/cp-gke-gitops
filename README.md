# Confluent Patform on GKE with Terraform & Flux 

1. Deploy GCP VPC

* VPC

* Subnet

2. Deploy GKE cluster 

3. Deploy FluxCD 

  **Helm charts** :   

  * Ingress controller - [ingress-nginx](https://kubernetes.github.io/ingress-nginx)

      * Uses [nip.io](https://nip.io) to expose ingress controller

  * Prometheus operator - [prometheus-operator](https://prometheus-community.github.io/helm-charts)

      * [Prometheus](https://prometheus.io) 

      * [Grafana](https://grafana.com)

  * OpenLDAP - Custom Chart (./charts/openldap)

  * CFK operator - [confluent-for-kubernetes](https://packages.confluent.io/helm)

  * Cert Manager - [cert-manager](https://cert-manager.io)

  * Confluent Platform - Custom Chart (./charts/confluentplatform)
 

## Terraform and Google Cloud 

### Google Cloud configuration

```shell
export PROJECT_ID="solutionsarchitect-01"
gcloud config set project $PROJECT_ID
```

#### Service Accounts 

Terraform service account

```shell
export SA_TERRAFORM="mcolomer-cp-tf-sa"
gcloud iam service-accounts create $SA_TERRAFORM --display-name "Terraform Deployment account (mcolomer)" 
```

Terraform service account permissions:

```shell
gcloud projects add-iam-policy-binding ${PROJECT_ID} --member serviceAccount:$SA_TERRAFORM@$PROJECT_ID.iam.gserviceaccount.com --role roles/owner
```

Check service accounts: 

```shell
gcloud iam service-accounts list
```

#### Enable the impersonation core services

```shell 
gcloud auth application-default login
```

To be able to generate service tokens for the impersonated service accounts, the IAM credentials and the resource manager services must be enabled on the project. 
You can enable those services by running the below command:

```shell 
gcloud services enable iamcredentials.googleapis.com cloudresourcemanager.googleapis.com
```

To add an IAM policy binding for the role of 'roles/iam.serviceAccountTokenCreator' for the user 'test-user@gmail.com' on a service account with identifier '${SA_TERRAFORM}@${PROJECTID}.iam.gserviceaccount.com' more on: https://cloud.google.com/sdk/gcloud/reference/iam/service-accounts/add-iam-policy-binding

```shell
export USER="user:<user@email.com>" 
```

```shell 
gcloud iam service-accounts add-iam-policy-binding $SA_TERRAFORM@$PROJECT_ID.iam.gserviceaccount.com --member=$USER --role='roles/iam.serviceAccountTokenCreator'
```


### Flux & Github 

  * Flux - [flux](https://flux.io)

  * Github - [github](https://github.com)

Flux needs access to the github repository. 

```sh
 export GITHUB_TOKEN=<personal_access_token>
```

    github_owner = "mcolomerc"
    repository_name = "cp-gke-gitops" 
    repository_visibility="public" 
    branch="main" 
    target_path = "clusters/dev" 
    flux_namespace = "flux-system" 

### Terraform Deployment 

1) Create bucket for Terraform state:

```shell 
gsutil mb gs://<bucket_for_terraform_state>
``` 

2) Initialize Terraform: 
 
```shell 
terraform init
``` 

3) Build the Terraform plan:  

```sh
terraform plan -var-file="terraform.tfvars"
```

4) Terraform apply: 

```shell 
terraform apply -var-file="terraform.tfvars"
``` 
 

## Terraform TFVARs

* Terraform service account:

```
 tf_sa = "mcolomer-cp-tf-sa@solutionsarchitect-01.iam.gserviceaccount.com"
```
 
* Variables for the GCP project:

```
project_id = "solutionsarchitect-01" # GCP project ID
region = "europe-west1" # GCP region
zone = "europe-west1-c" # GCP zone 
 
network_name = "mcolomer-vpc"  # VPC name
ip_cidr_range = "10.10.0.0/16" # CIDR range for the VPC
subnet_name = "mcolomer-subnet" # Subnet name

resource_prefix="mcolomer" # Prefix for all resources
```

* Kubernetes cluster - GKE:

```
nodes= 5
machine_type = "n1-highmem-2"
image_type = "COS"
disk_size = 300
disk_type = "pd-standard" 
```

* CFK Operator namespace

```  
namespace="confluent"
```

 


 