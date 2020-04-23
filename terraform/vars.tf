variable "kube_config" {
    default = "~/.kube/config"
}
variable "vault_operator_namespace" {
    default = "vault-infra"
}

variable "vault_operator_name" {
    default = "bank-vaults"
}

variable "vault_name" {
    default = "vault-test"
}
variable "vault_namespace" {
    default = "vault-test"
}
variable "vault_secrets_webhook_name" {
    default = "vault-secrets-webhook"
}