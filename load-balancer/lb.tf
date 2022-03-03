resource "oci_load_balancer_load_balancer" "load_balancer_l7" {
  compartment_id             = var.compartment_ocid
  display_name               = "LB Layer 7"
  shape                      = var.lb_shape
  subnet_ids                 = [var.public_subnet_id]
  network_security_group_ids = [oci_core_network_security_group.public_lb_nsg.id]

  ip_mode    = "IPV4"
  is_private = var.is_private

  shape_details {
    maximum_bandwidth_in_mbps = 10
    minimum_bandwidth_in_mbps = 10
  }

  freeform_tags = local.tags
}

# HTTP 
resource "oci_load_balancer_listener" "http_listener" {
  default_backend_set_name = oci_load_balancer_backend_set.http_backend_set.name
  load_balancer_id         = oci_load_balancer_load_balancer.load_balancer_l7.id
  name                     = "http_listener"
  port                     = 80
  protocol                 = "HTTP"
}

resource "oci_load_balancer_backend_set" "http_backend_set" {
  health_checker {
    protocol    = "HTTP"
    port        = 80
    url_path    = "/"
    return_code = 200
  }

  load_balancer_id = oci_load_balancer_load_balancer.load_balancer_l7.id
  name             = "http_backend_set"
  policy           = "ROUND_ROBIN"
}

resource "oci_load_balancer_backend" "http_backend" {
  count            = var.instance_pool_size
  backendset_name  = oci_load_balancer_backend_set.http_backend_set.name
  ip_address       = data.oci_core_instance.ubuntu_instance_pool_instances_ips[count.index].private_ip
  load_balancer_id = oci_load_balancer_load_balancer.load_balancer_l7.id
  port             = 80
}