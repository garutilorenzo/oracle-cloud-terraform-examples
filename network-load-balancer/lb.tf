resource "oci_network_load_balancer_network_load_balancer" "load_balancer_l4" {
  compartment_id = var.compartment_ocid
  display_name   = "Network LB Layer 4"
  subnet_id      = var.private_subnet_id

  is_private                     = var.is_private
  is_preserve_source_destination = false

  freeform_tags = local.tags
}

resource "oci_network_load_balancer_listener" "http_listener_l4" {
  default_backend_set_name = oci_network_load_balancer_backend_set.http_backend_set_l4.name
  name                     = "LB test listener"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.load_balancer_l4.id
  port                     = 80
  protocol                 = "TCP"
}

resource "oci_network_load_balancer_backend_set" "http_backend_set_l4" {
  health_checker {
    protocol = "TCP"
    port     = 80
  }

  name                     = "Backend set test"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.load_balancer_l4.id
  policy                   = "FIVE_TUPLE"
  is_preserve_source       = true
}

resource "oci_network_load_balancer_backend" "http_backend_l4" {
  count                    = var.instance_pool_size
  backend_set_name         = oci_network_load_balancer_backend_set.http_backend_set_l4.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.load_balancer_l4.id
  port                     = 80

  target_id = data.oci_core_instance_pool_instances.ubuntu_instance_pool_instances.instances[count.index].id
}