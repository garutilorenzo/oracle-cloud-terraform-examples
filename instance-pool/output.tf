output "instances_ips" {
  depends_on = [
    data.oci_core_instance_pool_instances.ubuntu_instance_pool_instances,
  ]
  value = var.is_private == true ? data.oci_core_instance.ubuntu_instance_pool_instances_ips.*.private_ip : data.oci_core_instance.ubuntu_instance_pool_instances_ips.*.public_ip
}

output "instance_pool_id" {
  value = oci_core_instance_pool.ubuntu_instance_pool.id
}

output "instance_pool_size" {
  value = oci_core_instance_pool.ubuntu_instance_pool.size
}