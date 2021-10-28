output "instance_ip" {
  value = oci_core_instance.ubuntu_oci_instance.public_ip
}