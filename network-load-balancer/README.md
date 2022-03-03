# Network load balancer (Layer 4)

This module will deploy a Network Load Balancer (L4). The LB can be public or private (*is_private* variable). The LB will be attached to the instances in a instance pool (*instance_pool_id* variable).

### Requirements

* One vcn with a public or private subnet (simple-vcn or private-vcn module)

### Module variables

| Var   | Required | Desc |
| ------- | ------- | ----------- |
| `region`       | `yes`       | set the correct OCI region based on your needs  |
| `compartment_ocid` | `yes`        | Set the correct compartment ocid. See [how](../README.md#oracle-provider-setup) to find the compartment ocid |
| `vcn_id`  | `yes`  | The VCN OCID |
| `private_subnet_id` | `yes`        | Private subnet OCID |
| `public_subnet_id` | `yes`        | Public subnet OCID |
| `instance_pool_size` | `yes`        | Instance pool size |
| `instance_pool_id` | `yes`        | Instance pool ocid OCID |
| `is_private`  | `no`  | Bool value. If true the LB will be a private LB (no public ip) Default: true |

### Output

lb_ip, LB public or private ip address