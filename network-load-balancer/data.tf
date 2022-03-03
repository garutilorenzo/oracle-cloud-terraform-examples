data "oci_core_instance_pool_instances" "ubuntu_instance_pool_instances" {
  compartment_id   = var.compartment_ocid
  instance_pool_id = var.instance_pool_id
}

data "oci_core_instance" "ubuntu_instance_pool_instances_ips" {
  count       = var.instance_pool_size
  instance_id = data.oci_core_instance_pool_instances.ubuntu_instance_pool_instances.instances[count.index].id
}