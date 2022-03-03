output "lb_ip" {
  value = oci_load_balancer_load_balancer.load_balancer_l7.ip_addresses
}