# NAT instance

This module will deploy a NAT instance. If you use a private subnet with an always free account you will need a nat instance to give internet access to the private subnet. With the always free account you can't use/deploy a NAT gateway.

Also this module will setup a new route table and will attach this new route to the private subnet.

### Requirements

* One vcn with a public or private subnet (simple-vcn or private-vcn module)

### Module variables

| Var   | Required | Desc |
| ------- | ------- | ----------- |
| `region`       | `yes`       | set the correct OCI region based on your needs  |
| `availability_domain` | `yes`        | Set the correct availability domain. See [how](../README.md#how-to-find-the-availability-doamin-name) to find the availability domain|
| `compartment_ocid` | `yes`        | Set the correct compartment ocid. See [how](../README.md#oracle-provider-setup) to find the compartment ocid |
| `vcn_id`  | `yes`  | The VCN OCID |
| `private_subnet_id` | `yes`        | Private subnet OCID |
| `public_subnet_id` | `yes`        | Public subnet OCID |
| `default_fault_domain`  | `no`  | Fault domain where the instance will be deployed. Default: FAULT-DOMAIN-1 |
| `PATH_TO_PUBLIC_KEY` | `no`        | Path to your public ssh key (Default: "~/.ssh/id_rsa.pub) |
| `os_image_id`  | `no`  | OS image OCID. Default: ocid1.image.oc1.eu-zurich-1.aaaaaaaag2uyozo7266bmg26j5ixvi42jhaujso2pddpsigtib6vfnqy5f6q - Canonical-Ubuntu-20.04-aarch64-2022.01.18-0 |
| `setup_bastion`  | `no`  | Bool variable. Setup the nat instance as bastion host. Default: true |
| `bastion_user`  | `no`  | Bastion username. Default: bastion |
| `bastion_group`  | `no`  | Bastion group. Default: bastion |
| `ssh_keys_path`  | `no`  | List of ssh keys allowed to connect to the nat instance as bastion user. Default: ["~/.ssh/id_rsa.pub"] |


### Output

The module will output:

* nat_instance_id, NAT instance OCID
* nat_instance_public_ip, NAT instance public ip