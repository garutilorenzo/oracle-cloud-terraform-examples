output "instance_ip" {
  value = var.is_private == true ? oci_core_instance.ubuntu_oci_instance.private_ip : oci_core_instance.ubuntu_oci_instance.public_ip
}