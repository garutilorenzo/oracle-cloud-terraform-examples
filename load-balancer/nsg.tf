resource "oci_core_network_security_group" "public_lb_nsg" {
  compartment_id = var.compartment_ocid
  vcn_id         = var.vcn_id
  display_name   = "Public LB nsg"

  freeform_tags = local.tags
}

resource "oci_core_network_security_group_security_rule" "allow_http_from_all" {
  network_security_group_id = oci_core_network_security_group.public_lb_nsg.id
  direction                 = "INGRESS"
  protocol                  = 6 # tcp

  description = "Allow HTTP from all"

  source      = "0.0.0.0/0"
  source_type = "CIDR_BLOCK"
  stateless   = false

  tcp_options {
    destination_port_range {
      max = 80
      min = 80
    }
  }
}