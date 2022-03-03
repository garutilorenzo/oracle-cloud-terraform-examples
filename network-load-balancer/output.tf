output "lb_ip" {
  value = oci_network_load_balancer_network_load_balancer.load_balancer_l4.ip_addresses
}