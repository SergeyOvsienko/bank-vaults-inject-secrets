# This is demo deploy Bank-Vaults operator with mutating webhook for injecting secrets.
# Not for production !!!

## Read [more](https://banzaicloud.com/blog/inject-secrets-into-pods-vault-revisited/)

### How to use

```sh
1. Fork this git repository
2. git clone git@github.com:{{user_name}}/bank-vaults-inject-secrets.git
3. cd bank-vaults-inject-secrets/terraform
4. terraform init && terraform apply
```