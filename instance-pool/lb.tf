resource "oci_network_load_balancer_network_load_balancer" "test_network_load_balancer" {
  depends_on = [
    oci_core_instance_pool.ubuntu_instance_pool,
  ]

  compartment_id = var.compartment_ocid
  display_name   = "Test Network LB"
  subnet_id      = oci_core_subnet.oci_core_subnet11.id

  is_private                     = false
  is_preserve_source_destination = false

  freeform_tags = {
    "${var.tutorial_tag_key}" = "${var.tutorial_tag_value}"
  }
}

resource "oci_network_load_balancer_listener" "test_listener" {
  #Required
  default_backend_set_name = oci_network_load_balancer_backend_set.test_backend_set.name
  name                     = "LB test listener"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.test_network_load_balancer.id
  port                     = 80
  protocol                 = "TCP"
}

resource "oci_network_load_balancer_backend_set" "test_backend_set" {
  health_checker {
    protocol = "TCP"
    port     = 80
  }

  name                     = "Backend set test"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.test_network_load_balancer.id
  policy                   = "FIVE_TUPLE"
  is_preserve_source       = true
}

resource "oci_network_load_balancer_backend" "test_backend" {
  depends_on = [
    oci_core_instance_pool.ubuntu_instance_pool,
  ]

  count                    = var.instance_pool_size
  backend_set_name         = oci_network_load_balancer_backend_set.test_backend_set.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.test_network_load_balancer.id
  port                     = 80

  target_id = data.oci_core_instance_pool_instances.ubuntu_instance_pool_instances.instances[count.index].id
}