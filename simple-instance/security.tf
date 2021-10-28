resource "oci_core_default_security_list" "default_security_list" {
  compartment_id             = var.compartment_ocid
  manage_default_resource_id = oci_core_vcn.default_oci_core_vcn.default_security_list_id

  display_name = "Default security list"
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }

  ingress_security_rules {
    protocol = 1 # icmp
    source   = var.my_public_ip_address

    description = "Allow icmp from ${var.my_public_ip_address}"

  }

  ingress_security_rules {
    protocol = 6 # tcp
    source   = var.my_public_ip_address

    description = "Allow SSH from ${var.my_public_ip_address}"

    tcp_options {
      min = 22
      max = 22
    }
  }

  ingress_security_rules {
    protocol = 6 # tcp
    source   = var.my_public_ip_address

    description = "Allow HTTP from ${var.my_public_ip_address}"

    tcp_options {
      min = 80
      max = 80
    }
  }

  ingress_security_rules {
    protocol = "all"
    source   = var.oci_core_vcn_cidr

    description = "Allow all from vcn subnet"
  }

  freeform_tags = {
    "${var.tutorial_tag_key}" = "${var.tutorial_tag_value}"
  }
}

resource "oci_core_security_list" "custom_security_list" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.default_oci_core_vcn.id

  display_name = "Custom security list"

  ingress_security_rules {
    protocol = 6 # tcp
    source   = "0.0.0.0/0"

    description = "Allow HTTP from all"

    tcp_options {
      min = 80
      max = 80
    }
  }

  freeform_tags = {
    "${var.tutorial_tag_key}" = "${var.tutorial_tag_value}"
  }
}