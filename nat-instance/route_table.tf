resource "oci_core_route_table" "nat_instance_route_table" {

  depends_on = [
    oci_core_instance.nat_instance
  ]

  compartment_id = var.compartment_ocid
  vcn_id         = var.vcn_id
  display_name   = "NAT instance route table"

  route_rules {
    network_entity_id = data.oci_core_private_ips.nat_instance_private_ips_by_nic.private_ips[0].id

    description      = "Route internet traffic via nat instance"
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
  }
}

resource "oci_core_route_table_attachment" "attach_route_table" {
  subnet_id      = var.private_subnet_id
  route_table_id = oci_core_route_table.nat_instance_route_table.id
}