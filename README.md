# Learning Terraform with AWS 

### Documentation: https://registry.terraform.io/namespaces/hashicorp

### Useful commands:

- `terraform fmt` command automatically updates configurations in the current directory for readability and consistency. 
- `terraform validate` Validate your configuration. The example configuration provided above is valid, so Terraform will return a success message.
- `terraform init` Initializing a configuration directory downloads and installs the providers defined in the configuration, which in this case is the aws provider.
- `terraform apply` Terraform will print output similar to what is shown below. We have truncated some of the output to save space.
- `terraform show` Inspect the current state using
- `terraform destroy` command terminates resources managed by your Terraform project. This command is the inverse of terraform apply