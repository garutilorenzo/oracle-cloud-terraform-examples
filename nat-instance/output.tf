output "nat_instance_id" {
  value = oci_core_instance.nat_instance.id
}

output "nat_instance_public_ip" {
  value = oci_core_instance.nat_instance.public_ip
}