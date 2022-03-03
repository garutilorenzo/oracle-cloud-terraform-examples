# VCN with two public subnets

This module will deploy a one VCN with two public subnets. Also this modules deploy a security list with the following rueles:

* egress, all traffic allowed
* ingress, traffica allowed on port 22 only from *my_public_ip_cidr*

### Requirements

No Requirement

### Module variables

| Var   | Required | Desc |
| ------- | ------- | ----------- |
| `region`       | `yes`       | set the correct OCI region based on your needs  |
| `compartment_ocid` | `yes`        | Set the correct compartment ocid. See [how](../README.md#oracle-provider-setup) to find the compartment ocid |
| `my_public_ip_cidr` | `yes`        | A public ip CIDR allowed to reach the OCI resources |
| `environment`  | `yes`  | Current work environment (Example: staging/dev/prod). This value is used for tag all the deployed resources |
| `oci_core_vcn_dns_label`  | `no`  | VCN DNS label. Default: defaultvcn |
| `oci_core_subnet_dns_label10`  | `no`  | First subnet DNS label. Default: publicsubnet10 |
| `oci_core_subnet_dns_label11`  | `no`  | Second subnet DNS label. Default: publicsubnet11 |
| `oci_core_vcn_cidr`  | `no`  | VCN CIDR. Default: 10.0.0.0/16 |
| `oci_core_subnet_cidr10`  | `no`  | First subnet CIDR. Default: 10.0.0.0/24 |
| `oci_core_subnet_cidr11`  | `no`  | Second subnet CIDR. Default: 10.0.1.0/24 |

### Output

The module will output:

* vcn_id, the VCN OCID
* public_subnet_id, the public subnet OCID
* secondary_public_subnet_id, the secondary public subnet OCID
* security_list_id, the security list OCID
* public_subnet_cidr, the public subnet CIDR