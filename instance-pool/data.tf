data "template_cloudinit_config" "ubuntu_init" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = templatefile("${path.module}/files/oci-ubuntu-install.sh", { public_subnet_cidr = var.public_subnet_cidr })
  }
}

data "oci_core_instance_pool_instances" "ubuntu_instance_pool_instances" {
  depends_on = [
    oci_core_instance_pool.ubuntu_instance_pool,
  ]
  compartment_id   = var.compartment_ocid
  instance_pool_id = oci_core_instance_pool.ubuntu_instance_pool.id
}

data "oci_core_instance" "ubuntu_instance_pool_instances_ips" {
  count       = var.instance_pool_size
  instance_id = data.oci_core_instance_pool_instances.ubuntu_instance_pool_instances.instances[count.index].id
}