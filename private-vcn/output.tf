output "vcn_id" {
  value = oci_core_vcn.default_oci_core_vcn.id
}

output "public_subnet_id" {
  value = oci_core_subnet.default_oci_core_subnet10.id
}

output "private_subnet_id" {
  value = oci_core_subnet.oci_core_subnet11.id
}

output "security_list_id" {
  value = oci_core_default_security_list.default_security_list.id
}

output "public_subnet_cidr" {
  value = oci_core_subnet.default_oci_core_subnet10.cidr_block
}