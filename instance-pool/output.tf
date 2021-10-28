output "instances_ips" {
  depends_on = [
    data.oci_core_instance_pool_instances.ubuntu_instance_pool_instances,
  ]
  value = data.oci_core_instance.ubuntu_instance_pool_instances_ips.*.private_ip
}

output "lb_ip" {
  value = oci_network_load_balancer_network_load_balancer.test_network_load_balancer.ip_addresses
}