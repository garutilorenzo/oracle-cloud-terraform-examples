resource "oci_core_instance_configuration" "ubuntu_template" {

  compartment_id = var.compartment_ocid
  display_name   = "Ubuntu 20.04 instance config"
  freeform_tags = {
    "${var.tutorial_tag_key}" = "${var.tutorial_tag_value}"
  }
  instance_details {

    instance_type = "compute"

    launch_details {

      #Optional
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

      availability_domain = var.availability_domain
      compartment_id      = var.compartment_ocid

      create_vnic_details {
        assign_public_ip = true
        subnet_id        = oci_core_subnet.default_oci_core_subnet10.id
      }

      display_name = "Ubuntu Template"

      metadata = {
        "ssh_authorized_keys" = file(var.PATH_TO_PUBLIC_KEY)
        "user_data"           = data.template_cloudinit_config.ubuntu_init.rendered
      }

      shape = "VM.Standard.A1.Flex"
      shape_config {
        memory_in_gbs = "6"
        ocpus         = "1"
      }
      source_details {
        image_id    = var.os_image_id
        source_type = "image"
      }
    }
  }
}