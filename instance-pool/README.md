# Instance pool

This module will deploy an Instance pool made by two compute instances. Also this module will create one instance configuration used by the instance pool.

If you choose to publish this compute instances in a private subnet, you need a NAT instance (refer to nat-instance module). The nat instance can be used also as bation host to reach the private instance, or if you prefer you can deploy a dedicated bastion host (refer to bastion-host module).

### Requirements

* One vcn with a public or private subnet (simple-vcn or private-vcn module)
* One nat instance if the instance pool *is_private* (nat-instance module)

### Module variables

| Var   | Required | Desc |
| ------- | ------- | ----------- |
| `region`       | `yes`       | set the correct OCI region based on your needs  |
| `availability_domain` | `yes`        | Set the correct availability domain. See [how](../README.md#how-to-find-the-availability-doamin-name) to find the availability domain|
| `compartment_ocid` | `yes`        | Set the correct compartment ocid. See [how](../README.md#oracle-provider-setup) to find the compartment ocid |
| `environment`  | `yes`  | Current work environment (Example: staging/dev/prod). This value is used for tag all the deployed resources |
| `private_subnet_id`  | `yes`  | Private subnet OCID |
| `public_subnet_id`  | `yes`  | Public subnet OCID |
| `public_subnet_cidr`  | `yes`  | Public subnet CIDR |
| `instance_pool_size`  | `no`  | Number of instances in the instance pool. Default: 2 |
| `fault_domains`  | `no`  | Fault list. Default: FAULT-DOMAIN-1, FAULT-DOMAIN-2, FAULT-DOMAIN-3 |
| `PATH_TO_PUBLIC_KEY` | `no`        | Path to your public ssh key (Default: "~/.ssh/id_rsa.pub) |
| `is_private`  | `no`  | Bool value. If true the instance pool will be deployed in a private subnet. Default: false |
| `os_image_id`  | `no`  | OS image OCID. Default: ocid1.image.oc1.eu-zurich-1.aaaaaaaag2uyozo7266bmg26j5ixvi42jhaujso2pddpsigtib6vfnqy5f6q - Canonical-Ubuntu-20.04-aarch64-2022.01.18-0 |

### Output

The module will output:

* instances_ips, IPs of the instances
* instance_pool_id, Instance pool OCID