resource "oci_core_instance" "ubuntu_oci_instance" {
  agent_config {
    is_management_disabled = "false"
    is_monitoring_disabled = "false"

    plugins_config {
      desired_state = "DISABLED"
      name          = "Vulnerability Scanning"
    }

    plugins_config {
      desired_state = "ENABLED"
      name          = "Compute Instance Monitoring"
    }

    plugins_config {
      desired_state = "DISABLED"
      name          = "Bastion"
    }
  }

  availability_config {
    recovery_action = "RESTORE_INSTANCE"
  }

  availability_domain = var.availability_domain
  compartment_id      = var.compartment_ocid
  fault_domain        = var.default_fault_domain

  create_vnic_details {
    assign_private_dns_record = true
    assign_public_ip          = var.is_private == true ? false : true
    subnet_id                 = var.is_private == true ? var.private_subnet_id : var.public_subnet_id
  }

  display_name = "Ubuntu Instance"

  instance_options {
    are_legacy_imds_endpoints_disabled = false
  }

  is_pv_encryption_in_transit_enabled = true

  metadata = {
    "ssh_authorized_keys" = file(var.PATH_TO_PUBLIC_KEY)
    "user_data"           = data.cloudinit_config.ubuntu_init.rendered
  }

  shape = var.shape
  shape_config {
    memory_in_gbs = var.memory_in_gbs
    ocpus         = var.ocpus
  }

  source_details {
    source_id   = var.os_image_id
    source_type = "image"
  }

  freeform_tags = local.tags
}