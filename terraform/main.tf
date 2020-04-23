provider "helm" {
  kubernetes {
    config_path = var.kube_config
  }
}

data "helm_repository" "banzaicloud_stable" {
  name = "banzaicloud-stable"
  url = "https://kubernetes-charts.banzaicloud.com"
}

resource "kubernetes_namespace" "vault_operator_namespace" {
  metadata {
    name = var.vault_operator_namespace
    labels = {
      name = var.vault_operator_namespace
    }
  }
}

resource "kubernetes_namespace" "vault_namespace" {
  metadata {
    name = var.vault_namespace
  }
}

resource "helm_release" "vault_operator" {
  name       = var.vault_operator_name
  namespace  = var.vault_operator_namespace
  repository = data.helm_repository.banzaicloud_stable.metadata[0].name
  chart      = "vault-operator"
  version    = "1.1.0"
  
  set {
    name = "fullnameOverride"
    value = var.vault_operator_name
  }
  depends_on = [
    kubernetes_namespace.vault_operator_namespace,
  ]
}

resource "helm_release" "vault" {
  name       = var.vault_name
  namespace  = var.vault_namespace
  chart      = "../charts/vault"
  depends_on = [
    helm_release.vault_operator,kubernetes_namespace.vault_namespace,
  ]
}

resource "helm_release" "vault_secrets_webhook" {
  name       = var.vault_secrets_webhook_name
  namespace  = var.vault_operator_namespace
  repository = data.helm_repository.banzaicloud_stable.metadata[0].name
  chart      = "vault-secrets-webhook"
  version    = "1.1.0"
  
  set {
    name = "fullnameOverride"
    value = var.vault_secrets_webhook_name
  }
  depends_on = [
    helm_release.vault,
  ]
}