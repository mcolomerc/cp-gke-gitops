data "google_client_config" "current" {}

resource "kubernetes_namespace" "ns" {
  metadata {
    name = var.namespace
  }

  lifecycle {
    ignore_changes = [
      metadata[0].labels,
    ]
  }
}


resource "kubernetes_secret" "credential" {
  metadata {
    name      = "credential"
    namespace = var.namespace
  }
  data = {
    "plain-users.json"  = file("${path.module}/creds/creds-kafka-sasl-users.json")
    "digest-users.json" = file("${path.module}/creds/creds-zookeeper-sasl-digest-users.json")
    "digest.txt"        = file("${path.module}/creds/creds-kafka-zookeeper-credentials.txt")
    "plain.txt"         = file("${path.module}/creds/creds-client-kafka-sasl-user.txt")
    "basic.txt"         = file("${path.module}/creds/creds-control-center-users.txt")
    "ldap.txt"          = file("${path.module}/creds/ldap.txt")
  } 
}
resource "kubernetes_secret" "mds-token" {
  metadata {
    name      = "mds-token"
    namespace = var.namespace
  }
  data = {
    "mdsPublicKey.pem"    = file("${path.module}/creds/mds-publickey.txt")
    "mdsTokenKeyPair.pem" = file("${path.module}/creds/mds-tokenkeypair.txt")
  }
  
}

resource "kubernetes_secret" "bearers" {
  for_each = var.bearers
  metadata {
    name      = each.key
    namespace = var.namespace
  }
  data = {
    "bearer.txt" = file("${path.module}/bearers/${each.value}")
  }
 
}

resource "kubernetes_secret" "rest-credential" {
  metadata {
    name      = "rest-credential"
    namespace = var.namespace
  }
  data = {
    "bearer.txt" = file("${path.module}/bearers/bearer.txt")
    "basic.txt"  = file("${path.module}/bearers/bearer.txt")
  } 
}