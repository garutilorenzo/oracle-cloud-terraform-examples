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

...
...
...

      + source_details {
          + boot_volume_size_in_gbs = (known after apply)
          + kms_key_id              = (known after apply)
          + source_id               = "ocid1.image.oc1.REGION.aaaaaaaag2uyozo7266bmg26j5ixvi42jhaujso2pddpsigtib6vfnqy5f6q"
          + source_type             = "image"
        }
    }

Plan: 24 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + instance_ip            = (known after apply)
  + instance_pool_id       = (known after apply)
  + instance_pool_ips      = [
      + (known after apply),
      + (known after apply),
    ]
  + instance_pool_size     = 2
  + internal_lb_ip         = (known after apply)
  + lb_ip                  = (known after apply)
  + nat_instance_id        = (known after apply)
  + nat_instance_public_ip = (known after apply)
  + private_subnet_id      = (known after apply)
  + public_subnet_cidr     = "10.0.0.0/24"
  + public_subnet_id       = (known after apply)
  + security_list_id       = (known after apply)
  + vcn_id                 = (known after apply)

────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```

now we can deploy our resources with:

```
terraform apply

...
...
...

Plan: 24 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + instance_ip            = (known after apply)
  + instance_pool_id       = (known after apply)
  + instance_pool_ips      = [
      + (known after apply),
      + (known after apply),
    ]
  + instance_pool_size     = 2
  + internal_lb_ip         = (known after apply)
  + lb_ip                  = (known after apply)
  + nat_instance_id        = (known after apply)
  + nat_instance_public_ip = (known after apply)
  + private_subnet_id      = (known after apply)
  + public_subnet_cidr     = "10.0.0.0/24"
  + public_subnet_id       = (known after apply)
  + security_list_id       = (known after apply)
  + vcn_id                 = (known after apply)

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

...
...
...

Apply complete! Resources: 24 added, 0 changed, 0 destroyed.

Outputs:

instance_ip = "10..X.X.X"
instance_pool_id = "ocid1.instancepool.oc1.REGION.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
instance_pool_ips = [
  "10..X.X.X",
  "10..X.X.X",
]
instance_pool_size = 2
internal_lb_ip = tolist([
  {
    "ip_address" = "10..X.X.X"
    "ip_version" = "IPV4"
    "is_public" = false
    "reserved_ip" = tolist([])
  },
])
lb_ip = tolist([
  "144.X.X.X",
])
nat_instance_id = "ocid1.instance.oc1.REGION.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
nat_instance_public_ip = "152.X.X.X"
private_subnet_id = "ocid1.subnet.oc1.REGION.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
public_subnet_cidr = "10.0.0.0/24"
public_subnet_id = "ocid1.subnet.oc1.REGION.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
security_list_id = "ocid1.securitylist.oc1.REGION.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
vcn_id = "ocid1.vcn.oc1.REGION.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

```

### Resources test

#### Public LB Test

```
curl http://144.X.X.X

<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
<p><em>Hello from: inst-ikv6i-ubuntu-instance-pool</em></p>
</body>
</html>
```

#### Private LB Test

First we need to [connect](#connect-to-private-instances) via ssh on a private instance. **NOTE** we need to connect to the instance that is not part of the instance group.

Now we can call the public LB ip:

```
curl http://10.X.X.X

<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
<p><em>Hello from: inst-ikv6i-ubuntu-instance-pool</em></p>
</body>
</html>
```

### Connect to private instances

We can connect to the private instances using the nat instance as Jump server:

```
ssh -J bastion@<NAT_INSTANCE_PUBLIC_IP> ubuntu@<INSTANCE_PRIVATE_IP>

Welcome to Ubuntu 20.04.4 LTS (GNU/Linux 5.11.0-1027-oracle aarch64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Thu Mar  3 14:34:39 UTC 2022

  System load:  0.0               Processes:               151
  Usage of /:   3.9% of 44.97GB   Users logged in:         0
  Memory usage: 4%                IPv4 address for enp0s3: 10.0.1.239
  Swap usage:   0%


7 updates can be applied immediately.
7 of these updates are standard security updates.
To see these additional updates run: apt list --upgradable


*** System restart required ***
Last login: Thu Mar  3 14:34:20 2022 from 10.0.0.37
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

ubuntu@inst-a73cs-ubuntu-instance-pool:~$
```

### Start a project from scratch

If you want to create a new project from scratch you need three files:

* terraform.tfvars - More details in [Oracle provider setup](../README.md#oracle-provider-setup)
* main.tf - download main.tf file or main.tf-public based on your needs. If you choose main.tf-public **remember** to rename the file in main.tf
* provider.tf - download the file from this directory

### Cleanup

```
terraform destroy
```