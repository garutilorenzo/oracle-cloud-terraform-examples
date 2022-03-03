# Examples

In this folder there are two examples:

* main.tf - Use a private subnet with a nat instance, all services are deployed on the pivate subnet. (Default example)
* main.tf-public - Use a public subnet, all the services are deployed in the public subnet. (Disabled example)

If you want to use the public example, rename the *main.tf-public* in *main.tf*. Keep **ONLY ONE** *.tf file.

Now adjust all the *change-me* variables inside the main.tf file. Once you have setup your environment, we are ready to init terraform:

```
Initializing modules...

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of hashicorp/oci from the dependency lock file
- Reusing previous version of hashicorp/template from the dependency lock file
- Using previously-installed hashicorp/oci v4.65.0
- Using previously-installed hashicorp/template v2.2.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

### Deploy

We are now ready to deploy our infrastructure. First we ask terraform to plan the execution with:

```
terraform plan
```

now we can deploy our resources with:

```
terraform apply
```

### Connect to private instances

We can connect to the private instances using the nat instance as Jump server:

```
ssh -J bastion@<NAT_INSTANCE_PUBLIC_IP> ubuntu@<INSTANCE_PRIVATE_IP>
```

### Start a project from scratch

If you want to create a new project from scratch you need three files:

* terraform.tfvars - More details in [Oracle provider setup](../README.md#oracle-provider-setup)
* main.tf - download main.tf file or main.tf-public based on your needs. If you choose main.tf-public **remember** to rename the file in main.tf
* provider.tf - download the file from this directory