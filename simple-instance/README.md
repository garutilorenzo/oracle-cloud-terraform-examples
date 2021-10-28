# Simple compute instance

This example will deploy a single Oracle compute instance. 

### Extra variables

In this example an extra variable is used:

* fault_domain, this variable indicate in which fault domain our instance will be launched

### Deploy

To deploy the infrastructure:

```
terraform init

terraform plan

terraform apply
```

wait terraform to complete the operation, when terraform successfully finished the deployment you will see in the output the public ip address of the instance:

```
Apply complete! Resources: 8 added, 0 changed, 0 destroyed.

Outputs:

instance_ip = "152.x.x.x"
```

now you can ssh into the machine:

```
ssh ubuntu@152.x.x.x

...
35 updates can be applied immediately.
25 of these updates are standard security updates.
To see these additional updates run: apt list --upgradable



The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

ubuntu@ubuntu-instance:~$ 
```

### Cleanup

```
terraform destroy
```