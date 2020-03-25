# Google Cloud Platform Project Demo4

# Using

## 1 Deploy infrastructure:

- Install terraform v0.12.20 on your machine.
- Clone terraform [project][terraform-host] on your work machine
- Export environment variables from the table:
  - Write your variables to a ./scripts/export.sh file.
  - run `$ chmod u+x export.sh`
  - run `$ source export.sh`
- Change directory to the directory with main.tf file.
- run `$ terraform init`
- run `$ terraform apply`

## 2 Make deploy jenkins and gitlab server:

- Go to terraform-ansible
- Switch user(if needed) on `TF_VAR_user_name`
- Change directory to the `TF_VAR_home_dir/ansible-roles`([full documentation][ansible-roles])
- You need to change the `id_rsa` key to your private key
- run `$ ansible-vault decrypt id_rsa --vault-password-file $TF_VAR_ansible_vault_key`
- run `$ ansible-playbook playbook --vault-password-file $TF_VAR_ansible_vault_key`
After full deployment, pipeline are automatically launched. Pipeline build and deploys the Microservices Infrastructure ([full documentation][jenkins] and [about Microservice Application][microservice-application]),


## Compatibility

This project is meant for use with Terraform v0.12.20 and Google provider v3.8.0
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Example |
|------|-------------|:----:|
| GOOGLE\_APPLICATION\_CREDENTIALS | Path to the service account key file in JSON format. | string | "/home/Maksym/file.json" |
| GOOGLE\_PROJECT | The ID of the project | string | "myproject-123456" |
| TF\_VAR\_user\_name | The user that we should use for the SSH connection. | string | "Maksym" |
| TF\_VAR\_p\_key | The path of an SSH key to use for the connection. | string | ".ssh/id_key" |
| TF\_VAR\_home\_dir | Home user directory. | string | "/home/Maksym" |
| TF\_VAR\_ansible\_vault\_key | Name to the ansible vault key file. | string | "vault_key.txt" |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

These sections describe requirements for using this file.

### Software

The following dependencies must be available:

- [Terraform][terraform] v0.12.20
- [Terraform Provider for GCP][terraform-provider-gcp] plugin = v3.8.0

### IAM
In order to execute this module you must have a Service Account with the
following roles:


Service account or user credentials with the following roles must be used to provision the resources of this module:

- Compute Admin: `roles/compute.admin`
- Compute Network Admin: `roles/compute.networkAdmin`
- DNS Administrator: `roles/dns.admin`
- For backend:
  - Storage Admin: `roles/storage.admin`
- For cluster:  
  - Kubernetes Engine Cluster: `roles/container.clusterAdmin`
  - Service Account User: `roles/iam.serviceAccountUser`

[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html
[terraform-host]: https://github.com/DanJake/demo4_tf.git
[ansible-roles]: https://gitlab.sxvova.opensource-ukraine.org/root/ansible-roles.git
[jenkins]: https://gitlab.sxvova.opensource-ukraine.org/root/jenkins-demo4
[microservice-application]: https://gitlab.sxvova.opensource-ukraine.org/root/microservices-demo
