data "template_cloudinit_config" "nat_instance_init" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = templatefile("${path.module}/files/cloud-config-base.yaml", {})
  }

  part {
    content_type = "text/x-shellscript"
    content      = templatefile("${path.module}/files/setup_bastion.sh", { ssh_keys = local.ssh_keys, setup_bastion = var.setup_bastion, bastion_user = var.bastion_user, bastion_group = var.bastion_group })
  }
}

data "oci_core_vnic_attachments" "nat_instance_vnics" {
  depends_on = [
    oci_core_instance.nat_instance
  ]

  compartment_id      = var.compartment_ocid
  availability_domain = var.availability_domain
  instance_id         = oci_core_instance.nat_instance.id
}

data "oci_core_private_ips" "nat_instance_private_ips_by_nic" {
  depends_on = [
    oci_core_instance.nat_instance
  ]
  ip_address = oci_core_instance.nat_instance.private_ip
  subnet_id  = var.public_subnet_id
  vnic_id    = data.oci_core_vnic_attachments.nat_instance_vnics.vnic_id
}